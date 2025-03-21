//
//  MainView.swift
//  Vaccinator
//
//  Created by Vici Zeillinger on 07.05.21.
//

import SwiftUI
import LocalAuthentication

struct MainView: View {
    @State private var isUnlocked = false
    @State var ready = false
    var body: some View {
        VStack {
            if isUnlocked {
                Profil_AuswahlView(profiles: [], profile: Profil(ID: "", given: "", family: "", bday: Date(), rolle: ""))
            }
        }
        .onAppear(perform: authenticate)
        .onAppear(perform: ask)
               
    }
    
    
    func ask() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
        }
    
    func authenticate() {
            let context = LAContext()
            var error: NSError?

            // check whether biometric authentication is possible
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "Da es um kritische Gesundheitsdaten geht, wird der Zugang gesperrt"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // authentication has now completed
                    DispatchQueue.main.async {
                        if success {
                            self.isUnlocked = true
                        } else {
                            authenticate()
                        }
                    }
                }
            } else {
                // no biometrics
            }
    }
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
