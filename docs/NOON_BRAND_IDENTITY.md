# noon. — Brand Identity System

> **Banking, reduced to the essentials.**
> Dieses Dokument definiert die vollständige Brand Identity für die noon. Fintech-App.
> Es dient als Single Source of Truth für alle Design- und Entwicklungsentscheidungen.

---

## 1. Brand Foundation

### 1.1 Brand Name
- **Name:** noon
- **Schreibweise:** Immer komplett in Kleinbuchstaben: `noon`
- **Mit Brand Mark:** `noon.` — der Punkt ist der warme Dot (siehe Logo)
- **Niemals:** "Noon", "NOON", "noon!", "nOOn"

### 1.2 Brand Essence
- **Tagline:** „Banking, reduced to the essentials."
- **Positionierung:** Customizable Banking-Frontend für mehrere Banken — radikal minimalistisch, premium, intelligent
- **Zielgruppe:** 18–45 Jahre, digital-affin, designbewusst
- **Persönlichkeit:** Ruhig, klar, kompetent, warm aber nicht aufdringlich
- **Ton:** Selbstbewusst-minimal — wie ein Freund der wenig sagt, aber immer das Richtige

### 1.3 Brand Values
1. **Klarheit** — Jedes Element hat einen Grund. Nichts existiert zur Dekoration.
2. **Kontrolle** — Der User hat die Macht über seine Finanzen, nicht die Bank.
3. **Wärme** — Finanzen fühlen sich nicht kalt an. Der warme Dot symbolisiert das.
4. **Intelligence** — Die App lernt und automatisiert, bleibt aber transparent.

---

## 2. Logo

### 2.1 Wordmark
- **Font:** Outfit, Bold (700)
- **Farbe:** `#111111` (Light Mode) / `#FFFFFF` (Dark Mode)
- **Letter-Spacing:** `-0.6px` bei 23px Schriftgröße
- **Alles Kleinbuchstaben:** `noon`

### 2.2 Brand Mark — Der warme Dot
- **Form:** Perfekter Kreis
- **Farbe:** `#C8966D` (warm)
- **Größe relativ zum Wordmark:** ca. 24% der x-Höhe des Wortes
- **Position:** Rechts unten am letzten "n", leicht über der Baseline, fungiert als Punkt
- **CSS-Referenz:**
  ```css
  .logo::after {
    content: '';
    display: inline-block;
    width: 5.5px;
    height: 5.5px;
    background: #C8966D;
    border-radius: 50%;
    margin-left: 1px;
    position: relative;
    top: -1px;
  }
  ```

### 2.3 Logo-Varianten
| Variante | Verwendung | Text | Dot |
|---|---|---|---|
| **Primary (Light)** | Helle Backgrounds | `#111111` | `#C8966D` |
| **Primary (Dark)** | Dunkle Backgrounds | `#FFFFFF` | `#C8966D` |
| **Mono Light** | Auf Fotos/Komplexen BGs | `#FFFFFF` | `#FFFFFF` |
| **Mono Dark** | Monochrome Kontexte | `#111111` | `#111111` |

### 2.4 Logo Schutzzone
- Minimum Freiraum um das Logo: **Breite des "o"** auf jeder Seite
- Niemals das Logo verzerren, drehen, mit Schatten versehen oder Farben ändern

### 2.5 App Icon
- **Form:** Abgerundetes Quadrat (iOS/Android System-Radius)
- **Hintergrund:** `#111111`
- **Element:** Der warme Dot `#C8966D`, zentriert, ~40% der Icon-Fläche
- **Alternativ:** Weißes "n" mit warmem Dot auf `#111111`

---

## 3. Farbsystem

### 3.1 Core Palette

