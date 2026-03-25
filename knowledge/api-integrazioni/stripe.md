<!-- ultimo aggiornamento: 2026-03-24 -->

# Stripe API

## Overview

Stripe API integration for payment processing. Covers authentication, metadata, API patterns, error handling, testing, e configurazione receipts/invoices.

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

## Autenticazione e API Keys

### Tipi di chiave

| Tipo | Prefisso | Dove usarla | Sicurezza |
|------|----------|-------------|-----------|
| **Secret** | `sk_test_` / `sk_live_` | Solo server-side. Env var o KMS. Mai esporre al client | Permette qualsiasi operazione API |
| **Publishable** | `pk_test_` / `pk_live_` | Client-side (Stripe.js, checkout form, mobile SDK) | Solo raccolta dati pagamento, non operazioni sensibili |
| **Restricted** | `rk_test_` / `rk_live_` | Microservizi con accesso limitato. Permessi granulari per risorsa (None/Read/Write) | Riduce blast radius se compromessa |

### Sandbox vs Live mode

- **Sandbox**: dati di test, nessun pagamento reale processato. Usare test API keys
- **Live mode**: pagamenti reali. La secret key live si può vedere **una sola volta** — salvarla immediatamente in KMS
- Oggetti di un mode non sono accessibili dall'altro
- Prima di andare live: sostituire tutte le chiavi test con live, verificare che nessuna test key sia in produzione

### Rotazione chiavi

**Quando ruotare**: chiave compromessa, chiave persa, policy aziendale, cambio personale.

**Come**:
1. Dashboard → API Keys → overflow menu (⋯) → Rotate key
2. Scegliere scadenza (immediata o schedulata)
3. Copiare la nuova chiave subito — non si può recuperare dopo
4. Aggiornare il codice con la nuova chiave
5. La nuova chiave è utilizzabile immediatamente, anche se la vecchia non è ancora scaduta

### Best practice sicurezza

- **KMS**: salvare secret keys in secret manager (non env file in repo)
- **No repo**: mai committare chiavi in source control — anche se rimossi, restano nella history
- **No embed**: mai incorporare secret keys in app mobile o frontend
- **IP restriction**: limitare le chiavi a range IP specifici (CIDR) dalla Dashboard
- **Accesso minimo**: usare restricted keys per microservizi con solo i permessi necessari
- **Audit**: monitorare API request logs regolarmente
- **Se compromessa**: Stripe notifica automaticamente se rileva leak; ruotare immediatamente

### Stripe-Context header

Per operazioni multi-account (es. Connect platform), usare `Stripe-Context` header per specificare su quale account operare senza cambiare API key.

## Metadata

### Cos'è e limiti

Metadata è un attributo key-value su oggetti Stripe per salvare informazioni custom (es. ID utente dal proprio sistema).

**Limiti**:
- Max **50** coppie key-value per oggetto
- Key: max **40** caratteri, no parentesi quadre `[]`
- Value: max **500** caratteri
- Mai salvare dati sensibili (carte, conti bancari)
- Stripe non usa metadata per autorizzare/rifiutare pagamenti (tranne Radar)
- Metadata è restituita solo con secret key, redatta nelle risposte a publishable key

### Operazioni CRUD

```js
// Aggiungere metadata alla creazione
const customer = await stripe.customers.create({
  name: 'Jenny Rosen',
  metadata: { cms_id: '6573' },
});

// Aggiungere chiavi a metadata esistente (merge, non sovrascrive)
await stripe.customers.update('cus_xxx', {
  metadata: { loyalty_program: 'no' },
});
// Risultato: { cms_id: '6573', loyalty_program: 'no' }

// Aggiornare valore esistente
await stripe.customers.update('cus_xxx', {
  metadata: { loyalty_program: 'yes' },
});

// Rimuovere una chiave (passare stringa vuota)
await stripe.customers.update('cus_xxx', {
  metadata: { loyalty_program: '' },
});

// Rimuovere TUTTE le metadata (passare oggetto vuoto — attenzione!)
await stripe.customers.update('cus_xxx', {
  metadata: {},
});
```

### Propagazione tra oggetti

Metadata **non** si propaga automaticamente. Se servono le stesse info su oggetti collegati, vanno scritte esplicitamente su ciascuno.

Catena tipica Checkout Session → PaymentIntent → Charge:
- Per passare metadata alla Checkout Session E al PaymentIntent: impostarla su entrambi
- `payment_intent_data.metadata` nella creazione della Checkout Session imposta metadata sul PaymentIntent risultante

### Search per metadata

```js
// Cercare clienti per metadata
const customers = await stripe.customers.search({
  query: "metadata['cms_id']:'6573'",
});

// Cercare PaymentIntent per metadata
const paymentIntents = await stripe.paymentIntents.search({
  query: "metadata['order_id']:'order_123'",
});
```

Rate limit search: **20 read operations/sec**.

### Use cases comuni

- **Tracciamento ordini**: `metadata: { order_id: 'ord_123', cart_id: 'cart_456' }`
- **Collegamento utente**: `metadata: { user_id: 'usr_789', platform: 'web' }`
- **Riconciliazione**: usare metadata per collegare transazioni Stripe al proprio DB
- **Radar**: metadata può essere usata nelle regole antifrode custom

