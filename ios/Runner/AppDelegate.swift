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
            if flutterMethodCall.method == "startNewActivity" {
                UIView.animate(withDuration: 0.5, animations: {
                    self.window?.rootViewController = nil
                    
                    let viewToPush = SecondViewController()
                    
                    let navigationController = UINavigationController(rootViewController: flutterViewController)
                    
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.makeKeyAndVisible()
                    self.window.rootViewController = navigationController
                    navigationController.isNavigationBarHidden = false
                    navigationController.pushViewController(viewToPush, animated: false)
                    
                })
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
}

