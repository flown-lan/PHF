# Constitution Quick-Check

Use this checklist during code reviews or before concluding any implementation task.

## 🔐 Privacy & Security (Primary)
- [ ] **NO NETWORK**: Ensure zero external network calls.
- [ ] **ENCRYPTION**: SQLite is SQLCipher-encrypted. Files are AES-256 encrypted.
- [ ] **SENSITIVITY**: No PII (names, IDs, diagnosis) in logs. PII is only stored encrypted.
- [ ] **MEMORY**: Clear sensitive strings from memory as soon as possible.
- [ ] **OCR CACHE**: Temporary images for OCR must be deleted immediately after processing.

## 📱 Architecture & Code
- [ ] **MVVM**: Separation of View, ViewModel (Riverpod), and Model.
- [ ] **LAYERS**: UI -> Logic (Riverpod) -> Data Layer (Repository) -> Source (Encrypted).
- [ ] **OFFLINE**: Feature must work 100% without an internet connection.
- [ ] **ERRORS**: No raw stack traces to users. Use user-friendly toasts/snackbars.
- [ ] **LOGS**: Use `logger` package only. No `print()`.

## 🏗️ Standards
- [ ] **DART**: Strict typing, no `dynamic`.
- [ ] **NAMING**: PascalCase for types, camelCase for variables/functions.
- [ ] **GIT**: Conventional Commits (`feat:`, `fix:`, `docs:`, etc.).
- [ ] **MEMORY SYNC**: Update `constitution.md` versioning if rules change.
