import SwiftUI

struct AuthenticationView: View {
    @State private var isSignIn = true
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if isSignIn {
                    SignInView()
                } else {
                    SignUpView()
                }
                
                if let error = authViewModel.error {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    isSignIn.toggle()
                }) {
                    Text(isSignIn ? "Don't have an account? Sign Up" : "Already have an account? Sign In")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle(isSignIn ? "Sign In" : "Sign Up")
        }
    }
} 