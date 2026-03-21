<!-- ultimo aggiornamento: 2026-03-21 -->

# Google Wallet API

## Overview

[Official Documentation](https://developers.google.com/wallet/tickets/events?authuser=1)

The **Google Wallet API** allows creating and issuing passes for users to save in their Google Wallets. Key concepts:

- **Pass Issuer:** entity that owns and issues passes
- **Passes Class:** shared template defining common properties (style, appearance)
- **Passes Object:** individual pass instance with user-specific information (seat number, QR code)
- **Pass:** an instance of a Passes Object saved in a user's Google Wallet
- **Service Account:** identity used to call the Google Wallet API

A Passes Class defines the template; a Passes Object defines the specific pass. Each must have a unique ID.

### Adding a pass to a user's Google Wallet

1. Create a JWT containing claims about the Passes Object
2. Deliver via 'Add to Google Wallet' button or link
3. When user clicks, the Passes Object is linked to their Google account
4. Duplicate copies won't be added; removed passes can be re-added

## Setup

### Requirements

**Python libraries:**
```bash
pip install google-api-python-client
pip install google-auth
pip install google-auth-httplib2 google-auth-oauthlib
```

**Environment Variables:**
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/key.json"
```

**Google Cloud Setup:**
- Enable Google Wallet API in Google Cloud project
- Create service account with `Wallet Objects Editor` or `Wallet Objects Admin` role
- Invite service account email to Issuer account in Google Pay & Wallet Console
- Note your **Issuer ID**

### Project Variables

```python
ISSUER_ID = "your-issuer-id"
CLASS_SUFFIX = "unique-name-for-the-class"
CLASS_ID = f"{ISSUER_ID}.{CLASS_SUFFIX}"
```

### Authentication

```python
from googleapiclient.discovery import build
from google.oauth2.service_account import Credentials

class DemoGeneric:
    def __init__(self):
        self.key_file_path = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS', '/path/for/key.json')
        self.auth()

    def auth(self):
        self.credentials = Credentials.from_service_account_file(
            self.key_file_path,
            scopes=['https://www.googleapis.com/auth/wallet_object.issuer'])
        self.client = build('walletobjects', 'v1', credentials=self.credentials)
```

## Workflow

### Development Flow

1. **Create a Passes Class** — defines common properties (event name, date, time). Created via REST API, Android SDK, or Google Wallet Business Console.
2. **Create a Passes Object** — defines unique pass properties (seat number, QR code). Created via REST API or Android SDK.
3. **Encode in JWT** — encode Class and Object in a JSON Web Token
4. **Sign the JWT** — with service account key (REST API) or SHA-1 fingerprint (Android SDK)
5. **Issue the pass** — via 'Add to Google Wallet' button or link: `https://pay.google.com/gp/v/save/<signed_jwt>`

### Create a Passes Object

```python
def create_object(self, issuer_id, class_suffix, object_suffix):
    try:
        self.client.genericobject().get(resourceId=f'{issuer_id}.{object_suffix}').execute()
    except HttpError as e:
        if e.resp.status != 404:
            return f'{issuer_id}.{object_suffix}'

    new_object = {
        'id': f'{issuer_id}.{object_suffix}',
        'classId': f'{issuer_id}.{class_suffix}',
        'state': 'ACTIVE',
        'barcode': {
            'type': 'QR_CODE',
            'value': 'https://example.com',
        },
        'cardTitle': {'defaultValue': {'language': 'en-US', 'value': 'Title'}},
        'header': {'defaultValue': {'language': 'en-US', 'value': 'Header'}},
        'hexBackgroundColor': '#ff3131',
    }

    response = self.client.genericobject().insert(body=new_object).execute()
    return f'{issuer_id}.{object_suffix}'
```

### Create Save-to-Wallet Link

```python
from google.oauth2 import service_account
from google.auth import crypt, jwt as ga_jwt

def create_jwt(self, key_path, issuer_id, object_suffix):
    creds = service_account.Credentials.from_service_account_file(key_path)
    sa_email = creds.service_account_email
    object_id = f"{issuer_id}.{object_suffix}"

    claims = {
        "iss": sa_email,
        "aud": "google",
        "typ": "savetowallet",
        "payload": {
            "genericObjects": [{"id": object_id}]
        }
    }

    signer = crypt.RSASigner.from_service_account_file(key_path)
    signed_jwt = ga_jwt.encode(signer, claims).decode("utf-8")
    return f"https://pay.google.com/gp/v/save/{signed_jwt}"
```

## Configurazioni standard

### Key Terminology

- **Google Wallet REST API:** HTTP interface for creating/managing passes programmatically
- **Google Wallet Android SDK:** convenience methods for Android apps
- **JWT (JSON Web Token):** securely transfers pass information, signed with service account key
- **Service Account Key:** credential for authenticating REST API calls (highly sensitive)
- **'Add to Google Wallet' button:** Google-approved UI asset
- **'Add to Google Wallet' link:** `https://pay.google.com/gp/v/save/<signed_jwt>`
- **Demo Mode:** passes only issued to Admin/Developer roles or test accounts until publishing access is granted
- **Publishing Access:** requires at least one Passes Class and complete business profile
- **Smart Tap:** Google proprietary NFC protocol for pass redemption

## Note e benchmark

- Classes and Objects can be created in advance via REST API or "just in time" by embedding JSON in the JWT
- If a user removes a pass, the Object is de-linked but not deleted — user can re-add without creating a new Object
- Always protect service account keys — they grant full issuer access
