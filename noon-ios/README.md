# Noon iOS

Premium fintech app built with SwiftUI for managing multi-bank accounts, shared spaces, and intelligent transaction categorization.

## Setup Instructions

1. **Create Xcode Project**
   - Open Xcode → File → New → Project
   - Select iOS App template
   - Product Name: `Noon`
   - Interface: SwiftUI
   - Language: Swift
   - Save to this directory

2. **Add Swift Package Dependencies**
   - In Xcode: File → Add Package Dependencies
   - Add **GRDB.swift**: `https://github.com/groue/GRDB.swift`
   - Add **KeychainAccess**: `https://github.com/kishikawakatsumi/KeychainAccess`

3. **Configure Project**
   - Drag the `Noon/` folder into your Xcode project
   - Copy `Secrets.xcconfig.example` → `Secrets.xcconfig`
   - Fill in your backend API URL and configuration values
   - Add `Secrets.xcconfig` to your project's build configuration

4. **Build and Run**
   - Select target device or simulator
   - Press Cmd+R to build and run

## Architecture

- **MVVM Pattern**: Models, Views, ViewModels clearly separated
- **SwiftUI**: Declarative UI throughout
- **Async/Await**: Modern Swift concurrency
- **Local-First**: Offline support via GRDB
- **Secure Storage**: Keychain for sensitive tokens

## Key Features

- Multi-bank account aggregation
- Shared financial spaces
- Automatic transaction categorization
- Real-time sync with backend
- Offline mode with local caching

See `Dependencies.md` for detailed dependency information.
