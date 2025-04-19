import StoreKit
import SwiftUI

class PaymentManager: NSObject, ObservableObject {
    static let shared = PaymentManager()
    
    @Published var monthlyProduct: SKProduct?
    @Published var yearlyProduct: SKProduct?
    @Published var isSubscribed = false
    
    private let monthlyID = "com.yourdomain.app.monthly"
    private let yearlyID = "com.yourdomain.app.yearly"
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        isSubscribed = UserDefaults.standard.bool(forKey: "isSubscribed")
        loadProducts()
    }
    
    func loadProducts() {
        let request = SKProductsRequest(productIdentifiers: [monthlyID, yearlyID])
        request.delegate = self
        request.start()
    }
    
    func buyMonthly() {
        if let product = monthlyProduct {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func buyYearly() {
        if let product = yearlyProduct {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func formatPrice(_ product: SKProduct?) -> String {
        guard let product = product else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price) ?? "\(product.price)"
    }
}

extension PaymentManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            for product in response.products {
                if product.productIdentifier == self.monthlyID {
                    self.monthlyProduct = product
                } else if product.productIdentifier == self.yearlyID {
                    self.yearlyProduct = product
                }
            }
        }
    }
}

extension PaymentManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                DispatchQueue.main.async {
                    self.isSubscribed = true
                    UserDefaults.standard.set(true, forKey: "isSubscribed")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .deferred, .purchasing:
                break
                
            @unknown default:
                break
            }
        }
    }
}
