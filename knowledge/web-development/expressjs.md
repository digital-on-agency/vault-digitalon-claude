<!-- ultimo aggiornamento: 2026-03-21 -->

# ExpressJS

## Overview

**Express.js** is a minimal and flexible Node.js web application framework that provides a robust set of features for web and mobile applications. It simplifies the process of creating server-side applications with Node.js.

Express.js is widely used for:
- Building RESTful APIs
- Creating web applications (with templating engines like Pug or EJS)
- Handling requests and responses
- Implementing middleware for authentication, logging, data validation

## Setup

Express.js is the go-to framework for rapidly developing efficient, scalable, and maintainable backend services and APIs using JavaScript on the server-side.

Typical project structure:
```
project/
├── node_modules/
├── logs/
├── package.json
├── package-lock.json
├── src/
│   ├── app.ts
│   ├── server.ts
│   ├── config/
│   ├── controllers/
│   ├── logger/
│   ├── middlewares/
│   ├── models/
│   ├── routes/
│   ├── services/
│   └── utils/
└── tsconfig.json
```

## Workflow

### Build for Production

**Build:**
```bash
npx tsc
```

Creates the `dist` subdirectory with the production version.

**Install production dependencies in dist:**
```bash
cd project
npm install --production
```

**Test:**
```bash
cd dist
node server.js
```

**Compress for deployment:**
```bash
cd ..
tar -czvf built-project.tar.gz dist package.json package-lock.json node_modules
```

Including `node_modules` and `package.json` ensures all dependencies and exact versions are bundled. While it increases archive size, this simplifies deployment and avoids runtime errors from inconsistent installations.

**Important:** if the project includes an `.env` file, it must be included in the compressed archive.
