import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Welcome to Fitness AI Trainer!")
            .padding()
    }
} 