```css
:root {
  /* ─── Foundations ─── */
  --bg:           #F7F6F3;    /* Warmes Off-White — Haupthintergrund */
  --surface:      #FFFFFF;    /* Reines Weiß — Karten, Overlays */
  --text:         #111111;    /* Primärtext — fast Schwarz */
  --text-mid:     #555555;    /* Sekundärtext — Beschreibungen */
  --text-light:   #A0A0A0;    /* Tertiärtext — Meta-Info */
  --text-faint:   #C8C8C4;    /* Quartärtext — Placeholder, Inaktiv */
  --divider:      #EEEEE9;    /* Trennlinien — warmes Grau */

  /* ─── Brand ─── */
  --accent:       #111111;    /* Primär-Akzent = Text-Schwarz */
  --warm:         #C8966D;    /* Warmer Dot — Brand-Signatur */

  /* ─── Semantic ─── */
  --green:        #2D8653;    /* Positiv / Wachstum / Bestätigung */
  --green-bg:     rgba(45, 134, 83, 0.07);
  --amber:        #C49332;    /* Warnung / Sparziele / In Progress */
  --amber-bg:     rgba(196, 147, 50, 0.06);
  --red:          #C45A4A;    /* Negativ / Budget-Limit / Fehler */
  --red-bg:       rgba(196, 90, 74, 0.06);
}
```

### 3.2 Farbregeln
- **Primärfarbe ist Schwarz/Weiß**, nicht eine "Brand Color" — das ist der radikale Minimalismus
- **Der warme Dot `#C8966D`** wird **sparsam** eingesetzt: Logo, aktive Navigation-Dots, besondere Highlights. **Niemals** als Button-Farbe, **niemals** als große Fläche
- **Semantische Farben** werden nur für ihren Zweck verwendet (Grün = positiv, Amber = Warnung, Rot = negativ)
- **Semantische Background-Farben** haben immer ~6-7% Opacity des zugehörigen Farbwerts
- **Hintergrund ist `#F7F6F3`**, ein warmes Off-White — **niemals reines `#FFFFFF`** als Page-Background
- **Karten/Surfaces sind `#FFFFFF`** — der minimale Kontrast zu `#F7F6F3` erzeugt subtile Tiefe

### 3.3 Dark Mode (Richtlinie)
| Light | Dark |
|---|---|
| `--bg: #F7F6F3` | `--bg: #0A0A0A` |
| `--surface: #FFFFFF` | `--surface: #1A1A1A` |
| `--text: #111111` | `--text: #F5F5F3` |
| `--text-mid: #555555` | `--text-mid: #999999` |
| `--text-light: #A0A0A0` | `--text-light: #666666` |
| `--text-faint: #C8C8C4` | `--text-faint: #444444` |
| `--divider: #EEEEE9` | `--divider: #222222` |
| `--warm: #C8966D` | `--warm: #C8966D` (bleibt gleich) |

---

## 4. Typografie

### 4.1 Font Family
- **Primär:** `'Outfit', sans-serif`
- **Fallback:** `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`
- **Google Fonts Import:** `https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap`
- **Font Rendering:** `-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;`

### 4.2 Type Scale

| Token | Größe | Gewicht | Letter-Spacing | Verwendung |
|---|---|---|---|---|
| `display` | 50px | 300 (Zahl) + 700 (€) | -2.5px | Hauptsaldo |
| `display-cents` | 30px | 300 | -1px | Nachkommastellen |
| `heading-1` | 23px | 700 | -0.6px | Logo, große Überschriften |
| `heading-2` | 15px | 600 | -0.2px | Kartennamen, Sub-Überschriften |
| `body` | 15px | 700 | -0.5px | Beträge (tabular-nums!) |
| `body-medium` | 13px | 500 | -0.1px | Action-Buttons, Beschreibungen |
| `caption` | 12px | 400 | 0 | Meta-Informationen |
| `caption-strong` | 12.5px | 600 | 0.2px | Trend-Badges |
| `overline` | 11–12px | 500–600 | 2–2.2px | Section-Labels (UPPERCASE) |
| `micro` | 10px | 500 | 0.2px | Nav-Labels |
| `micro-bold` | 8px | 700 | 0 | Avatar-Initialen |

