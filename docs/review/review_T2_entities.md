# Review T2: Domain Entities

**Review Date**: 2025-12-29
**Reviewer**: Antigravity
**Status**: 🔴 CHANGES REQUESTED

## Summary
The implementation of core entities (`MedicalRecord`, `MedicalImage`, etc.) has successfully leveraged `freezed` for immutability and serialization. However, there are critical deviations from the approved `spec.md` that must be addressed before proceeding to the interface definitions.

## Critical Issues (Must Fix)

### 1. Missing `personId` (Privacy & Multi-user Support)
- **Violation**: The `MedicalRecord` entity lacks a `personId` field.
- **Spec Reference**: `spec.md#4.1 records Table` defines `person_id TEXT NOT NULL REFERENCES persons(id)`.
- **Impact**: Without this field, the application cannot associate records with specific user profiles, breaking the core "Multi-user Architecture" requirement.
- **Action**: Add `required String personId` to `MedicalRecord` and `Tag` (nullable for global tags).

### 2. Field Schema Mismatch
- **Violation**: Entity fields do not align with the functional requirements defined in `spec.md`.
- **Details**:
  - `MedicalRecord`: Replaced `hospital_name` and `notes` with a generic `title`.
    - **Action**: Add `String? hospitalName` and `String? notes`. `title` can be a computed getter (e.g., `hospitalName ?? 'Unknown'`).
  - `MedicalRecord`: Missing `updatedAt`.
    - **Action**: Add `required DateTime updatedAt`.
  - `MedicalImage`: Missing metadata fields required for file management.
    - **Action**: Add `String mimeType` (default `image/webp`), `int fileSize`, and `required DateTime createdAt`.

### 3. Missing Documentation Artifact
- **Violation**: The task required documenting "ID generation rules & JSON serialization standards".
- **Status**: No such document found in `docs/knowledge/` or `lib/data/models/README.md`.
- **Action**: Create `docs/knowledge/ENTITY_STANDARDS.md` specifying:
  - ID Strategy: UUID v4 (canonical source).
  - Serialization: `json_serializable` conventions via `freezed`.

## Recommendations (Optimization)

### 1. Robustness Testing
- Add tests for edge cases:
  - `tagsCache` handling when containing invalid JSON strings.
  - Null safety checks for optional fields during deserialization.

---

**Next Steps**:
1. Update `MedicalRecord` and `MedicalImage` classes in `lib/data/models/`.
2. Run `dart run build_runner build` to regenerate freezed files.
3. Create the missing `ENTITY_STANDARDS.md`.
4. Update unit tests in `test/data/models_test.dart`.