import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseAuth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyB5H9ZiImw5B6zL3YBQRlCk4j7meb4uuQg")
        GeneratedPluginRegistrant.register(with: self)
//    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().isAutoInitEnabled = true
    if #available(iOS 10.0, *) {

      UNUserNotificationCenter.current().delegate = self

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in }
      )
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
    Messaging.messaging().apnsToken = deviceToken
      

  }
    
}
