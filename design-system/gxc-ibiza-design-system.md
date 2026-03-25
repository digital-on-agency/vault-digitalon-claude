# Midnight Teal

## Essence

A bold, high-contrast nightlife-meets-Mediterranean aesthetic that balances deep blacks and near-whites with vivid teal accents. The system communicates exclusivity and energy — luxury travel with a pulse. Dense, uppercase typography in heavy custom fonts creates authority, while generous pill-shaped buttons and smooth transitions add approachability. It feels like a VIP wristband: dark, confident, unmistakable.

## Color Palette

### Backgrounds
- Primary Light: `#FAFAFA` — main page background, cards, light sections
- Primary Dark: `#020202` — hero sections, dark panels, footer
- Pure Black: `#000000` — full-bleed dark sections, overlay bases
- Pure White: `#FFFFFF` — card surfaces, text on dark
- Transparent Black: `#0000004A` — overlay on images and video backgrounds
- Dark Overlay: `rgb(0 0 0 / .8)` — off-canvas menu backdrop

### Text
- Primary Text: `#262626` — body copy, headings on light backgrounds
- Secondary Text: `#1F2124` — slightly darker variant, subheadings
- Deep Text: `#0C0D0E` — highest-contrast text
- Muted Text: `#69727D` — captions, metadata, secondary info
- Soft Muted: `#88909B` — placeholder text, disabled states
- Dark Gray: `#33373D` — tertiary text, footer copy
- Medium Gray: `#3F444B` — supporting labels
- Light on Dark: `#FAFAFA3D` — ghost text on dark backgrounds (24% opacity)
- Inverted: `#FFFFFF` — text on dark backgrounds

### Accents
- Teal (Primary Accent): `#01A781` — Elementor global accent, links, active states
- Teal (CTA variant): `#069978` — buttons, CTA backgrounds, key interactive elements
- Teal (Hover variant): `#00A781` — hover states on accent elements
- Blue: `#467FF7` — secondary accent, occasional links and highlights
- Golden Amber: `#FFBC7D` — promotional badges, warm callouts

### Semantic
- Success: `#5CB85C` — confirmation, positive states
- Warning: `#F0AD4E` — caution notices
- Error / Danger: `#D9534F` — error messages, destructive actions
- Info: `#5BC0DE` — informational notices

## Typography

### Families
- **Display / H1**: "Nexa Black", Sans-serif — weight 600, uppercase. Impact headings, hero titles
- **H2 / Section Titles**: "Nexa Black", Sans-serif — weight 500, letter-spacing 1px
- **Body Text**: "Nexa Bold", Sans-serif — weight 400, general paragraph text
- **UI / Buttons**: "Be Vietnam Pro", Sans-serif — weight 500, interactive elements, navigation
- **Accent Display**: "Anton", Sans-serif — used for special promotional headings
- **Supporting**: "Oswald", Sans-serif — secondary display contexts
- **Alternative Body**: "Poppins", Sans-serif — used sparingly for variation
- **Condensed Display**: "Helvetica Black Condensed", Sans-serif — compact high-impact titles

### Scale

| Level | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| H1 | 4rem (64px) | 600 | 1 | 4px | Page hero titles |
| H2 | 3rem (48px) | 500 | 1 | 1px | Section headings |
| H3 | 2.5rem (40px) | 600 | 1.2 | 1px | Sub-section headings |
| H4 | 2rem (32px) | 500 | 1.2 | 0 | Card titles, feature headings |
| Large Body | 1.6–1.8rem | 400 | 2rem | 0 | Intro paragraphs, callouts |
| Body | 1.1rem (17.6px) | 400 | 2rem | 0 | Standard body text |
| UI / Button | 1.2rem (19.2px) | 500 | 1.5 | 0 | Buttons, nav items, labels |
| Small / Caption | 0.9rem (14.4px) | 400 | 1.5em | 0 | Metadata, fine print |
| Detail | 14–15px | 400 | 1.4 | 0 | Timestamps, tags |

### Treatments
- **Uppercase** is the dominant text treatment — used heavily for headings, nav items, buttons, and section titles (`text-transform: uppercase`)
- **Letter-spacing** of 4px on primary headings creates an airy, editorial feel
- **Letter-spacing** of 1px on secondary headings and nav labels adds subtle tracking

## Spacing

### Base Unit
No strict mathematical base unit, but spacing clusters around multiples of 5px and 10px.

### Common Values
- xxs: 0px — collapsed spacing, flush elements
- xs: 5px — tight internal padding (badges, tags)
- sm: 10px — gap between list items, icon spacing
- md: 20px — standard section internal padding, widget margins
- lg: 40px — major section separators, heading bottom margins
- xl: variable — hero sections use generous vertical padding

### Container
- Max container width: `1140px` (Elementor boxed layout)
- Content areas: `1300px` max for full-width sections
- Centered text blocks: `700px` max-width for readability
- Logo / nav branding: `220px` width

## Elevation

