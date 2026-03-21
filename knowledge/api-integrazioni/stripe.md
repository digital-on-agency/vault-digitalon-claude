<!-- ultimo aggiornamento: 2026-03-21 -->

# Stripe API

## Overview

Stripe API integration for payment processing. Covers email receipts, paid invoices, and checkout session configuration.

## Configurazioni standard

### Email Receipts and Paid Invoices

#### Automatically send receipts

Toggle **Successful payments** on in [Customer emails settings](https://dashboard.stripe.com/settings/emails). Receipts are only sent when a successful payment has been made.

#### Customize receipts

- **Branding:** Modify logo and colors in [Branding settings](https://dashboard.stripe.com/settings/branding) (max 512KB, ideally square 128x128px+, JPG/PNG/GIF)
- **Public information:** Specify contact info in [Public details settings](https://dashboard.stripe.com/settings/public)
- **Custom text:** Use `payment_intent_data.description` on the Checkout Session

#### Automatically send paid invoices

Invoices have more information than receipts. For subscriptions, Stripe generates invoices automatically. For one-time payments:

1. In [Customer emails settings](https://dashboard.stripe.com/settings/emails), select **Successful payments**
2. When creating a Checkout session, set `invoice_creation[enabled]` to `true`

**Node.js example:**
```js
const session = await stripe.checkout.sessions.create({
  mode: 'payment',
  invoice_creation: {
    enabled: true,
  },
  line_items: [
    {
      price: '{{ONE_TIME_PRICE_ID}}',
      quantity: 1,
    },
  ],
  success_url: 'https://example.com',
  cancel_url: 'https://example.com',
});
```

**Customizing invoices:**
```js
const session = await stripe.checkout.sessions.create({
  mode: 'payment',
  invoice_creation: {
    enabled: true,
    invoice_data: {
      description: 'Invoice for Product X',
      metadata: { order: 'order-xyz' },
      custom_fields: [{ name: 'Purchase Order', value: 'PO-XYZ' }],
      rendering_options: { amount_tax_display: 'include_inclusive_tax' },
      footer: 'B2B Inc.',
    },
  },
  line_items: [{ price: '{{ONE_TIME_PRICE_ID}}', quantity: 1 }],
  success_url: 'https://example.com',
  cancel_url: 'https://example.com',
});
```

After payment, Stripe sends an invoice summary email with links to download the invoice PDF and receipt.

View invoices in the [Dashboard](https://dashboard.stripe.com/invoices) or listen to `invoice.paid` events via event destinations.

## Note e benchmark

- `invoice_creation` is not supported with `payment_intent_data[capture_method]` set to `manual`
- Invoices for delayed notification payment methods (Bacs, SEPA, ACH, Boleto, etc.) may take longer
- Receipts pull data from the `Charge` object — to update receipt data after confirmation, update the Charge directly
- Invoice creation for one-time payments via Checkout is priced separately from Stripe Invoicing
