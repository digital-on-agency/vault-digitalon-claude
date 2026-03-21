<!-- ultimo aggiornamento: 2026-03-21 -->

# PDF Generator

## Overview

Python-based PDF generation process using **ReportLab** for precise, coordinate-driven layout control. Includes workflow for uploading to **Google Cloud Storage** and generating **signed URLs** for secure, temporary access.

## Setup

### Required Libraries

```bash
pip install reportlab    # PDF generation with absolute coordinates
pip install segno        # QR code generation (pure Python)
pip install google-cloud-storage  # Google Cloud Storage client
```

### Environment Variables

```python
GOOGLE_APPLICATION_CREDENTIALS = "/path/to/key.json"
GCS_BUCKET_NAME = "your-gcs-bucket-name"
```

- [How to get Google Application Credentials](https://developers.google.com/workspace/guides/create-credentials)
- [Create a GCS bucket](https://cloud.google.com/storage/docs/creating-buckets)

## Workflow

### Helper — Unit Conversion

```python
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from reportlab.lib.units import mm
import segno, io

def mm_to_pt(x): return x * mm  # 1 mm ≈ 2.83465 pt
```

### PDF Generator Function

```python
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen.canvas import Canvas
from reportlab.lib.utils import ImageReader
from reportlab.lib.units import mm
import tempfile, os, io

PAGE_W, PAGE_H = A4  # (595 x 842 pt)

def generate_pdf_with_bg(bg_path, full_name, user_id, user_note, target_url, coords):
    """
    coords = {
        "name": {"x": 28, "y": 255, "size_pt": 16},
        "note": {"x": 28, "y": 245, "size_pt": 11},
        "id":   {"x": 28, "y": 235, "size_pt": 10},
        "qr":   {"x": 150, "y": 65, "size_mm": 35}
    }
    Y is from bottom in ReportLab!
    """
    buf = io.BytesIO()
    c = Canvas(buf, pagesize=A4)

    # Full-page background
    bg = ImageReader(bg_path)
    c.drawImage(bg, 0, 0, width=PAGE_W, height=PAGE_H)

    # Text helper
    def draw_text(text, x_mm, y_mm, size_pt=12):
        c.setFont("Helvetica", size_pt)
        c.drawString(x_mm * mm, y_mm * mm, text)

    draw_text(full_name, coords["name"]["x"], coords["name"]["y"], coords["name"]["size_pt"])
    draw_text(user_note, coords["note"]["x"], coords["note"]["y"], coords["note"]["size_pt"])
    draw_text(f"ID: {user_id}", coords["id"]["x"], coords["id"]["y"], coords["id"]["size_pt"])

    # QR Code
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as tmp:
        segno.make(target_url).save(tmp.name, scale=6, border=2)
        qr_img = ImageReader(tmp.name)
        size_pt = coords["qr"]["size_mm"] * mm
        c.drawImage(qr_img, coords["qr"]["x"]*mm, coords["qr"]["y"]*mm,
                    width=size_pt, height=size_pt, preserveAspectRatio=True, mask='auto')
    try: os.remove(tmp.name)
    except: pass

    c.showPage()
    c.save()
    return buf.getvalue()
```

### Upload to Google Cloud Storage

```python
from datetime import timedelta
from google.cloud import storage
from google.oauth2 import service_account

def upload_pdf_and_get_url(pdf_bytes, object_name, expire_minutes=60):
    creds = service_account.Credentials.from_service_account_file(GOOGLE_APPLICATION_CREDENTIALS)
    client = storage.Client(project=creds.project_id, credentials=creds)
    bucket = client.bucket(GCS_BUCKET_NAME)
    blob = bucket.blob(object_name)
    blob.upload_from_string(pdf_bytes, content_type="application/pdf")

    url = blob.generate_signed_url(
        version="v4",
        method="GET",
        expiration=timedelta(minutes=expire_minutes),
        credentials=creds,
        response_disposition=f'attachment; filename="{os.path.basename(object_name)}"'
    )
    return url
```

### Caller Example

```python
from datetime import datetime, timezone

pdf_data = generate_pdf_with_bg(
    bg_path="/path/to/background_a4.png",
    full_name="John Doe",
    user_id="USER-0001",
    user_note="Optional note",
    target_url="https://example.com/qr-target",
    coords={
        "name": {"x": 20, "y": 220, "size_pt": 42},
        "note": {"x": 20, "y": 194, "size_pt": 28},
        "id":   {"x": 20, "y": 172, "size_pt": 28},
        "qr":   {"x": 60, "y": 20, "size_mm": 80}
    }
)

# Save locally
with open("/path/to/output.pdf", "wb") as f:
    f.write(pdf_data)

# Upload to GCS
safe_name = "John_Doe"
timestamp = datetime.now(timezone.utc).strftime("%Y%m%d-%H%M%S")
object_name = f"documents/{safe_name}_USER-0001_{timestamp}.pdf"
download_url = upload_pdf_and_get_url(pdf_data, object_name, expire_minutes=60)
```

## Note e benchmark

- Keep `coords` in a config file (JSON/YAML) per template for reuse with different layouts
- Y coordinate is measured from the bottom in ReportLab
- A4 page size: 595 x 842 pt
- Signed URLs provide secure, temporary access without public bucket permissions