### 4.3 Typografie-Regeln
- **Beträge immer mit `font-variant-numeric: tabular-nums`** — damit Zahlen sauber untereinander stehen
- **Gewichts-Kontrast ist ein Kernprinzip:** Hauptsaldo nutzt 300 für die Zahl + 700 für das €-Zeichen
- **Cents/Nachkommastellen** sind immer leichter (300) und in `--text-faint`
- **Section Labels** sind immer UPPERCASE mit weitem Letter-Spacing (2–2.2px) in `--text-faint`
- **Negative Letter-Spacing** für große/fette Elemente, **positive** für kleine/kapitalisierte

---

## 5. Spacing & Layout

### 5.1 Spacing Scale
```
4px  — Micro (z.B. Gap zwischen Nav-Icon und Label)
8px  — Small (z.B. Gap zwischen Action-Pills)
10px — Card Gap (Abstand zwischen Space-Cards)
14px — Section-Label zu Content
22px — Horizontal Padding (Cards, Action-Strip)
26px — Horizontal Padding (Top-Bar)
28px — Horizontal Padding (Balance, Section-Labels)
30px — Section Spacing (nach Space-Stacks)
32px — Balance zu Action-Strip
36px — Große Abstände (Top-Bar zu Balance, Action-Strip zu Spaces)
```

### 5.2 Layout-Prinzipien
- **Horizontale Padding:** Konsistent 22–28px je nach Element
- **Vertikaler Rhythmus:** Großzügig — Breathing Room ist ein Premium-Signal
- **Content-Bereich:** Scrollbar mit `padding: 62px 0 96px` (unter Statusbar, über Nav)
- **Kein horizontales Scrollen** — alles ist vertikal organisiert

---

## 6. Komponenten-System

### 6.1 Cards

#### Standard Card (Space Card)
```css
.card {
  background: var(--surface);         /* #FFFFFF */
  border: 0.5px solid rgba(0,0,0,0.04);
  border-radius: 18px;
  box-shadow:
    0 1px 2px rgba(0,0,0,0.03),
    0 4px 12px rgba(0,0,0,0.04),
    0 8px 24px rgba(0,0,0,0.02);
  padding: 18px 20px 16px;
}
```

#### Card Hover
```css
.card:hover {
  transform: translateY(-1px);
  box-shadow:
    0 2px 4px rgba(0,0,0,0.04),
    0 8px 24px rgba(0,0,0,0.06),
    0 16px 40px rgba(0,0,0,0.03);
}
```

#### Card-Regeln
- **Border-Radius:** `18px` (Variable `--radius`)
- **Shadow:** Immer 3-Layer-Shadow für natürliche Tiefe
- **Border:** Ultra-subtil — `0.5px solid rgba(0,0,0,0.04)`
- **Kein farbiger Border** — niemals
- **Hover:** Subtle lift (`translateY(-1px)`) + verstärkter Shadow

### 6.2 Action Pills (Buttons)
```css
.action-pill {
  background: var(--surface);
  border: 0.5px solid rgba(0,0,0,0.04);
  border-radius: 14px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.03);
  padding: 13px 0;
  font-size: 13px;
  font-weight: 500;
  color: var(--text-mid);
  gap: 7px;
  transition: box-shadow 0.2s, transform 0.15s;
}
```

#### Button-Regeln
- **Primäre Aktionen** sind weiße Pills mit Icon + Text
- **Keine farbigen Buttons** — das widerspricht dem Minimalismus
- **Alle Buttons gleich breit** (`flex: 1`)
- **Icons in Buttons:** 16×16px, `stroke-width: 1.8`, Farbe `--text-mid`

