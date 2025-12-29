# Implementation Plan: Phase 1 - Architecture & MVP Loop

**Branch**: `feat/phase1-baseline` | **Date**: 2025-12-28
**Spec**: [.specify/spec.md](file:///Users/lanzf/Projects/PHF/.specify/spec.md)

---

## 1. Summary
本计划旨在构建 PaperHealth 的核心基础设施与 MVP 闭环。重点落实 **“Security First”** 策略，通过 SQLCipher 和 AES-256-GCM 确保医疗数据的绝对隐私。我们将按照分层架构，从底层安全基础设施逐步向上构建，直至实现完整的拍照录入并展示在 Timeline 的核心流程。

---

## 2. Constitution Check

*GATE: Must pass before implementation.*

- [x] **I. 隐私与安全 (Privacy & Security)**: 应用核心功能完全离线，不产生网络请求。所有图片和数据库均采用 256 位加密存储。
- [x] **II. 本地优先 (Local-First)**: 所有数据处理（压缩、加密）均在设备端执行。
- [x] **III. 智能数字化 (Intelligent Digitization)**: Phase 1 实现了“拍照 -> 结构化存储”的基础数字化能力，并预留了 OCR 接口。
- [x] **IV. 架构规范 (MVVM)**: 明确划分 UI (View)、Logic (Riverpod)、Data (Repository) 层次。

---

## 3. Implementation Phases & Tasks

### Phase 1: Infrastructure & Security (基础设施层)
**Goal**: 建立全应用的安全信任根基。

| ID | Task | DoD (验收标准) | Dependencies |
| :--- | :--- | :--- | :--- |
| **T1.1** | **集成本地主密钥管理 (Secure Storage)** | 使用 `flutter_secure_storage` 在 KeyChain/KeyStore 中持久化生成 256-bit Master Key。 | - |
| **T1.2** | **SQLCipher 加密数据库初始化** | 成功打开加密 DB，执行元数据（`app_meta`）写入测试，外部 SQLite 浏览器无法读取。 | T1.1 |
| **T1.3** | **AES-256-GCM 图片加密工具类开发** | 编写单元测试，验证 `Encrypt(Data) -> Decrypt(Encrypted) == Data`。**注意**: 必须实现随机 IV 且将其预置在加密文件头部（Prepend to file）。 | T1.1 |
| **T1.4** | **目录管理与沙盒隔离** | 确保图片、缩略图存储在 `getApplicationDocumentsDirectory` 下的隔离文件夹中，外部不可见。 | - |

### Phase 2: Data & Persistence (数据访问层)
**Goal**: 建立结构化数据模型与持久化方案。

| ID | Task | DoD (验收标准) | Dependencies |
| :--- | :--- | :--- | :--- |
| **T2.1** | **Database Schema 部署** | 按照 `spec.md` 创建 `records`, `images`, `tags` 等全部表结构。 | T1.2 |
| **T2.2** | **Repository 模式实现** | 实现 `RecordRepository` 和 `ImageRepository`。核心逻辑：更新 `image_tags` 时需自动同步更新 `records.tags_cache` 以供展示。 | T2.1, T1.3 |
| **T2.3** | **种子数据初始化 (Seed Data)** | 应用首次启动时自动创建默认用户（"本人"）并插入定义的 4 个内置标签。 | T2.1 |

### Phase 3: Business Logic & Utilities (业务逻辑层)
**Goal**: 实现图片处理引擎与业务状态管理。

| ID | Task | DoD (验收标准) | Dependencies |
| :--- | :--- | :--- | :--- |
| **T3.1** | **图片处理引擎 (Optimizer)** | 集成 `image` 插件，实现 WebP 压缩及 200px 缩略图生成。DoD: 控制原图大小在 500KB 以内。 | - |
| **T3.2** | **Riverpod 状态管理搭建** | 创建 `TimelineNotifier` (首页列表状态) 和 `IngestionNotifier` (录入流程状态)。 | T2.2 |
| **T3.3** | **文件流式加密适配** | 处理超过 5MB 的图片时，内存消耗稳定，不产生 OOM 崩溃。 | T1.3, T3.1 |

### Phase 4: UI Development (界面展示层)
**Goal**: 实现宪章风格的 UI Kit 与核心交互路径。

| ID | Task | DoD (验收标准) | Dependencies |
| :--- | :--- | :--- | :--- |
| **T4.1** | **UI Kit 基础组件开发** | 实现 `ActiveButton`, `MonospacedText`, `SecurityIndicator` (显示加密状态)。 | - |
| **T4.2** | **录入闭环 UI (Camera/Gallery -> Edit -> Save)** | 用户可通过相机录入或从相册批量选择图片，支持预览缩略图、填写医院并保存。 | T3.2, T4.1 |
| **T4.3** | **首页 Timeline 与 详情页展示** | 首页按日期分组展示卡片，详情页点击可大图浏览（解密后展示）。 | T4.2 |

---

## 4. Verification Plan

### Automated Tests
- **Security Unit Tests**: `test/security/encryption_test.dart` (验证 AES-256-GCM 正确性)。
- **Database Integration Tests**: `test/data/db_migration_test.dart` (验证 Schema 正确性)。
- **Repository Tests**: `test/data/repository_test.dart` (验证存入加密数据后查询出的原文一致性)。

### Manual Verification
1.  **物理导出验证**: 手动从真机沙盒导出 `.db` 和 `.webp.enc` 文件，尝试用标准工具打开，确认不可读。
2.  **离线性能检查**: 记录从按下“保存”到返回首页的耗时，通过控制台日志输出加密耗时。
3.  **UI 走查**: 确认医疗数值（如日期、潜在的后期 OCR 数值）是否使用了 Inconsolata 等宽字体。

---

## 5. Potential Constraints & Risks
- **Performance**: 大量图片同时解密展示在 Timeline 时可能造成的滑动掉帧。*对策：严格使用缩略图并行解密，并限制单个 View 的内存缓存。*
- **Key Loss**: 若主密钥丢失，数据理论上永久不可找回。*对策：Phase 1 需确保 KeyStore 的持久化可靠性。*
