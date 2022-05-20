import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screenBounds = UIScreen.main.bounds
        let window = UIWindow(frame: screenBounds)

        self.window = window

        AppController.shared.configureApp(window: window)

        window.makeKeyAndVisible()

        return true
    }
}