### 6.3 Space Icons
```css
.space-icon {
  width: 44px;
  height: 44px;
  border-radius: 13px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 19px;
}
```
- **Hauptkonto:** Dunkler Hintergrund (`--accent`) mit weißem SVG-Icon
- **Budget-Spaces:** Semantischer Background (`--amber-bg`, `--red-bg`, etc.) mit Emoji
- **Shared-Spaces:** `rgba(0,0,0,0.03)` mit Emoji

### 6.4 Progress Bars
```css
.progress-track {
  width: 100%;
  height: 3px;
  background: var(--divider);     /* #EEEEE9 */
  border-radius: 3px;
  overflow: hidden;
}
.progress-fill {
  height: 100%;
  border-radius: 3px;
  transition: width 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}
```
- **Höhe:** Nur 3px — ultra-subtil
- **Fill-Farbe:** Matched die semantische Farbe des Spaces
- **Animation:** Smooth ease-out mit `cubic-bezier(0.25, 0.46, 0.45, 0.94)`

### 6.5 Trend Badges
```css
.badge {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  font-size: 12.5px;
  font-weight: 600;
  padding: 5px 14px;
  border-radius: 100px;       /* Full-Pill */
  letter-spacing: 0.2px;
}
/* Varianten: */
.badge-positive { color: var(--green); background: var(--green-bg); }
.badge-warning  { color: var(--amber); background: var(--amber-bg); }
.badge-negative { color: var(--red);   background: var(--red-bg);   }
```

### 6.6 Shared Avatars
```css
.avatar {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  font-size: 8px;
  font-weight: 700;
  color: white;
  border: 2px solid var(--surface);
  margin-left: -5px;    /* Overlap-Effekt */
}
```

### 6.7 Navigation (Bottom Tab Bar)
```css
.bottom-nav {
  height: 86px;
  background: rgba(247, 246, 243, 0.92);     /* Frosted Glass */
  backdrop-filter: blur(28px);
  -webkit-backdrop-filter: blur(28px);
  border-top: 0.5px solid rgba(0,0,0,0.06);
}
```
- **Aktiv:** Icon `stroke-width: 2`, Label `font-weight: 600`, Farbe `--text`, plus warmer Dot darunter
- **Inaktiv:** Icon `stroke-width: 1.6`, Label `font-weight: 500`, Farbe `--text-faint`
- **Active Dot:** 4×4px, `#C8966D`, zentriert unter dem Label
- **Labels:** 10px, `letter-spacing: 0.2px`

### 6.8 Section Labels
```css
.section-label {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-faint);
  letter-spacing: 2.2px;
  text-transform: uppercase;
  padding: 0 28px;
  margin-bottom: 14px;
}
```

### 6.9 Chevrons (Drill-Down Indicator)
```css
.chevron::after {
  content: '';
  width: 7px;
  height: 7px;
  border-right: 1.5px solid var(--text-faint);
  border-bottom: 1.5px solid var(--text-faint);
  transform: rotate(-45deg);
  opacity: 0.5;
}
```

---

## 7. Iconografie

### 7.1 Icon-Stil
- **Typ:** Outline/Stroke-Icons (niemals Filled)
- **Standardgröße:** 22×22px (Navigation), 16×16px (in Buttons), 20×20px (in Space-Icons), 21×21px (Top-Bar)
- **Stroke-Width:** `1.5` (Standard), `1.8` (in Buttons), `2.0` (aktive Navigation)
- **Stroke-Linecap:** `round`
- **Stroke-Linejoin:** `round`

### 7.2 Icon-Farben
| Kontext | Farbe |
|---|---|
| Top-Bar Buttons | `var(--text-light)` — #A0A0A0 |
| Action-Pill Icons | `var(--text-mid)` — #555555 |
| Nav aktiv | `var(--text)` — #111111 |
| Nav inaktiv | `var(--text-faint)` — #C8C8C4 |
| Auf dunklem Hintergrund | `#FFFFFF` |

