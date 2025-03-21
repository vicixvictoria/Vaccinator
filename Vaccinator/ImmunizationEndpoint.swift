//
//  ImmunizationEndpoint.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 15.06.21.
//

import Foundation
import SMART

public class ImmunizationEndpoint {
    
    let smart = Client(
        baseURL: URL(string: "http://localhost:8080/fhir/")!,
        settings: [
            "client_name": "Unser Client",
            "redirect": "smartapp://callback",
            ])
    
    func createImmunization(impfung: Practitioner) -> Void {
        impfung.create(smart.server) { error in
            
        }
    }
    
    
    func readImmunizationById(id: Int, completion: @escaping (Practitioner?, Error?) -> Void ) {
        Practitioner.read("\(id)", server: smart.server) { (resource, error) in
                guard error == nil else {
                    completion(nil, error)
                    print("Error")
                    return
                }
                
                if let impfung = resource as? Practitioner {
                    // Complete with the patient resource.
                    completion(impfung, nil)
                } else {
                    // No Patient Resource exists for this user.
                    completion(nil, nil)
                }
            }
        }
    
    func getAllImmunizations(completion: @escaping ([Practitioner?]?, Error?) -> Void ) {
        Practitioner.search([]).perform(smart.server) { (bundle, error) in
            guard error == nil else {
                completion(nil, error)
                print("error")
                return
            }
            var bundleEntry = bundle?.entry
            if bundleEntry == nil {
                completion(nil, nil)
            } else {
                var impfungen = [Practitioner?]()
                while bundleEntry?.isEmpty == false {
                    let impfung = bundleEntry?.removeFirst().resource as? Practitioner
                    impfungen.append(impfung)
                }
                // Complete with the patient resource.
                completion(impfungen, nil)
            }
                 
            }
        }
    
    
    func deleteImmunization(id: String) -> Void {
        let idnum = Int(id) ?? 0
        print("löschen mit id: \(id)")
        //var practitioner : Practitioner?
        readImmunizationById(id: idnum) { (immunization, error) -> () in
            immunization?.delete() { error in
                print("löschen")
            }
        }
        
    }
    
    
    
}

