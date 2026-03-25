<!-- ultimo aggiornamento: 2026-03-21 -->

# Google Tag Manager

## Overview

**Google Tag Manager (GTM)** is a free tag management system by Google that allows you to add, update, and manage tracking codes (tags) on your website or app without directly modifying the source code.
It centralizes all your analytics, advertising, and custom tracking scripts in one interface, reducing deployment time and minimizing the risk of errors from manual code edits.
GTM works by embedding a small container script in your site's HTML; inside the GTM dashboard, you define tags (e.g., Google Analytics, Meta Pixel), triggers that decide when those tags fire (e.g., page load, button click), and variables that store dynamic values.

## Setup

### How GTM Works

There are **3 main instances:**
* **Tags:** a measurement code
* **Triggers:** the conditions when we want to fire measurement codes
* **Variables:** any data we can collect from the website or push in the Data Layer and collect to the tags

[Google press official releases regarding GA4](https://support.google.com/analytics/answer/9164320#071122&zippy=%2Creleases)

### Create and Configure Account

1. Go to [Google Tag Manager](https://tagmanager.google.com) and log in with your company Google account.
2. Click on **Create Account**.
   - Enter the **Account Name** (e.g., Digital On).
   - Select the **Country** where your business operates.
3. Create a **Container** for your website:
   - Enter the **Container Name** (usually your website domain, e.g., `digitalon.com`).
   - Choose the **Target Platform** → select **Web**.
4. Click **Create** and accept the Terms of Service.

### Install the GTM Manager Code

In [GTM Workspace](https://tagmanager.google.com) **create a container** and then click `Admin > Install Google Tag Manager`. There you can find 2 HTML tags and you have to paste them in the HTML files of your website (each page), one in the `<head>` and the other in the `<body>`.

### GA4 Configuration Tag

Click on `New Tag`, name it *GA4 - Configuration Tag* and in `Tag Configuration` choose `Google Analytics: GA4 Configuration`. Paste the `Measurement ID` from Data Stream Details in your [Google Analytics Workspace](https://analytics.google.com/analytics/).

Select a **Trigger** — to measure **all the website** click on `All Pages`.
Click on `Save` and then `Submit`.

Depending on the version of GTM, `Google Analytics: GA4 Configuration` may be **deprecated**. In this case, choose `Google Tag` as **Tag Type**.
In [Google Analytics Workspace](https://analytics.google.com/analytics/), go to `Admin > Data Stream > [your data stream] > Configure Tag Settings`; click the Google tag and copy the **Google Tag ID**.
Return to GTM and paste the **Google Tag ID**. As **trigger** choose `Initialization - All Pages`.

## Configurazioni standard

### Events Configuration

There are ways to **send event information** to GA4 by GTM:
* **Recommended Events:** events known by GTM, choose from a list and easily set them up
* **Custom Events:** events that GTM doesn't know and that are specific to your business
* **Push in DataLayer:** for the most critical events, pushed from the code of your website

#### Recommended Events

First find the **component that trigger the event** in your project:
```html
<a class="class-name" id="component-id" href="[URL]">[...]</a>
```

1. **Variable:** Choose which property to identify the component (class, id, ...), then in GTM go to `Variables > Configure` and select the property in the *built-in variables* list.
2. **Trigger:** Go to `Trigger > New`, choose a recognizable **name** and the right **Tag Type** from the list.
3. **Tag:** Go to `Tag > New`, choose `Google Analytics: GA4 Event` as **Tag Type**, select the right **configuration tag** or insert your **Measurement ID** and choose the **event name** from the list. As **Trigger** select the one created in step 2.

#### Custom Events

1. **Variable:** Choose which property to identify the component, then in GTM go to `Variables > Configure` and select the property.
2. **Trigger:** Go to `Trigger > New`, choose a recognizable **name** and the right **Tag Type**. Use additional settings to identify the component.
3. **Tag:** Go to `Tag > New`, choose `Google Analytics: GA4 Event` as **Tag Type**, select the right **configuration tag** or insert your **Measurement ID** and **name your event** (best practice: lowercase with `_` instead of spaces). Set up **parameters** if needed.

#### DataLayer

[DataLayer Documentation](https://developers.google.com/tag-platform/tag-manager/datalayer)

The Data Layer is a JavaScript object (`window.dataLayer`) that acts as a central communication channel between your website or app and tracking tools like GTM and GA4.

A simple example of a dataLayer object:
```js
{
  event: "checkout_button",
  gtm: {
    uniqueEventId: 2,
    start: 1639524976560,
    scrollThreshold: 90,
    scrollUnits: "percent",
    scrollDirection: "vertical",
    triggers: "1_27"
  },
  value: "120"
}
```

##### DataLayer Setup

Add code before GTM Manager Code:
```html
<script>
window.dataLayer = window.dataLayer || [];
</script>
<!-- Google Tag Manager -->
<script>(...GTM code...)</script>
<!-- End Google Tag Manager -->
```

##### Event Handlers

To push an event in the dataLayer:
```js
dataLayer.push({"event": "[event_name]", "parameter-name": "parameter-value"})
```

The specific implementation depends on which technology you used to build the site.

##### Send Events to GA4

1. **Create Variables:** Go to `Variables > User-Defined Variables > New`, choose `Data Layer Variable` as **Variable Type** and type the `Data Layer Variable Name` exactly as it appears in the dataLayer. Do it for each event parameter you want to track.
   If dataLayer event contains arrays or dynamic data, use Custom JavaScript Variables.
2. **Create Trigger:** Go to `Trigger > New`, choose `Custom Event` as **Trigger Type** and type the `Event Name` exactly as it appears in the dataLayer object.
3. **Create Tag:** Go to `Tag > New`, choose `Google Analytics: GA4 Event` as **Tag Type** and insert the Measurement ID. Choose the `Event Name` and insert in `Event Parameters` all the variables you want to track. Set the trigger and save.

### Custom JavaScript Variables

**Custom JavaScript Variables (CJSV)** in GTM allow you to extend GTM's functionality by writing small JavaScript functions that dynamically return values.

**Basic structure:**
```javascript
function() {
  return "Hello World";
}
```

**Common Applications:**
- Transform values: format or normalize data
- Conditional logic: return different values depending on user state, device type, or page
- Extract data: pull dynamic information from the DOM, cookies, or query parameters
- Combine variables: merge values from multiple GTM variables
- Fallbacks: provide default values when other variables are missing

**Best Practices:**
- Keep functions short, simple, and focused on returning a value
- Always include a fallback return
- Add comments explaining what the variable does
- Avoid heavy logic or loops
- Minimize direct DOM dependencies
- Test in GTM Preview Mode before publishing

**Limitations:**
- CJSV run client-side only
- They are evaluated on demand, not continuously
- Complex logic is better handled in application code

### Scroll Tracking - Advanced Measurement Example

1. Create a **trigger**: `Triggers > New`, name it, select `Scroll Depth` as Trigger Configuration. Choose vertical/horizontal and the percentage/pixels value.
2. Create a **tag**: `Tags > New`, select `Google Analytics: GA4 Event`, choose the configuration tag, set the event name. Under `Event Parameters` add a row with name *scroll_depth* and value `Scroll Depth Threshold` (from Built-ins).
3. Select the trigger, save and submit.

## Workflow

### Track GHL iFrame forms with GTM

[Guide link](https://karolkrajcir.com/post/how-to-track-go-high-level-iframe-forms-with-google-tag-manager)

When a form is embedded via an **iframe**, the main website cannot directly access user interactions inside the iframe. To track these events, the iframe must communicate with the parent page via `postMessage`.

#### 1. Create a new container for the iFrame

Create a new container in the same GTM account: `Admin > + Create Container`, enter a descriptive name, select `Web`. Copy the GTM installation code and insert it in the iFrame.

#### 2. PostMessage to Parent Domain

Create a new **Custom HTML Tag** with:
```html
<script>
  try {
    var postObject = JSON.stringify({
      event: "[your event name]",
    });
    parent.postMessage(postObject, "https://[your domain]/");
  } catch (e) {
    window.console && window.console.log(e);
  }
</script>
```

#### 3. Listener from Parent Container

In the main container, create a new **Custom HTML Tag** with `All Pages` trigger:
```html
<script>
  (function () {
    window.dataLayer = window.dataLayer || [];
    function onMessage(e) {
      if (e.origin !== "[iFrame Domain]") return;
      try {
        var payload = (typeof e.data === "string") ? JSON.parse(e.data) : e.data;
        if (payload && payload.event === "[your event name]") {
          window.dataLayer.push({
            event: "[the event you want to track in dataLayer]"
          });
        }
      } catch (err) {
        console.log("Listener error:", err);
      }
    }
    window.addEventListener("message", onMessage, false);
  })();
</script>
```

* `[iFrame Domain]`: the domain where your iFrame is hosted
* `[your event name]`: the same name used in the PostMessage step
* `[the event you want to track in dataLayer]`: how you want to call the event in the dataLayer

#### 4. Track the event

The listener pushes the event in the data layer — now just send the data layer event to GA4 as described in the DataLayer section above.

### React Integration

#### Connect GTM in React

When installing GTM manager code in React, paste the snippet in `[project]/index.html`. All components and pages are rendered within a single `index.html` file, so placing the GTM snippet ensures it is loaded across every page.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    [...]
    <!-- Google Tag Manager -->
    <script>(function (w, d, s, l, i) {
    w[l] = w[l] || []; w[l].push({
    'gtm.start':
    new Date().getTime(), event: 'gtm.js'
    }); var f = d.getElementsByTagName(s)[0],
    j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : ''; j.async = true; j.src =
    'https://www.googletagmanager.com/gtm.js?id=' + i + dl; f.parentNode.insertBefore(j, f);
    })(window, document, 'script', 'dataLayer', 'GTM-AAA11AAA');</script>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
    <noscript>
      <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-WKN46NRS" height="0" width="0" style="display:none;visibility:hidden"></iframe>
    </noscript>
  </body>
</html>
```

#### PageView - push in dataLayer route changes

Create a GTM helper:
```ts
// src/lib/gtm.ts
declare global { interface Window { dataLayer: {[key: string]: any}[]} }

export function pushGtm(eventName: string, params: Record<string, any> = {}) {
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({ event: eventName, ...params });
}
```

Create a component that intercepts route changes and sends a `virtual_pageview`:
```tsx
// src/hooks/RouteChangeTracker.tsx
import { useEffect, useRef } from "react";
import { useLocation } from "react-router-dom";
import { pushGtm } from "./lib/gtm";

export default function RouteChangeTracker() {
  const location = useLocation();
  const prevUrlRef = useRef<string>();

  useEffect(() => {
    const url = window.location.href;
    if (prevUrlRef.current === url) return;
    prevUrlRef.current = url;

    pushGtm("virtual_pageview", {
      page_location: url,
      page_path: location.pathname + location.search + location.hash,
      page_title: document.title || undefined,
    });
  }, [location.pathname, location.search, location.hash]);

  return null;
}
```

Integrate in `App.jsx`:
```tsx
import RouteChangeTracker from "./RouteChangeTracker";

<Router>
  <RouteChangeTracker />
  {/* .... */}
</Router>
```

#### Send events from the app

Create a library file in `/lib` or `/analytics` named `events.ts`:
```typescript
import { pushGtm } from "./gtm";
const sent = new Set();

function track_event(event, params = {}) {
  // 1) enrich
  const enriched = {
    page_location: location.href,
    currency: "EUR",
    ...params,
  };

  // 2) sanitize / validate
  if (enriched.email) delete enriched.email; // no PII

  // 3) dedup (optional)
  const key = `${event}:${enriched.transaction_id ?? ""}`;
  if (event === "purchase" && sent.has(key)) return;
  if (event === "purchase") sent.add(key);

  // 4) send
  pushGtm(event, enriched);
}
```
