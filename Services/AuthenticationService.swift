import Foundation
import FirebaseAuth
import GoogleSignIn

enum AuthError: Error {
    case signInFailed
    case signUpFailed
    case googleSignInFailed
    case userNotFound
    case invalidAccountType
}

class AuthenticationService {
    static let shared = AuthenticationService()
    private let firebaseManager = FirebaseManager.shared
    
    func signUp(email: String, password: String, accountType: AccountType) async throws -> User {
        do {
            let authResult = try await firebaseManager.auth.createUser(withEmail: email, password: password)
            
            let user = User(
                id: authResult.user.uid,
                email: email,
                accountType: accountType
            )
            
            // Save user to Firestore
            try await firebaseManager.firestore
                .collection("users")
                .document(user.id)
                .setData(try user.asDictionary())
            
            return user
        } catch {
            throw AuthError.signUpFailed
        }
    }
    
    func signIn(email: String, password: String) async throws -> User {
        do {
            let authResult = try await firebaseManager.auth.signIn(withEmail: email, password: password)
            
            // Fetch user data from Firestore
            let userDoc = try await firebaseManager.firestore
                .collection("users")
                .document(authResult.user.uid)
                .getDocument()
            
            guard let userData = userDoc.data(),
                  let user = try? User(dictionary: userData) else {
                throw AuthError.userNotFound
            }
            
            return user
        } catch {
            throw AuthError.signInFailed
        }
    }
    
    func signInWithGoogle() async throws -> User {
        // Implementation for Google Sign-in
        // This will be implemented in the next step
        throw AuthError.googleSignInFailed
    }
    
    func signOut() throws {
        try firebaseManager.auth.signOut()
    }
}

// Helper extensions for Codable
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension User {
    init?(dictionary: [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        self = try JSONDecoder().decode(User.self, from: data)
    }
} 