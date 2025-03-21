//
//  empfohlenView.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 15.05.21.
//

import SwiftUI
import SMART

struct EmpfohlenView: View {
    let endpoint = ImmunizationEndpoint()
    
    @State var impfungen : [Impfung]
    @State var ready = false
    
    
    func loadImpfungen() {
            impfungen.removeAll()
            print("load Impfungen")
            endpoint.getAllImmunizations() { (immunizations, error) -> () in
                if immunizations != nil {
                    for practitioner in immunizations ?? [] {
                        let impfung = Impfung(id: practitioner?.id?.string ?? "no ID",
                                              patientId: "",
                                              name: practitioner?.name?[0].family?.string ?? "kein name", datum: practitioner?.birthDate?.nsDate,
                                              nebenwirkungen: practitioner?.address?[0].text?.string ?? "keine nebenwirkungen",
                                              reiseInfos: practitioner?.address?[0].postalCode?.string ?? "keine reiseinfos",
                                              impfstrategie: practitioner?.address?[0].district?.string ?? "keine Impfstrategie",
                                              teilimpfung: nil)
                        
                        if impfung.datum == nil {
                            impfungen.append(impfung)
                        }
                    }
                }
            }
    }
    
    var body: some View {
        List(impfungen) { impfung in
            NavigationLink(destination: DetailansichtView(impfung: impfung)) {
                ImpfungRow(impfung: impfung)
            }
        }.onAppear(perform: loadImpfungen)
    }
}

struct EmpfohlenView_Previews: PreviewProvider {
    static var previews: some View {
        EmpfohlenView(impfungen: [])
    }
}