### 7.3 Icon-Quelle
- Bevorzugt: Feather Icons / Lucide (Outline-Stil)
- Immer als Inline-SVG einbinden, niemals als Icon-Font
- Niemals Filled Icons mischen mit Outline Icons

---

## 8. Animation & Transitions

### 8.1 Standard-Transitions
```css
/* Hover-Effekte */
transition: box-shadow 0.2s ease, transform 0.15s ease;

/* Progress-Bar Fill */
transition: width 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
```

### 8.2 Animations-Prinzipien
- **Subtil und funktional** — Animationen dienen der Orientierung, nicht dem Showeffekt
- **Hover:** Maximal `translateY(-1px)` + Shadow-Verstärkung
- **Keine Bounce-Effekte, keine Rotation, kein Overshoot**
- **Dauer:** 0.15–0.3s für UI-Elemente, 0.5–0.8s für Daten-Visualisierungen
- **Easing:** `ease` für Standard, `cubic-bezier(0.25, 0.46, 0.45, 0.94)` für Visualisierungen

---

## 9. Borders & Shadows

### 9.1 Borders
```css
/* Standard Card Border */
border: 0.5px solid rgba(0,0,0,0.04);

/* Nav Divider */
border-top: 0.5px solid rgba(0,0,0,0.06);

/* Inhaltliche Trennlinie */
border: 1px solid var(--divider);  /* #EEEEE9 */
```
- **Immer ultra-subtil** — 0.5px mit sehr geringer Opacity
- **Niemals** `1px solid #ccc` oder ähnlich sichtbare Borders

### 9.2 Shadows
```css
/* Standard Card Shadow (3 Layer) */
box-shadow:
  0 1px 2px rgba(0,0,0,0.03),
  0 4px 12px rgba(0,0,0,0.04),
  0 8px 24px rgba(0,0,0,0.02);

/* Light Shadow (Action Pills) */
box-shadow: 0 1px 3px rgba(0,0,0,0.03);

/* Elevated Shadow (Hover/Modals) */
box-shadow:
  0 2px 4px rgba(0,0,0,0.04),
  0 8px 24px rgba(0,0,0,0.06),
  0 16px 40px rgba(0,0,0,0.03);
```
- **Immer Multi-Layer-Shadows** für natürliche Tiefe
- **Sehr geringe Opacity** (0.02–0.06) — Shadows sollen kaum wahrnehmbar sein
- **Niemals** `box-shadow: 0 2px 8px rgba(0,0,0,0.15)` oder ähnlich schwere Shadows

---

## 10. Border Radius

| Element | Radius |
|---|---|
| Cards / Hauptcontainer | `18px` |
| Action Pills | `14px` |
| Space Icons | `13px` |
| Badges / Trend Pills | `100px` (Full Pill) |
| Top Action Buttons | `50%` (Kreis) |
| Progress Bars | `3px` |
| Avatare | `50%` (Kreis) |
| Phone Frame (wenn dargestellt) | `50px` |

---

## 11. Glasmorphism & Overlays

### 11.1 Bottom Nav (Frosted Glass)
```css
background: rgba(247, 246, 243, 0.92);
backdrop-filter: blur(28px);
-webkit-backdrop-filter: blur(28px);
```

### 11.2 Overlay-Prinzipien
- **Frosted Glass nur für fixierte Navigation** — niemals für Content-Cards
- **Blur-Wert:** 28px für Navigation
- **Background-Opacity:** 0.92 — fast opak, aber mit subtiler Transparenz
- **Kein Frosted Glass für Modals** — diese nutzen `var(--surface)` mit Shadow

---

## 12. Zahlenformatierung

### 12.1 Währung
- **Format:** `€2.847,20` (Deutsch — Punkt als Tausendertrennzeichen, Komma für Dezimal)
- **€-Zeichen:** Vor der Zahl, kein Leerzeichen
- **Hauptbetrag:** Bold (700), Cent-Betrag: Light (300) in `--text-faint`
- **Tabular Nums:** Immer `font-variant-numeric: tabular-nums` für Beträge in Listen