## Gestione risposte API

### Expanding responses

Riduce il numero di chiamate API includendo oggetti collegati nella risposta.

```js
// Senza expand: customer è solo un ID
// session.customer = "cus_xxx"

// Con expand: customer è l'oggetto completo
const session = await stripe.checkout.sessions.retrieve('cs_xxx', {
  expand: ['customer'],
});
// session.customer = { id: "cus_xxx", name: "Jenny", ... }

// Expand multipli
const session = await stripe.checkout.sessions.retrieve('cs_xxx', {
  expand: ['customer', 'payment_intent'],
});

// Expand annidato (dot notation)
const session = await stripe.checkout.sessions.retrieve('cs_xxx', {
  expand: ['payment_intent.payment_method'],
});

// Expand su liste
const sessions = await stripe.checkout.sessions.list({
  expand: ['data.customer'],  // "data." per espandere elementi nella lista
});
```

**Limiti**: max **4 livelli** di profondità. Non tutte le proprietà sono espandibili — l'API reference indica quali con label "Expandable".

### Pagination

Stripe usa **cursor-based pagination** (non offset).

```js
// Prima pagina (default 10 risultati, max 100)
const customers = await stripe.customers.list({ limit: 25 });

// Pagina successiva: usare l'ID dell'ultimo elemento
const nextPage = await stripe.customers.list({
  limit: 25,
  starting_after: customers.data[customers.data.length - 1].id,
});

// Pagina precedente
const prevPage = await stripe.customers.list({
  limit: 25,
  ending_before: customers.data[0].id,
});

// Auto-pagination (itera tutti i risultati automaticamente)
for await (const customer of stripe.customers.list({ limit: 100 })) {
  console.log(customer.id);
}
```

**Proprietà risposta lista**: `has_more` (boolean), `data` (array), `url` (endpoint).

### Search API

Per ricerche complesse su oggetti (customers, charges, invoices, payment intents, etc.):

```js
const results = await stripe.customers.search({
  query: "name:'Jenny' AND metadata['plan']:'enterprise'",
});
```

**Rate limit**: 20 reads/sec. I risultati di search possono avere **fino a 1 minuto di ritardo** rispetto alle scritture (eventual consistency).

## Error handling

### Tipi di errore

| Tipo | Quando | Come gestire |
|------|--------|-------------|
| **Payment error** (card_error) | Pagamento rifiutato, frode, carta scaduta | Mostrare messaggio all'utente, chiedere altro metodo di pagamento |
| **Invalid request error** | Parametri sbagliati o stato non valido | Bug nel codice — correggere la request |
| **Authentication error** | API key sbagliata o revocata | Verificare la chiave API |
| **API error** | Problema lato Stripe (rari) | Trattare come indeterminato, usare webhook per conferma |
| **Connection error** | Problema di rete | Retry con idempotency key, trattare come indeterminato |
| **Rate limit error** | Troppe richieste | Retry con exponential backoff |
| **Idempotency error** | Stessa key con parametri diversi | Usare la stessa key solo per richieste identiche |
| **Permission error** | Restricted key senza permessi | Verificare permessi della chiave |
| **Signature verification error** | Webhook non autentico | Verificare endpoint secret (diverso da API key) |

### HTTP Status Codes

| Code | Significato | Azione |
|------|-------------|--------|
| **200** | OK | Successo |
| **400** | Bad Request | Parametro mancante o invalido — correggere la request |
| **401** | Unauthorized | API key invalida — verificare chiave |
| **402** | Request Failed | Parametri validi ma request fallita (es. carta rifiutata) |
| **403** | Forbidden | Chiave senza permessi — verificare restricted key |
| **409** | Conflict | Conflitto idempotency key |
| **429** | Too Many Requests | Rate limit — exponential backoff |
| **500, 502, 503, 504** | Server Error | Problema Stripe — retry con idempotency, verificare via webhook |

### Gestione errori in Node.js

```js
try {
  const paymentIntent = await stripe.paymentIntents.create({
    amount: 2000,
    currency: 'eur',
    payment_method: 'pm_xxx',
    confirm: true,
  });
} catch (err) {
  switch (err.type) {
    case 'StripeCardError':
      // Pagamento rifiutato — mostrare err.message all'utente
      console.log(`Decline code: ${err.code}`);
      break;
    case 'StripeRateLimitError':
      // Troppi request — retry con backoff
      break;
    case 'StripeInvalidRequestError':
      // Parametri invalidi — bug nel codice
      break;
    case 'StripeAPIError':
      // Problema Stripe — retry
      break;
    case 'StripeConnectionError':
      // Rete — retry con stessa idempotency key
      break;
    case 'StripeAuthenticationError':
      // Chiave invalida
      break;
    default:
      // Errore sconosciuto
      break;
  }
}
```

### Idempotency

**Scopo**: rendere sicuro il retry di richieste POST quando la prima non riceve risposta (errore di rete).

