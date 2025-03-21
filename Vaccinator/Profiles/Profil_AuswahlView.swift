//
//  Profil_AuswahlView.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 22.06.21.
//

import SwiftUI
import SMART


struct Profil_AuswahlView: View {
    
    var sharedProfile = SharedProfile()
    var patientProvider = PatientEndpoint()
    // @StateObject var sharedProfile: SharedProfile = SharedProfile()
    @State var profiles : [Profil]
    @State var profile : Profil
    @State var date1: String = ""
    @State var date: Date = Date()
    @State var patientReady = false
    
    
    func loadPatients() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd"
        date1 = dateFormatter.string(from: date)
        
        profiles.removeAll()
        patientProvider.getAllPatient { (patients, error) -> () in
            
            if patients != nil {
                for patient in patients ?? [] {
                    
                    let patient1 = Profil(ID: patient?.id?.string ?? "keine ID", given: patient?.name?[0].given?[0].string ?? "kein given", family: patient?.name?[0].family?.string ?? "kein family", bday: Date(),
                                          rolle: patient?.address?[0].city?.string ?? "keine rolle")
                                      
                    print(profile.given)
                    
                    profiles.append(patient1)
                }
            }
            
        }
            // patientReady = true
        
    }
    
    func saveObservable(patient: Profil){
        sharedProfile.Update(input: patient)
        sharedProfile.profile = patient
    }
    
    
    var body: some View {        
        VStack{
        Color.init(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1)
            .ignoresSafeArea()
            // Ignore just for the color
               .overlay(
            NavigationView{
               List {
                Text("Willkommen! \nBitte wählen Sie einen Impfpass aus!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .padding(8)
                    ForEach(profiles) { profiles in
                            NavigationLink(destination: MainView2(sharedProfile: sharedProfile)) {
                               
                                    // Patientenitems
                                        HStack {
                                            Image(systemName: "person.crop.circle")
                                                .font(.largeTitle)

                                            VStack(alignment: .leading) {
                                                Text(profiles.given + " " + profiles.family)
                                                    .font(.title)
                                                Text(profiles.rolle)
                                                    .font(.subheadline)
                                            }

                                            // Spacer()
                                        }
                          
                                    }
                            .simultaneousGesture(TapGesture().onEnded{
                                print("Got Tap")
                                self.sharedProfile.profile = profiles
                                print("Profile: \(sharedProfile.profile.family)")
                            })
                             }
                        .padding(5)
                        .background(Color.init(.sRGB, red: 229/255, green: 236/255, blue: 255/255, opacity: 1.0))
                        .cornerRadius(20.0)
                }
                .listStyle(GroupedListStyle())
                }
                .environmentObject(sharedProfile)
                .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    )
    }
        .onAppear(perform: loadPatients)
    }
    
}

// var shared = SharedProfile()

struct Profil_AuswahlView_Previews: PreviewProvider {
    static var previews: some View {
        // TODO Object übergeben
        Profil_AuswahlView(profiles: [], profile: Profil(ID:"", given: "", family: "", bday: Date(), rolle: ""))
            // .environmentObject(shared)
    }
}
