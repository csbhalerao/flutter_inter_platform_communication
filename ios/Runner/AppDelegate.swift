import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
var controller : FlutterViewController?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    guard let flutterViewController  = window?.rootViewController as? FlutterViewController else {
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    let flutterChannel = FlutterMethodChannel.init(name: "test_activity", binaryMessenger: flutterViewController);
    flutterChannel.setMethodCallHandler { (flutterMethodCall, flutterResult) in
        
        UIView.animate(withDuration: 0.5, animations: {
            self.window?.rootViewController = nil
            
            let viewToPush = SecondViewController()
            
            let navigationController = UINavigationController(rootViewController: flutterViewController)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.makeKeyAndVisible()
            self.window.rootViewController = navigationController
            navigationController.isNavigationBarHidden = true
            navigationController.pushViewController(viewToPush, animated: true)
        })
        
        
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

