# noon. Project Instructions

## Brand Identity

- Read `docs/NOON_BRAND_IDENTITY.md` before writing or changing UI code.
- Use the CSS design tokens from the brand identity.
- The reference design is located in `docs/Banking-App_Design.html`.

## Brand Quick Reference

- **Name:** always lowercase `noon` — with brand mark: `noon.`
- **Tagline:** "Banking, reduced to the essentials."
- **Primary font:** Outfit (Google Fonts)
- **Warm Dot color:** `#C8966D` — used sparingly (logo, active nav dots, special highlights). Never as button color or large area.
- **Background:** `#F7F6F3` (warm off-white) — never pure `#FFFFFF` as page background
- **Cards/Surfaces:** `#FFFFFF` with 3-layer subtle shadows and `0.5px solid rgba(0,0,0,0.04)` border
- **Card radius:** `18px`
- **Icons:** Outline/stroke only (Feather/Lucide), never filled
- **Buttons:** White pills with icon + text, no colored buttons
- **Amounts:** always `font-variant-numeric: tabular-nums`
- **Animations:** Subtle and functional, max `0.3s` for UI, no bounce/rotation/overshoot
- **Section labels:** UPPERCASE, `letter-spacing: 2.2px`, `--text-faint`
- **Currency format:** `€2.847,20` (German — dot for thousands, comma for decimal)

## Tech Stack

- **Backend:** Fastify + TypeScript + Prisma + PostgreSQL
- **iOS:** SwiftUI + GRDB + KeychainAccess
- **Backend entry point:** `src/server.ts`
