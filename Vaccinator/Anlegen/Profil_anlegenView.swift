//
//  Profil_anlegenView.swift
//  Vaccinator
//
//  Created by Vici Zeillinger on 30.05.21.
//

import SwiftUI
import Foundation
import SMART



struct Profil_anlegenView: View {
    @State var name: String = ""
    @State var bday: String = ""
    @State var svnr: String = ""
    @State private var selection: String? = nil
    
    //Variables for Patient object
    @State var firstName :String = ""
    @State var lastName :String = ""
    @State var gender :String = ""
    @State var birthDay = Date()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    //declaration of variables for the picker
    var rolle = ["Admin", "Kind", "Eltern", "Angehöriger/e"]
    @State private var selectedRolle = "Admin"
    
    var genderP = ["male", "female", "other", "unknown"]
    @State private var selectedGender = "unknown"
    
    
    @State private var searchTerm: String = ""
    //Searchbar Variablen deklarieren
    var filteredRolle: [String] {
        rolle.filter {
            searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    var filteredGender: [String] {
        genderP.filter {
            searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    
    //Provider for exchanging the patient object
    let provider = PatientEndpoint()
    
    //View body starts
    var body: some View {
        
        VStack{
            /*NavigationLink(destination: Neu_anlegenView(), tag: "Second", selection: $selection) { EmptyView() }*/
            
            
            Form{
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    TextField(" Vorname", text: $firstName)
                        .frame(height: 50)
                }
                
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    TextField(" Nachname", text: $lastName)
                        .frame(height: 50)
                }
                
                
                HStack{
                    Image(systemName: "face.smiling")
                        .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    Picker("Geschlecht", selection: $selectedGender) {
                        SearchBar(text: $searchTerm, placeholder: "Suchen")
                        ForEach(filteredGender, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(height: 50)
                }
                
                
                HStack{
                    Image(systemName: "person.3")
                        .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    Picker("Rolle", selection: $selectedRolle) {
                        SearchBar(text: $searchTerm, placeholder: "Suchen")
                        ForEach(filteredRolle, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(height: 50)
                }
                
                
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    //TextField("Geburtstag", $bday)
                    DatePicker("Geburtstag", selection: $birthDay, displayedComponents: .date)
                        .frame(height: 50)
                }
                HStack{
                    Image(systemName: "creditcard")
                        .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    TextField("SVNR", text: $svnr)
                        .frame(height: 50)
                }
                
            }
            .listStyle(InsetGroupedListStyle()) // this has been renamed in iOS 14.*, as mentioned by @Elijah Yap
            .environment(\.horizontalSizeClass, .regular)
            .offset(x:0, y:10)
            
            
            
            
            Button(action: {
                saveData()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack{
                    Image(systemName: "checkmark")
                    Text("erstellen ")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1).opacity(1))
                .cornerRadius(40)
                .offset(x:0, y:-15)
                
            }
            
            
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(11)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                .shadow(color: .black, radius: 10.0)
        )
        .navigationBarTitle("neues Profil anlegen")
        
    }
    
    // fucntion for saving the patients Data
    
    
    func saveData(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd"
        bday = dateFormatter.string(from: birthDay)
        
        gender = selectedGender
        
        let humanName = HumanName()
        humanName.given = [FHIRString(firstName)]
        humanName.family = FHIRString(lastName)
        
        let addresse = Address()
        addresse.city = FHIRString(selectedRolle)
        addresse.country = FHIRString(svnr)
        
        let patient = Patient()
        patient.name = [humanName]  //name von Patient
        patient.gender = AdministrativeGender(rawValue: gender) //geschlecht von Patient
        patient.birthDate = FHIRDate(string: bday) //geburtstag von Patient
        patient.address = [addresse] //addresse.city = Rolle, adresse.country = svnr
        
        
        
        provider.createPatient(patient: patient)
        
        print("The name is: \(firstName)")
        print("The name is: \(lastName)")
        print("The gender is: \(gender)")
        print("The role is: \(selectedRolle)")
        print("The bday is: \(bday)")
        print("The svnr is: \(svnr)")
        print("The patient is \(patient)")
    }
    
}



struct Profil_anlegenView_Previews: PreviewProvider {
    static var previews: some View {
        Profil_anlegenView()
    }
}
