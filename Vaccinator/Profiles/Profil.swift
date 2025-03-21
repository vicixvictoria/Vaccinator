//
//  Profil.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 22.06.21.
//


import SwiftUI

class Profil: Identifiable, Codable {
    
    var id = UUID()
    var ID : String = ""
    var given: String = ""
    var family: String = ""
    var rolle: String = ""
    var svnr: String = ""
    var gender: String = ""
    var bday : Date?
    
    init(ID: String, given: String, family: String, bday : Date?, rolle: String)
    {
        self.ID = ID
        self.given = given
        self.family = family
        self.bday = bday
        self.rolle = rolle
    }
    
    //static let example = Profil(given: "Maxi", family: "Reisecker", rolle:  "Admin", svnr: "1234567899" , gender: "Admin", bday: Date())
    //static let example = Profil()

}