### 12.2 Prozent
- **Format:** `28 %` (Leerzeichen vor %)
- **Kontext:** Nur in Space-Cards als Budget-Fortschritt

### 12.3 Trends
- **Format:** `+4,2 %` (Vorzeichen + Leerzeichen + %)
- **Positiv:** Grün mit Pfeil-Icon
- **Negativ:** Rot mit umgekehrtem Pfeil-Icon

---

## 13. Sprache & Microcopy

### 13.1 Grundsätze
- **Sprache:** Deutsch (App), Englisch (Brand/Marketing)
- **Ton:** Klar, knapp, freundlich — nie belehrend
- **Keine Ausrufezeichen** in der UI
- **Keine Emojis in Text** — nur als Space-Icons

### 13.2 UI-Labels (Referenz)
| Element | Text |
|---|---|
| Hauptsaldo-Label | `GUTHABEN` |
| Section: Eigene Spaces | `SPACES` |
| Section: Geteilte Spaces | `GETEILT` |
| Actions | `Hinzufügen`, `Senden`, `Mehr` |
| Nav-Items | `Home`, `Aktivität`, `Senden`, `Profil` |
| Meta: Letzte Buchung | `Letzte Buchung · Heute` |
| Meta: Sparziel | `Ziel · €1.500` |
| Meta: Budget | `Budget · €280 / Monat` |
| Meta: Geteilt | `mit [Name]` |

### 13.3 Trennzeichen
- **Mid-Dot `·`** für Meta-Informationen (z.B. "Letzte Buchung · Heute")
- **Schrägstrich `/`** für Raten (z.B. "€280 / Monat")

---

## 14. Do's & Don'ts

### ✅ Do
- Weißraum als Design-Element nutzen — lieber zu viel Platz als zu wenig
- Dezente Schatten mit mehreren Layern verwenden
- Typografie-Kontraste durch Gewicht, nicht durch Farbe erzeugen
- Den warmen Dot sparsam und gezielt einsetzen
- Semantische Farben nur für ihren Zweck verwenden
- Outline-Icons konsistent nutzen
- Subtile Hover-Effekte: `translateY(-1px)` + Shadow

