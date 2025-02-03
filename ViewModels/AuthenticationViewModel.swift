import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    private let authService = AuthenticationService.shared
    
    init() {
        print("AuthViewModel initialized")
    }
    
    func signIn(email: String, password: String) {
        print("Attempting sign in with email: \(email)")
        Task {
            do {
                let user = try await authService.signIn(email: email, password: password)
                await MainActor.run {
                    self.user = user
                    self.isAuthenticated = true
                    print("Sign in successful")
                }
            } catch {
                await MainActor.run {
                    self.error = error
                    print("Sign in failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func signUp(email: String, password: String, accountType: AccountType) {
        Task {
            do {
                let user = try await authService.signUp(email: email, password: password, accountType: accountType)
                await MainActor.run {
                    self.user = user
                    self.isAuthenticated = true
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
} 