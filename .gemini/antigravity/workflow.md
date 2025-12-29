# Antigravity Workflow: Working with Speckit

This document outlines the standard procedure for Antigravity when executing tasks in the PaperHealth repository.

## 1. The Speckit Loop

Every feature or major change follows this lifecycle:

1.  **Specify**: Analyze requirements and update `.specify/spec.md`.
2.  **Plan**: Research and document technical approach in `plan.md`.
    - **Self-Correction**: Perform a "Constitution Check" during planning.
3.  **Task**: Generate a detailed `tasks.md` organized by user story.
4.  **Implement**: Execute tasks one by one, keeping the "brain" (memory) updated.

## 2. Constitutional Synchronization

- Whenever `constitution.md` is updated, Antigravity should:
  - Bump the version in the Sync Impact Report and footer.
  - Review all `.specify/templates` to ensure checklists (like "Constitution Check") aren't outdated.
  - Check `README.md` or `quickstart.md` for consistency.

## 3. Implementation Standards

- **Flutter/Dart**:
  - Null-safety is mandatory.
  - No `dynamic` types.
  - Use `Freezed` for data models (if configured).
  - Use `Riverpod` for all state management.
- **Layers**:
  - `View` -> `Provider/ViewModel` -> `Repository` -> `Source`.
  - Data must be encrypted at the `Data Source` or `Repository` layer.

## 4. Documentation Standards

- All non-obvious architecture decisions must be documented in the relevant `.specify/memory/` or project `docs/`.
- Use the `Sync Impact Report` HTML comment at the top of memory files to track evolution.
