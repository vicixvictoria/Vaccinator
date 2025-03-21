//
//  Impfung.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 07.06.21.
//

import Foundation

 
    let uuid = UUID()
    let id : String
    let patientId : String
    let name: String
    var datum: Date?
    let nebenwirkungen : String
    let reiseInfos : String
    let impfstrategie : String
    let teilimpfung : String?
    
    static let exmple = Impfung(id: "7", patientId: "" , name: "Tetanus", datum: Date(), nebenwirkungen: "nebenwirkungen", reiseInfos: "reise", impfstrategie: "strategie", teilimpfung: nil)
}


