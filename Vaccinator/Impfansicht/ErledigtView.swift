//
//  ErledigtView.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 15.05.21.
//

import SwiftUI

struct ErledigtView: View {
    let endpoint = ImmunizationEndpoint()
    
    @State var impfungen : [Impfung]
    @State var ready = false
    @EnvironmentObject var sharedProfil: SharedProfile
    
    
    
    func loadImpfungen() {
        impfungen.removeAll()
        print("load Impfungen")
        endpoint.getAllImmunizations() { (immunizations, error) -> () in
                //impfungenPrac = immunizations
            if immunizations != nil {
                for practitioner in immunizations ?? [] {
                    var impfung = Impfung(id: practitioner?.id?.string ?? "no ID",
                                          patientId: practitioner?.telecom?[0].value?.string ?? "no patient",
                        name: practitioner?.name?[0].family?.string ?? "kein name", datum: practitioner?.birthDate?.nsDate,
                                          nebenwirkungen: practitioner?.address?[0].text?.string ?? "keine nebenwirkungen",
                                          reiseInfos: practitioner?.address?[0].postalCode?.string ?? "keine reiseinfos",
                                          impfstrategie: practitioner?.address?[0].district?.string ?? "keine Impfstrategie",
                                          teilimpfung: practitioner?.address?[0].country?.string)
                    if impfung.datum != nil {
                        impfung.datum = Calendar.current.date(byAdding: .year, value: 2000, to: impfung.datum!)
                    }
                    print(impfung.patientId)
                    
                    if impfung.datum != nil &&  impfung.datum! < Date()  && sharedProfil.profile.ID == impfung.patientId {
                        impfungen.append(impfung)
                    }
                }
            }
        }
    }
    
    var body: some View {
        List(impfungen) { impfung in
            NavigationLink(destination: DetailansichtMitDatumView(impfung: impfung)) {
                ImpfungRow(impfung: impfung)
            }
        }.onAppear(perform: loadImpfungen)
    }
}

struct ErledigtView_Previews: PreviewProvider {
    static var previews: some View {
        ErledigtView(impfungen: [])
    }
}
