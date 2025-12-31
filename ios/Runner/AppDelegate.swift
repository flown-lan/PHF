import Flutter
import UIKit
import Vision
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 1. Register Workmanager Plugin and custom plugins for background execution (Headless)
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
        if let registrar = registry.registrar(forPlugin: "NativeOCRPlugin") {
            NativeOCRPlugin.register(with: registrar)
        }
    }
    
    // 2. Register Plugins for Main App
    GeneratedPluginRegistrant.register(with: self)
    if let registrar = self.registrar(forPlugin: "NativeOCRPlugin") {
        NativeOCRPlugin.register(with: registrar)
    }
    
    // 3. Register Background Task Identifier
    // Handled by WorkmanagerPlugin to route BGTask to Dart callback
    WorkmanagerPlugin.registerTask(withIdentifier: "com.example.phf.ocr.processing_task")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}