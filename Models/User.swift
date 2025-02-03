import Foundation
import FirebaseAuth

enum AccountType: String, Codable {
    case trainer
    case user
}

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let accountType: AccountType
    var profileCompleted: Bool
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, email: String, accountType: AccountType) {
        self.id = id
        self.email = email
        self.accountType = accountType
        self.profileCompleted = false
        self.createdAt = Date()
        self.updatedAt = Date()
    }
} 