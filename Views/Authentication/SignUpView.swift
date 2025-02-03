import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var accountType: AccountType = .trainer
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Account Type", selection: $accountType) {
                Text("Trainer").tag(AccountType.trainer)
                Text("User").tag(AccountType.user)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button(action: {
                authViewModel.signUp(email: email, 
                                  password: password, 
                                  accountType: accountType)
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
} 