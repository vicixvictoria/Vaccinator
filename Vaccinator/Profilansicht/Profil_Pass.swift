//
//  Profil_Pass.swift
//  Vaccinator
//
//  Created by Vici Zeillinger on 22.06.21.
//

import Foundation

struct Profil_Pass: Identifiable {
    let uuid = UUID()
    let id : String
    let name1: String
    let name2: String
    var bday: Date?
    var rolle: String
    var gender: String
    
    static let example = Profil_Pass(id: "140", name1: "Vici", name2: "Zeillinger", bday: Date(), rolle: "Admin", gender: "unknown")
}
