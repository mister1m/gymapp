import SwiftUI
import Firebase
import GoogleSignIn

struct RegistrationView: View {
    @State private var isSignedIn = false

    var body: some View {
        VStack(spacing: 20) {
            // Header
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Google Sign-In Button
            Button(action: {
                signInWithGoogle()
            }) {
                HStack {
                    Image("google_logo") // Add your Google logo image here
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Register with Google")
                        .fontWeight(.medium)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.top, 40)
            
            Spacer()
        }
        .padding()
        .onAppear {
            // Check if user is already signed in
            if GIDSignIn.sharedInstance.currentUser != nil {
                isSignedIn = true
            }
        }
    }

    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Error: Unable to retrieve client ID")
            return
        }

        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()) { result, error in
            guard error == nil else {
                print("Error signing in: \(error!.localizedDescription)")
                return
            }
            
            guard let result = result else { return }
            let authentication = result.user.authentication
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

            // Sign in with Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign-in error: \(error.localizedDescription)")
                    return
                }
                // User is signed in
                isSignedIn = true
                print("User signed in: \(authResult?.user.uid ?? "")")
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
