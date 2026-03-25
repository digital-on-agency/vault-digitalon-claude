<!-- ultimo aggiornamento: 2026-03-21 -->

# React

## Overview

**React** is a popular, open-source JavaScript library for building user interfaces (UIs), particularly single-page applications where data can change over time without reloading the page. Developed by Facebook (now Meta), it allows developers to create large web applications that can change data without reloading the page.

React lets you build complex UIs from small, isolated pieces of code called **components**. Each component manages its own state and renders itself independently. React uses a **virtual DOM** to efficiently update the actual browser DOM.

React is widely used for:
- Building dynamic and interactive web interfaces
- Developing single-page applications (SPAs)
- Creating mobile applications (with React Native)
- Server-side rendering (SSR) and static site generation (SSG) via Next.js

## Setup

### Installation - Vite React + TailwindCSS

**Create your project:**
```bash
npm create vite@latest my-project
cd my-project
```

**Install Tailwind CSS:**
```bash
npm install tailwindcss @tailwindcss/vite
```

**Configure the Vite plugin** in `vite.config.ts`:
```js
import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
export default defineConfig({
  plugins: [
    tailwindcss(),
  ],
})
```

**Import Tailwind CSS** in `App.css` or `index.css`:
```css
@import "tailwindcss";
```

### Core Packages: React and React-DOM

**React** — responsible for component logic and structure:
```jsx
import React, { useState, useEffect } from 'react';
```

**React-DOM** — responsible for rendering to the browser:
```jsx
import { createRoot } from 'react-dom/client';
const root = createRoot(document.getElementById('root'));
root.render(<App />);
```

## Configurazioni standard

### UI Component Libraries

#### ShadCn

[ShadCn Documentation](https://ui.shadcn.com/docs) | [Components](https://ui.shadcn.com/docs/components) | [Blocks](https://ui.shadcn.com/blocks) | [Charts](https://ui.shadcn.com/charts)

Requires Vite React + TailwindCSS.

**Setup:**

1. Edit `tsconfig.json` and `tsconfig.app.json` — add `baseUrl` and `paths`:
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

2. Update `vite.config.ts`:
```bash
npm install -D @types/node
```
```ts
import path from "path"
import tailwindcss from "@tailwindcss/vite"
import react from "@vitejs/plugin-react"
import { defineConfig } from "vite"

export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
```

3. Run CLI:
```bash
npx shadcn@latest init
```

**Usage:**
```bash
npx shadcn@latest add button
```
```jsx
import { Button } from "@/components/ui/button"
export default function Home() {
  return <Button>Click me</Button>
}
```

#### Material UI - MUI

```bash
npm install @mui/material @emotion/react @emotion/styled
npm install @fontsource/roboto
```

Import fonts in CSS:
```css
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';
```

[MUI component list](https://mui.com/material-ui/all-components/)

#### Material Tailwind

```bash
npm i @material-tailwind/react
```

Wrap tailwind config with `withMT()` and wrap app with `ThemeProvider`.

#### FlowBite

Requires Vite React + TailwindCSS.
```bash
npx flowbite-react@latest init
```

[Flowbite documentation](https://flowbite-react.com/docs/getting-started/introduction)

### Icon Libraries

#### React Icons
```bash
npm install react-icons
```
[react-icons website](https://react-icons.github.io/react-icons/)
```jsx
import { FaBeer } from "@react-icons/all-files/fa/FaBeer";
```

Use `IconContext.Provider` for shared styles across multiple icons:
```jsx
import { IconContext } from "react-icons";
<IconContext.Provider value={{ color: "blue", className: "global-class-name" }}>
  <FaFolder />
</IconContext.Provider>
```

#### Lucide React
```bash
npm install lucide-react
```
[Lucide Icons](https://lucide.dev/icons/)
```jsx
import { Smile } from "lucide-react";
```

Color: use `color` prop or parent text color. Size: use `size` prop, CSS, or Tailwind classes.

Global styling via `.lucide` CSS class. For absolute stroke width: `vector-effect: non-scaling-stroke`.

#### Material Icons
```bash
npm install @mui/icons-material
```
```jsx
import { AccessAlarm } from '@mui/icons-material';
```

Properties: `color`, `fontSize`, `fill`, `viewBox`, `strokeWidth`, `stroke`. Use `SvgIcon` for custom SVGs.

### Stripe Payment Integration

Three ways to embed Stripe payment in React:
1. Stripe-hosted checkout page
2. Embedded payment form
3. Checkout page with embedded components

**Install:**
```bash
npm install stripe@18.0.0 --save
```

**Configuration** (`src/config/stripe.js`):
```js
import { loadStripe } from "@stripe/stripe-js";
const stripe_publishable_key = import.meta.env.VITE_STRIPE_KEY;
export async function initializeStripe() {
  return await loadStripe(stripe_publishable_key);
}
```

**Business Logic** (`src/lib/stripe.js`):
- `createPaymentIntent(auth, plan, promoCode)` — authenticates with Firebase, creates Stripe Payment Intent, returns `clientSecret`
- `validateBillingForm(formData)` — validates required billing fields
- `confirmPayment(stripe, elements, clientSecret, billingData)` — confirms payment via Stripe API

## Workflow

### Build for Production

**Project structure prerequisites:**
```
.
├── index.html
├── package.json
├── public/
├── src/
├── tailwind.config.js
├── tsconfig.json
└── vite.config.ts
```

**Build:**
```bash
npm run build
```

Creates `dist` directory with production-ready static files (HTML, CSS, JS). Environment variables must be baked at compile time via `REACT_APP_` or `VITE_` prefixed variables.

**Test production build:**
```bash
npm run preview
```

**Compress for deployment:**
```bash
tar -czvf built-project.tar.gz dist
```
