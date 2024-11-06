import Combine

// 需要使用Foundation才能正常使用
import Foundation

final class SettingStore: ObservableObject {
    init() {
        // 這裡不是預設值 也有可能是被儲存的資料覆蓋 所以才跟這邊不一樣
        UserDefaults.standard.register(defaults: [
            "view.preferences.showCheckInOnly": false,
            "view.preferences.displayOrder": 1,
            "view.preferences.maxPriceLevel": 5
        ])
    }

    // 書上的版本
    @Published var showCheckInOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferences.showCheckInOnly") {
        didSet {
            UserDefaults.standard.set(showCheckInOnly, forKey: "view.preferences.showCheckInOnly")
        }
    }

    @Published var displayOrder: DisplayOrderType = .init(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder")) {
        didSet {
            UserDefaults.standard.set(displayOrder.rawValue, forKey: "view.preferences.displayOrder")
        }
    }

    @Published var maxPriceLevel: Int = UserDefaults.standard.integer(forKey: "view.preferences.maxPriceLevel") {
        didSet {
            UserDefaults.standard.set(maxPriceLevel, forKey: "view.preferences.maxPriceLevel")
        }
    }

    // AI的版本
//    var showCheckInOnly: Bool {
//        get {
//            UserDefaults.standard.bool(forKey: "view.preferences.showCheckInOnly")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "view.preferences.showCheckInOnly")
//        }
//    }
//
//    var displayOrder: DisplayOrderType {
//        get {
//            .init(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder"))
//        }
//        set {
//            UserDefaults.standard.set(newValue.rawValue, forKey: "view.preferences.displayOrder")
//        }
//    }
//
//    var maxPriceLevel: Int {
//        get {
//            UserDefaults.standard.integer(forKey: "view.preferences.maxPriceLevel")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "view.preferences.maxPriceLevel")
//        }
//    }
}
