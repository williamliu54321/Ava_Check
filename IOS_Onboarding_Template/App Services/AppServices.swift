import SwiftUI
import UserNotifications
import StoreKit

/// AppServices provides core system functionalities:
/// - Notification permissions
/// - App reviews
/// - User personalization
class AppServices: ObservableObject {
    // Singleton instance
    static let shared = AppServices()
    
    // Published properties
    @Published var notificationsAuthorized: Bool = false
    @Published var personalizationEnabled: Bool = false
    
    // Private properties
    @AppStorage("hasReviewed") private var hasReviewed: Bool = false
    
    private init() {
        checkNotificationAuthorizationStatus()
        personalizationEnabled = UserDefaults.standard.bool(forKey: "personalizationEnabled")
    }
    
    // MARK: - Notifications
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.notificationsAuthorized = granted
                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func checkNotificationAuthorizationStatus() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationsAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    // MARK: - App Review
    
    func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
            hasReviewed = true
        }
    }
    
    func openAppStoreForReview() {
        let appId = "YOUR_APP_ID" // Replace with your app ID
        let urlStr = "https://itunes.apple.com/app/id\(appId)?action=write-review"
        
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
            hasReviewed = true
        }
    }
    
    // MARK: - Personalization
    
    func setPersonalization(enabled: Bool) {
        personalizationEnabled = enabled
        UserDefaults.standard.set(enabled, forKey: "personalizationEnabled")
    }
    
    func saveUserPreferences(preferences: [String: Any]) {
        UserDefaults.standard.set(preferences, forKey: "userPreferences")
    }
    
    func getUserPreferences() -> [String: Any] {
        return UserDefaults.standard.dictionary(forKey: "userPreferences") ?? [:]
    }
}