### Shadows
- **Subtle**: `1px 1px 10px 1px rgb(0 0 0 / .23)` — cards at rest, light elevation
- **Medium**: `1px 1px 10px 0 rgb(0 0 0 / .33)` — hovered cards, dropdowns
- **Heavy**: `2px 2px 10px 3px rgb(0 0 0 / .5)` — modals, prominent overlays
- **Floating**: `2px 8px 23px 3px rgb(0 0 0 / .2)` — elevated cards, featured elements
- **Ambient**: `0 8px 24px rgb(0 0 0 / .15)` — soft page-level elevation
- **Inset**: `inset 0 0 0 1px rgba(0,0,0,.1)` — subtle input field borders
- **Glow (light)**: `1px 1px 5px 1px rgb(255 255 255 / .57)` — elements on dark backgrounds

### Border Radii
- **Pill**: `100px` / `1000px` / `999px` — primary buttons, CTAs, tags
- **Large**: `20px` — featured cards, hero containers
- **Medium**: `15px` — standard cards, content blocks
- **Default**: `10px`–`12px` — secondary cards, image containers
- **Small**: `5px`–`6px` — input fields, minor UI elements
- **Tiny**: `2px`–`3px` — badges, tight UI components
- **Circle**: `50%` — avatars, icon containers

## Interactive States

### Buttons
- **Default**: Background `#069978` (teal), text `#FFFFFF`, border-radius `100px` (pill), font "Be Vietnam Pro" 500
- **Hover**: Background shifts to `#01A781` (brighter teal), smooth `color 0.3s` transition
- **Active**: Slight darkening of teal background
- **Disabled**: Opacity reduction, muted colors
- **Transition**: `color 0.3s`, `all .3s` for background changes

### Links
- **Default**: Color `#01A781` (teal accent)
- **Hover**: Color `#069978` with `color 0.3s` transition
- **Navigation items**: Uppercase, "Nexa Black" font, with underline/framed pointer animations
- **Dropdown links**: "Be Vietnam Pro", normal case, with `var(--n-menu-title-transition)` (300ms)

### Form Inputs
- **Border**: `1px solid rgba(0,0,0,.1)` inset shadow style
- **Border Radius**: `5px`–`6px`
- **Focus**: Accent teal border color

## Motion

### Principles
Smooth and confident. Transitions are consistently 300ms, giving a premium feel without sluggishness. Transform animations are slightly slower (400ms) with ease curves for physical weight. The system avoids bounce or spring effects — everything is clean and intentional.

### Patterns
- **Color transitions**: `color 0.3s` — standard for text/icon color changes on hover
- **General transitions**: `all .3s` — catch-all for multi-property state changes
- **Transform slides**: `transform .4s ease` — element entrance, carousel movements
- **Fade-ins**: `opacity 1s` — slow, dramatic image reveals on lazy-load
- **Quick fades**: `opacity .2s, transform .4s` — combined entrance with stagger
- **Menu animations**: `max-height .3s, transform .3s` — accordion/dropdown expand
- **Fill transitions**: `fill 0.3s` — SVG icon color changes
- **Scroll-triggered**: IntersectionObserver-based class toggling for entrance animations

## Design Principles

1. **Dark-first confidence** — Dark backgrounds dominate hero and key sections; light is used for content-heavy reading areas. The contrast creates drama and luxury.
2. **Teal as signature** — A single, vivid accent color (`#01A781`/`#069978`) carries all interactive and brand-signaling weight. No competing accent hues.
3. **Heavy type, uppercase authority** — Custom black-weight fonts ("Nexa Black") in uppercase with wide tracking project confidence and exclusivity.
4. **Pill-shaped interactivity** — All primary interactive elements use extreme border-radius (100px+), creating a distinctive, approachable button language.
5. **Consistent 300ms rhythm** — Nearly all transitions share the same 300ms timing, creating a unified motion personality across the interface.

## Implementation Notes

- Built on **Elementor** (WordPress) with a well-structured CSS custom property system using `--e-global-*` variables
- **Elementor Global Tokens**:
  - `--e-global-color-primary: #FAFAFA`
  - `--e-global-color-secondary: #262626`
  - `--e-global-color-accent: #01A781`
  - `--e-global-color-text: #262626`
  - `--e-global-typography-primary-font-family: "Nexa Black"`
  - `--e-global-typography-secondary-font-family: "Nexa Black"`
  - `--e-global-typography-text-font-family: "Nexa Bold"`
  - `--e-global-typography-accent-font-family: "Be Vietnam Pro"`
- **Custom fonts**: "Nexa Black" and "Nexa Bold" are self-hosted (not Google Fonts)
- **Performance**: LiteSpeed caching with CSS bundling, IntersectionObserver-based lazy loading
- **Container max-width**: 1140px (Elementor default boxed layout)
- **Multilingual**: 5 languages (EN, IT, ES, DE, FR) — design must accommodate variable text lengths
- CSS is delivered as a single minified LiteSpeed bundle (~355KB)
