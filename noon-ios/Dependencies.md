# Dependencies

## Swift Package Manager Dependencies

### GRDB.swift
- **Repository**: https://github.com/groue/GRDB.swift
- **Purpose**: Local SQLite caching for offline support
- **Used By**:
  - `Core/Storage/DatabaseManager.swift` — Database setup and migrations
  - `Core/Storage/AccountStore.swift` — Local account persistence
  - `Core/Storage/TransactionStore.swift` — Local transaction caching
- **Why**: GRDB provides a Swift-native, type-safe SQLite wrapper with excellent Codable integration, making it ideal for offline-first data persistence

### KeychainAccess
- **Repository**: https://github.com/kishikawakatsumi/KeychainAccess
- **Purpose**: Simplified Keychain API for secure token storage
- **Used By**:
  - `Core/Networking/TokenManager.swift` — Secure storage of auth tokens
- **Why**: KeychainAccess provides a clean, modern Swift API for secure credential storage, eliminating the complexity of Apple's raw Keychain APIs

## Installation

Both dependencies are installed via Swift Package Manager:

1. In Xcode: File → Add Package Dependencies
2. Enter the repository URL
3. Select version (use latest stable)
4. Add to target: Noon

## Security Notes

- **NEVER** commit `Secrets.xcconfig` to version control
- The iOS app **NEVER** talks to Tink directly — all bank connections go through the backend
- No Tink API keys or credentials are stored in the iOS codebase
- Authentication tokens are stored in the Keychain, never in UserDefaults