**Come funziona**:
- GET e DELETE sono idempotenti per default — safe to retry sempre
- POST richiede una **idempotency key** nell'header `Idempotency-Key`
- Se la stessa key viene riusata con stessi parametri entro 24h, Stripe ritorna il risultato cachato
- Se la stessa key viene riusata con parametri diversi → errore idempotency

**Implementazione**:
```js
// Automatico con retry configurato
const stripe = require('stripe')('sk_xxx', {
  maxNetworkRetries: 2,  // Stripe genera idempotency keys automaticamente
});

// Manuale
const paymentIntent = await stripe.paymentIntents.create(
  { amount: 2000, currency: 'eur' },
  { idempotencyKey: 'order_123_attempt_1' }
);
```

**Strategie per generare key**: UUID v4 (random) oppure derivata dall'oggetto (es. `order_${orderId}` — protegge da doppio submit).

**Header `Stripe-Should-Retry`**: quando presente nella risposta, indica se il client dovrebbe riprovare. Le librerie ufficiali lo gestiscono automaticamente.

### Gestione payment errors — pattern completo

```js
try {
  const paymentIntent = await stripe.paymentIntents.create(params);
} catch (err) {
  if (err.type === 'StripeCardError') {
    // Recuperare il charge per l'outcome
    const charge = await stripe.charges.retrieve(
      err.raw.payment_intent.latest_charge
    );

    if (charge.outcome.type === 'blocked') {
      // Bloccato da Radar (frode)
    } else if (err.code === 'card_declined') {
      // Rifiutato dall'issuer — usare decline_code per dettagli
    } else if (err.code === 'expired_card') {
      // Carta scaduta
    } else {
      // Altro errore carta
    }
  }
}
```

## Testing

### Come testare

- Usare sempre **test API keys** (mai dati carte reali, vietato da Stripe Services Agreement)
- Per test interattivi: usare numeri carta test nel form
- Per test nel codice: usare PaymentMethod token (es. `pm_card_visa`) invece di numeri carta — per compliance PCI
- CVC: qualsiasi 3 cifre (4 per Amex). Data: qualsiasi data futura. Altri campi: qualsiasi valore

### Test cards principali

**Successo per brand**:

| Brand | PaymentMethod | Numero (interattivo) |
|-------|--------------|---------------------|
| Visa | `pm_card_visa` | 4242 4242 4242 4242 |
| Visa Debit | `pm_card_visa_debit` | — |
| Mastercard | `pm_card_mastercard` | — |
| Amex | `pm_card_amex` | — |
| Discover | `pm_card_discover` | — |

**Per paese**: `pm_card_us`, `pm_card_it`, `pm_card_de`, `pm_card_fr`, `pm_card_br`, etc.

### Test cards per errori

| Scenario | PaymentMethod | Effetto |
|----------|--------------|---------|
| Fondi insufficienti | `pm_card_visa_chargeDeclinedInsufficientFunds` | Decline: `insufficient_funds` |
| Carta scaduta | `pm_card_chargeDeclinedExpiredCard` | Decline: `expired_card` |
| CVC errato | `pm_card_chargeDeclinedIncorrectCvc` | Decline: `incorrect_cvc` |
| Errore processing | `pm_card_chargeDeclinedProcessingError` | Decline: `processing_error` |
| Segnalazione frode | `pm_card_createIssuerFraudRecord` | Crea record frode issuer |

### Test cards 3D Secure

| Scenario | Numero | Comportamento |
|----------|--------|--------------|
| Auth richiesta se non setup | 4000 0025 0000 3155 | Richiede 3DS su pagamenti on-session; off-session ok dopo setup |
| Sempre auth | 4000 0027 6000 3184 | Richiede 3DS su ogni transazione |
| Già setup | 4000 0038 0000 0446 | Off-session ok; on-session richiede 3DS |
| Fondi insufficienti + auth | 4000 0082 6000 3178 | Richiede 3DS, poi rifiuta per insufficient_funds anche dopo auth |

### Test dispute/refund

Usare la carta di test e poi rispondere con evidence specifici per simulare vittoria o sconfitta della disputa. I dettagli dei valori evidence sono nella documentazione Stripe Disputes.

### Sandbox

- Ogni account ha sandbox e live mode separati
- Gli oggetti di un mode non sono accessibili dall'altro
- Per load testing: **non** usare sandbox (rate limit) — usare l'apposito strumento Stripe per load test
- Organization sandbox: permette di testare multi-account (Connect, sharing) — creare dalla Dashboard

## Note e benchmark

- `invoice_creation` is not supported with `payment_intent_data[capture_method]` set to `manual`
- Invoices for delayed notification payment methods (Bacs, SEPA, ACH, Boleto, etc.) may take longer
- Receipts pull data from the `Charge` object — to update receipt data after confirmation, update the Charge directly
- Invoice creation for one-time payments via Checkout is priced separately from Stripe Invoicing
- Search API: eventual consistency, risultati possono avere fino a 1 minuto di ritardo
- Search API rate limit: 20 reads/sec
- Idempotency key: valida per 24 ore, max 255 caratteri
- Expand: max 4 livelli di profondità
- Pagination: max 100 risultati per pagina
