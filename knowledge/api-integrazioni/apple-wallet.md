<!-- ultimo aggiornamento: 2026-03-21 -->

# Apple Wallet Passes

## Overview

Guide to generating Apple Wallet Passes using the official Apple API. Covers creating pass source files, building signed bundles, and distributing `.pkpass` files.

## Setup

### Pass Source Structure

Each pass is defined in a directory named `[PassName].pass` containing:
- **`pass.json`** — metadata, field definitions, display strings ([Pass Object docs](https://developer.apple.com/documentation/walletpasses/pass))
- **`icon.png`** (+ `icon@2x.png`, `icon@3x.png`) — for notifications, email, lock screen
- Optional: `logo.png`, `background.png`, localization folders (`.lproj`)

Example:
```
simple.pass/
├── icon.png
├── icon@2x.png
├── pass.json
├── en.lproj/
│   ├── logo.png
│   └── pass.strings
└── zh-Hans.lproj/
    ├── logo.png
    └── pass.strings
```

### pass.json — Required Fields

```json
{
  "description": "Pass description",
  "formatVersion": 1,
  "organizationName": "Your Organization",
  "passTypeIdentifier": "pass.com.example.type",
  "serialNumber": "unique-serial",
  "teamIdentifier": "XXXXXXXXXX"
}
```

### Localization (Optional)

Create subdirectories `[language]-[region].lproj` (e.g., `en.lproj`, `zh-Hans.lproj`).

In `pass.json`, use keys instead of literal strings:
```json
"primaryFields": [
  { "key": "offer", "value": "OfferAmount", "label": "OfferAmountLabel" }
]
```

In `pass.strings`:
```
"OfferAmount" = "100% off";
"OfferAmountLabel" = "Anything you want!";
```

Non-ASCII text must use **UTF-16 encoding**.

## Workflow

### Building a Pass

1. **Prepare source files** (see Setup)
2. **Create Pass Type Identifier** in [Apple Developer account](https://developer.apple.com/account) → Identifiers → Pass Type IDs (reverse-DNS format: `com.example.passes.membership`)
3. **Generate signing certificate** → Certificates → Pass Type ID Certificate, upload CSR
4. **Sign and package:**
   - Generate `manifest.json` (file paths → SHA1 hashes)
   - Extract private key from `.p12`:
     ```bash
     openssl pkcs12 -in private-key.p12 -out privatekey.pem -nocerts -nodes
     ```
   - Extract certificate:
     ```bash
     openssl x509 -in pass-certificate.cer -out pass-certificate.pem -outform PEM
     ```
   - Combine:
     ```bash
     cat privatekey.pem cert.pem > combined.pem
     ```
   - Sign manifest:
     ```bash
     openssl smime -sign -in manifest.json -out signature -signer combined.pem -inkey privatekey.pem -certfile pass-certificate.cer
     ```
   - ZIP directory, rename to `.pkpass`
5. **Test:** drop `.pkpass` onto iPhone Simulator

### Distribution

Three channels:
1. **App/App Clip:** `PKAddPassButton` → `PKAddPassesViewController`
2. **Web page:** downloadable `.pkpass` link with "Add to Apple Wallet" button
3. **Email:** `.pkpass` as attachment

**Updating:** issue new version with same `passTypeIdentifier` + `serialNumber` — auto-replaces on all devices.

**Bundling:** ZIP multiple `.pkpass` → rename to `.pkpasses` (max 10 passes, 150 MB, MIME: `application/vnd.apple.pkpasses`)

## Errori comuni

- `pass.json` missing required keys
- `passTypeIdentifier` / `teamIdentifier` mismatch with signing certificate
- Certificate invalid or missing on signing machine
- `manifest.json` doesn't list all files (including subdirectories)
- Missing images or wrong formats
- Invalid JSON syntax in `pass.json` or `manifest.json`
- Dates not in ISO 8601 format
- Localization folder naming incorrect
- Localized string keys mismatch between `pass.json` and `pass.strings`
