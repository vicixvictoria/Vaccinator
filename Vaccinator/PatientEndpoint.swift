//
//  PatientEndpoint.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 15.06.21.
//

import Foundation
import SMART

public class PatientEndpoint {
    
    let smart = Client(
        baseURL: URL(string: "http://localhost:8080/fhir/")!,
        settings: [
            "client_name": "Unser Client",
            "redirect": "smartapp://callback",
            ])
    
   
    @Published var firstName :String = ""
    @Published var lastName :String = ""
    @Published var gender :String = ""
    @Published var birthDay = Date()
    
    func createPatient(patient: Patient) -> Void {
        patient.create(smart.server) { error in
            
        }
    }
    
    func readPatientById(id: Int, completion: @escaping (Patient?, Error?) -> Void ) {
        Patient.read("\(id)", server: smart.server) { (resource, error) in
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                if let patient = resource as? Patient {
                    print(patient.name)
                    // Complete with the patient resource.
                    completion(patient, nil)
                } else {
                    // No Patient Resource exists for this user.
                    completion(nil, nil)
                }
            }
        }
    
    func getAllPatient(completion: @escaping ([Patient?]?, Error?) -> Void ) {
        Patient.search([]).perform(smart.server) { (bundle, error) in
            guard error == nil else {
                completion(nil, error)
                print("error")
                return
            }
           
            var bundleEntry = bundle?.entry
            if bundleEntry == nil {
                completion(nil, nil)
            } else {
                var patients = [Patient?]()
                while bundleEntry?.isEmpty == false {
                    let patient = bundleEntry?.removeFirst().resource as? Patient
                    patients.append(patient)
                }
                // Complete with the patient resource.
                completion(patients, nil)
            }
            }
        }

    func deletePatient(patient: Patient) -> Void {
        patient.delete() { error in
            // check error
        }
    }
    
}