### ❌ Don't
- Farbige Buttons oder große farbige Flächen verwenden
- Schwere Drop-Shadows mit hoher Opacity
- Filled Icons mit Outline Icons mischen
- Gradient-Backgrounds oder Verläufe einsetzen
- Den warmen Dot (#C8966D) als Button-Farbe verwenden
- Reines Weiß (#FFFFFF) als Seitenintergrund
- Borders dicker als 0.5px auf Karten
- Animationen über 0.3s für UI-Interaktionen
- Dekorative Elemente ohne Funktion
- UPPERCASE außerhalb von Section Labels

---

## 15. Responsive Breakpoints (Web/Tablet Erweiterung)

| Breakpoint | Verhalten |
|---|---|
| `< 393px` | Mobile Compact — Padding reduzieren auf 18px |
| `393px` | **Design-Referenz** (iPhone 15 Pro) |
| `393–768px` | Mobile — Standard |
| `768–1024px` | Tablet — 2-Column Layout für Spaces |
| `> 1024px` | Desktop — Zentrierter Container max. 480px |

---

## 16. Accessibility

- **Kontrast-Ratio:** Primärtext (`#111111` auf `#F7F6F3`) = 14.5:1 ✅
- **Mindestgröße Touch-Targets:** 40×40px (wie Top-Bar Buttons)
- **Fokus-Indikator:** 2px solid `var(--warm)` mit 2px Offset
- **Reduced Motion:** Progress-Bar und Hover-Transitions respektieren `prefers-reduced-motion`
- **Screen Reader:** Alle Icons mit `aria-label`, Beträge semantisch korrekt markiert

---

## 17. Dateistruktur (Empfehlung für Implementierung)

```
src/
├── styles/
│   ├── tokens.css          ← Alle CSS Custom Properties (Farben, Spacing, etc.)
│   ├── typography.css      ← Font-Imports, Type-Scale Klassen
│   ├── components/
│   │   ├── card.css
│   │   ├── button.css
│   │   ├── badge.css
│   │   ├── progress.css
│   │   ├── navigation.css
│   │   └── avatar.css
│   └── utilities.css       ← Hilfklassen (Spacing, Alignment)
├── assets/
│   ├── logo/
│   │   ├── noon-logo-light.svg
│   │   ├── noon-logo-dark.svg
│   │   └── noon-icon.svg
│   └── icons/              ← Inline SVGs, Feather/Lucide
└── BRAND_IDENTITY.md       ← Dieses Dokument
```

---

## 18. CSS Design Tokens (Copy-Ready)

```css
:root {
  /* ─── Colors ─── */
  --color-bg:           #F7F6F3;
  --color-surface:      #FFFFFF;
  --color-text:         #111111;
  --color-text-mid:     #555555;
  --color-text-light:   #A0A0A0;
  --color-text-faint:   #C8C8C4;
  --color-divider:      #EEEEE9;
  --color-accent:       #111111;
  --color-warm:         #C8966D;
  --color-green:        #2D8653;
  --color-green-bg:     rgba(45, 134, 83, 0.07);
  --color-amber:        #C49332;
  --color-amber-bg:     rgba(196, 147, 50, 0.06);
  --color-red:          #C45A4A;
  --color-red-bg:       rgba(196, 90, 74, 0.06);

  /* ─── Typography ─── */
  --font-family:        'Outfit', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --font-display:       50px;
  --font-h1:            23px;
  --font-h2:            15px;
  --font-body:          15px;
  --font-body-md:       13px;
  --font-caption:       12px;
  --font-overline:      11px;
  --font-micro:         10px;

  /* ─── Spacing ─── */
  --space-xs:           4px;
  --space-sm:           8px;
  --space-md:           14px;
  --space-lg:           22px;
  --space-xl:           28px;
  --space-2xl:          36px;

  /* ─── Radii ─── */
  --radius-card:        18px;
  --radius-button:      14px;
  --radius-icon:        13px;
  --radius-pill:        100px;
  --radius-progress:    3px;

  /* ─── Shadows ─── */
  --shadow-card:
    0 1px 2px rgba(0,0,0,0.03),
    0 4px 12px rgba(0,0,0,0.04),
    0 8px 24px rgba(0,0,0,0.02);
  --shadow-light:       0 1px 3px rgba(0,0,0,0.03);
  --shadow-elevated:
    0 2px 4px rgba(0,0,0,0.04),
    0 8px 24px rgba(0,0,0,0.06),
    0 16px 40px rgba(0,0,0,0.03);

  /* ─── Borders ─── */
  --border-card:        0.5px solid rgba(0,0,0,0.04);
  --border-divider:     0.5px solid rgba(0,0,0,0.06);

  /* ─── Transitions ─── */
  --transition-hover:   box-shadow 0.2s ease, transform 0.15s ease;
  --transition-data:    width 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}
```

---

## 19. Referenz-Design

Das vollständige Referenz-Design ist implementiert als HTML in `Banking-App_Design.html`. Dieses zeigt den Home-Screen mit:
- Top-Bar mit Logo und Action-Buttons
- Zentraler Saldo-Bereich mit Trend-Badge
- Action-Strip mit 3 gleichwertigen Pills
- Space-Cards (Hauptkonto, Urlaub, Essen)
- Shared Space-Card (Auto, geteilt mit Tim)
- Bottom Navigation (Home, Aktivität, Senden, Profil)

**Dieses Design ist die visuelle Wahrheit. Im Zweifelsfall hat das Design-HTML Vorrang.**

---

*noon. — Banking, reduced to the essentials.*
