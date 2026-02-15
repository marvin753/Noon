<p align="center">
  <img src="assets/noon-logo.png" alt="Noon Logo" width="80"/>
</p>

<h1 align="center">Noon</h1>

<p align="center">
  <strong>Banking, reduced to the essentials.</strong>
</p>

<p align="center">
  A radically minimal, premium banking frontend for iOS — connecting all your bank accounts into one beautifully simple experience.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-iOS-black?style=flat-square" alt="Platform: iOS"/>
  <img src="https://img.shields.io/badge/swift-5.9+-F05138?style=flat-square&logo=swift&logoColor=white" alt="Swift 5.9+"/>
  <img src="https://img.shields.io/badge/iOS-17.0+-000000?style=flat-square&logo=apple&logoColor=white" alt="iOS 17.0+"/>
  <img src="https://img.shields.io/badge/license-proprietary-lightgrey?style=flat-square" alt="License"/>
</p>

---

## About

Noon is a customizable banking frontend that works across different banks. Instead of juggling multiple banking apps, Noon gives you a single, unified interface to manage your finances — with the design quality you'd expect from a premium fintech product.

Built for people who want clarity over clutter. No noise, no unnecessary features — just the essentials, done exceptionally well.

## Key Features

**Multibanking Dashboard** — Connect multiple bank accounts from different providers and see everything in one place. One app, all your money.

**Virtual Sub-Accounts (Spaces)** — Create virtual pots and envelopes for budgeting without needing real IBANs. Organize your money by purpose, not by account.

**Smart Transaction Categorization** — User-defined rules combined with intelligent pre-categorization that learns from your behavior. Targets 95% automation after the first month of use.

**Shared Financial Management** — Built for couples and families. Share virtual budgeting categories across different banks and manage finances together, even with separate accounts.

**Radical Minimalism** — Every screen is designed with intention. Premium feel through typography, spacing, and subtle visual cues — not decoration.

## Design Philosophy

Noon follows a strict design language that balances radical minimalism with the interactivity required for a daily-use fintech app:

- **Outfit** font family with strategic weight contrasts for visual hierarchy
- The signature **warm dot** as the core brand element
- Individual space cards with clear visual separation
- Percentage-based budget tracking indicators
- Spatial breathing room over decorative elements

The target is a UI/UX that competes with — and exceeds — the best in the market.

## Architecture

```
noon/
├── App/                    # App entry point & configuration
├── Core/
│   ├── Models/             # Domain models & entities
│   ├── Services/           # Business logic & API layer
│   ├── Storage/            # Local persistence (SQLite)
│   └── Rules/              # Transaction categorization engine
├── Features/
│   ├── Dashboard/          # Main account overview
│   ├── Spaces/             # Virtual sub-accounts
│   ├── Transactions/       # Transaction list & details
│   ├── Shared/             # Shared finance management
│   └── Settings/           # User preferences & bank connections
├── DesignSystem/
│   ├── Components/         # Reusable UI components
│   ├── Theme/              # Colors, typography, spacing
│   └── Assets/             # Icons, images, brand elements
└── Networking/
    ├── BankingAPI/          # Tink API integration (AIS/PIS)
    └── Auth/               # Authentication & PSD2 consent flow
```

## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Architecture | MVVM |
| Banking API | Tink (AIS & PIS) |
| Local Storage | SQLite |
| Auth | PSD2 consent flow via Tink |
| Min. Target | iOS 17.0+ |

## Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.0+ simulator or device
- Swift 5.9+
- A Tink developer account (for API access)

### Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/noon-ios.git
cd noon-ios

# Open the project
open Noon.xcodeproj
```

Create a `Secrets.xcconfig` file in the project root (not tracked by git):

```
TINK_CLIENT_ID = your_client_id
TINK_CLIENT_SECRET = your_client_secret
```

Build and run on your target device or simulator.

## Roadmap

- [x] App naming & brand identity
- [ ] UI/UX design iterations
- [ ] Core dashboard implementation
- [ ] Tink API integration (AIS)
- [ ] Virtual sub-accounts (Spaces)
- [ ] Transaction categorization engine
- [ ] User-defined categorization rules
- [ ] Learning algorithm for auto-categorization
- [ ] Shared Spaces for couples & families
- [ ] Payment initiation (PIS)

## Target Audience

Noon is built for users aged 18–45 who want a cleaner, smarter way to manage their finances across multiple banks. It's for people who value design, simplicity, and control.

## License

This project is proprietary. All rights reserved.

---

<p align="center">
  <sub>Built with clarity in mind.</sub>
</p>
