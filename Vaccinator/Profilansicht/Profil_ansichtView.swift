//
//  ProfilView.swift
//  Vaccinator
//
//  Created by Vici Zeillinger on 15.05.21.
//

import SwiftUI
import SMART

struct Profil_ansichtView: View {
    
    @EnvironmentObject var sharedProfil: SharedProfile
    
    @State private var showDetails = false
    struct Profile{
    let name: String
    let id = UUID()
    }
    let patientProvider = PatientEndpoint()
    @State var patient1 : Patient?
    @State var showPatient = false
    @State var patientReady = false
    @State var profile: [String] = []
    @State var profil_pass: [Profil_Pass]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    

    
    func loadPatient(){
        patientProvider.readPatientById(id: Int(sharedProfil.profile.ID) ?? 410) { (patient, error) -> () in
                            //print("HAAALLLOOO \(patient?.name)")
                            patient1 = patient
           // let bday = patient1?.birthDate?.nsDate
          //  let gender1 = patient1?.gender.string ?? "default value"
                            showPatient = true
                        }

    }
    
    func loadPatients() {
        profil_pass.removeAll()
             print("load Patienten")
             patientProvider.getAllPatient() { (patients, error) -> () in
                     //impfungenPrac = immunizations
                 if patients != nil {
                     for patient2 in patients ?? [] {
                        let profil1 = Profil_Pass(id: patient2?.id?.string ?? "no ID", name1: patient2?.name?[0].given?[0].string ?? "kein name", name2: patient2?.name?[0].family?.string ?? "kein Name", bday: patient2?.birthDate?.nsDate,
                                             rolle: patient2?.address?[0].city?.string ?? "keine Rolle", gender: patient2?.gender?.rawValue ?? "kein gender")
                        // impfungen.append(impfung)
                         //impfstoff.append(impfung.name)
                         let name = patient2?.name?[0].given?[0].string ?? "kein name"
                         profile.append(name)
                        profil_pass.append(profil1)
                        
                     }
                 }
             }
             patientReady = true
     }
    
    
    func createDate() -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           //formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy-HH-mm")
          // formatter.timeStyle = .short

        let datetime = formatter.string(from: patient1?.birthDate?.nsDate ?? Date())
           return datetime
       }


    
   
    var body: some View {
            NavigationView{
                VStack(alignment: .center, spacing: -20){
                
                    HStack(alignment: .top, spacing: 0){
                        
                    List{
                   //Section(header: Text("Profil")){
                    HStack(spacing:1){
                        Image(systemName: "person")
                            .font(.headline)
                        HStack{
                        Text(patient1?.name?[0].given?[0].string ?? "default value")
                        Text(patient1?.name?[0].family?.string ?? "default value")
                        }
                        .font(.system(size: 18.0, weight: .bold))
                            .foregroundColor(Color.blue)
                    }
                    HStack(spacing:1){
                        Image(systemName: "clock")
                        Text(createDate())
                    }
                    HStack(spacing:1){
                        Image(systemName: "creditcard")
                        Text(patient1?.address?[0].country?.string ?? "default value")
                       
                    }
                    HStack(spacing:1){
                        Image(systemName: "face.smiling")
                        Text(patient1?.gender?.rawValue ?? "default value")
                        }
                        
                    
                    }
                   // Spacer()
                //.environment(\.defaultMinListRowHeight, 2)
                    .frame(minWidth: 0, maxWidth: 320, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    //.offset(x:0, y:10)
                   
                        
                        List{
                            Image(systemName: "person.circle")
                                .resizable()
                                .foregroundColor(Color.blue)
                                .frame(width: 80.0, height:80.0,alignment: .top)
                                .background(Color.clear)
                                
                        }
                        //Spacer()
                        .frame(minWidth: 0, maxWidth: 150, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        
                       
                
                    }
                    //.cornerRadius(10)
                    Spacer()
                        .frame(height:1)
                    .overlay(RoundedRectangle(cornerRadius:15).stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                      )
                        .padding([.top, .leading, .trailing])
                        .background(Color.white)
                    
                    
                    
        
                List{
                    Section(header: Text("Profil wechseln")){
                     
                    
                        ForEach(profil_pass){ profil_pass in
                            
                            HStack(spacing:1){
                                Image(systemName: "person")
                                Button(profil_pass.name1){
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                }
                        }
                
                }
                }

                }
                .background(Color(.sRGB, red: 228/255, green: 230/255, blue: 235/255, opacity: 0.8).opacity(0.8))
                 .cornerRadius(11)
                 .overlay(
                     RoundedRectangle(cornerRadius: 10.0)
                         .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                         .shadow(color: .black, radius: 10.0)
                )
                .padding(.top, -100)
                /*
                .cornerRadius(11)
                .overlay(
                   RoundedRectangle(cornerRadius:15).stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1)
                  )
                .padding(.top, -100)
               // Spacer()*/
                
               
            }
            .onAppear(perform: loadPatient)
            .onAppear(perform: loadPatients)
        //}
    }
    
    
    }
   

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        Profil_ansichtView(profile: [], profil_pass: [])
    }
}

