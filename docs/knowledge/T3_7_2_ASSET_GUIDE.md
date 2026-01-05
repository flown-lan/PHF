# T3.7.2 资产适配指南 (Asset Adaptation Guide)

## 1. 概述
本项目使用 `flutter_launcher_icons` 和 `flutter_native_splash` 来自动化管理多平台图标及启动页资产。

## 2. 原始素材
- **图标原件**: `assets/source/icon.png` (1024x1024, 建议 Teal #008080 背景)
- **启动背景**: `assets/source/splash.png` (由插件通过配色和图标自动合成)

## 3. 生成命令

### 生成应用图标 (Launcher Icons)
```bash
dart run flutter_launcher_icons
```

### 生成原生启动页 (Native Splash)
```bash
dart run flutter_native_splash:create
```

## 4. 注意事项
- **Android 12+**: 插件已针对 Android 12 的图标规范进行了配置。
- **iOS**: 自动更新 `AppIcon.appiconset` 和 `LaunchScreen.storyboard`。
- **版本控制**: 建议在生成资产后，将产生的图片文件一同提交，以确保 CI/CD 构建的一致性。
