//
//  SharedProfile.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 22.06.21.
//

import SwiftUI

class SharedProfile: ObservableObject {
    @Published var profile: Profil
    
    init() {
        self.profile = Profil(ID: "", given:"", family:"", bday: Date(), rolle: "")
    }

    func Update(input: Profil){
        self.profile = input
        print("Created Observable Object : \(self.profile.given)")
    }
    
    func GetValue() -> Profil {
        print("Returning value: \(self.profile)")
        return self.profile
    }
}
