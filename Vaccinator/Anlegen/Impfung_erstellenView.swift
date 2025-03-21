//
//  Impfung_erstellenView.swift
//  Vaccinator
//
//  Created by Vici Zeillinger on 07.06.21.
//

import SwiftUI
//import Foundation
//import FMCore
import SMART

struct Impfung_erstellenView: View {
   
    //Variablen deklarieren
    @State var date1: String = ""
    @State var date: Date = Date()
    @State var impfstoff1: String = ""
    @State private var selection: String? = nil
    @State var impfungen : [Impfung]
    @State var impfungReady = false
    @State var patientReady = false
    @State var profil_pass: [Profil_Pass]
    
    @State var nebenwirkungen : String?
    @State var reisebestimmungen: String?
    @State var impfstrategie: String?
    @State var id_profil: String?

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var impfpass: [String]
    @State private var selectedImpfpass = "Vici"
    
    @State var impfstoff : [String]
    @State private var selectedImpfstoff = "FSME"
    
    var teilimpfung = ["erst-Stich", "1. Teilimpfung", "2. Teilimpfung","3. Teilimpfung", "Auffrischung"]
    @State private var selectedTeilimpfung = "erst-Stich"
    
    @State private var searchTerm: String = ""
    
    
    
    
    func loadImpfungen() {
        if impfungReady == false{
           // impfstoff.removeAll()
            print("load Impfungen")
            provider.getAllImmunizations() { (immunizations, error) -> () in
                    //impfungenPrac = immunizations
                if immunizations != nil {
                    for practitioner in immunizations ?? [] {
                        if practitioner?.birthDate == nil {
                        let impfung = Impfung(id: practitioner?.id?.string ?? "no ID",
                                              patientId: "",
                                              name: practitioner?.name?[0].family?.string ?? "kein name", datum: Date(),
                                              nebenwirkungen: practitioner?.address?[0].text?.string ?? "keine nebenwirkungen",
                                              reiseInfos: practitioner?.address?[0].line?[0].string ?? "keine reiseinfos", impfstrategie: practitioner?.address?[0].district?.string ?? "keine Impfstrategie",
                                              teilimpfung: nil)
                       // impfungen.append(impfung)
                        //impfstoff.append(impfung.name)
                        let name = practitioner?.name?[0].family?.string ?? "kein name"
                        impfstoff.append(name)
                        impfungen.append(impfung)
                    }
                    }
                }
            }
            impfungReady=true
        }
        }
    
    
    
   func loadPatients() {
        if patientReady == false {
            print("load Patienten")
            patientProvider.getAllPatient() { (patients, error) -> () in
                    //impfungenPrac = immunizations
                if patients != nil {
                    for patient in patients ?? [] {
                        let profil1 = Profil_Pass(id: patient?.id?.string ?? "no ID", name1: patient?.name?[0].given?[0].string ?? "kein name", name2: patient?.name?[0].family?.string ?? "kein Name", bday: patient?.birthDate?.nsDate,
                                             rolle: patient?.address?[0].city?.string ?? "keine Rolle", gender: patient?.gender?.rawValue ?? "kein gender")
                        let name = patient?.name?[0].given?[0].string ?? "kein name"
                        impfpass.append(name)
                        profil_pass.append(profil1)
                    }
                }
            }
            patientReady = true
        }
    }
    
    


    
    //filter Variablen deklarieren
    var filteredImpfpass: [String] {
            impfpass.filter {
                searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
            }
        }
    
    var filteredImpfstoff: [String] {
            impfstoff.filter {
                searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
            }
        }
    
    var filteredTeilimpfung: [String] {
            teilimpfung.filter {
                searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
            }
        }
    
    
    //Endpoint dekleration
    let provider = ImmunizationEndpoint()
    let patientProvider = PatientEndpoint()
    
    
    var body: some View {
       
        VStack{
            NavigationLink(destination: Neu_anlegenView(), tag: "Second", selection: $selection) { EmptyView() }
            
        Form{
            HStack{
               Image(systemName: "person")
                .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                Picker("Impfpass wählen", selection: $selectedImpfpass) {
                    SearchBar(text: $searchTerm, placeholder: "Suchen")
                                ForEach(filteredImpfpass, id: \.self) {
                                    Text($0)
                                }
                            }
                .frame(height: 50)
            }
            
            HStack{
                Image(systemName: "bandage")
                    .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                Picker("Impfstoff wählen", selection: $selectedImpfstoff) {
                    SearchBar(text: $searchTerm, placeholder: "Suchen")
                                ForEach(filteredImpfstoff, id: \.self) {
                                    Text($0)
                                }
                            }
                .frame(height: 50)
            }
        
            HStack{
                Image(systemName: "arrowshape.bounce.right")
                    .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                Picker("Impffortschritt", selection: $selectedTeilimpfung){
                    SearchBar(text: $searchTerm, placeholder: "Suchen")
                            ForEach(filteredTeilimpfung, id: \.self) {
                                    Text($0)
                                }
                            }
                    .frame(height: 50)
            }
            
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                //TextField("Geburtstag", $bday)
                DatePicker("Datum", selection: $date, displayedComponents: .date)
                    .frame(height: 50)
            }
        
        }
        .listStyle(InsetGroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .offset(x:0, y:10)
            
        
            
            Button(action: {
                saveData_Impfung()
                self.presentationMode.wrappedValue.dismiss()
            }) {
            HStack{
            Image(systemName: "checkmark")
            Text("erstellen ")
            
            }
            .padding()
                .foregroundColor(.white)
            .background(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
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
        .onAppear(perform: loadImpfungen)
        .onAppear(perform: loadPatients)
    
    }
    
    //Impfung in Server speichern
    func saveData_Impfung(){
        
        impfstoff1=selectedImpfstoff
        
        for impf in impfungen {
            if impf.name == impfstoff1{
                print(impf.name)
                nebenwirkungen = impf.nebenwirkungen
                reisebestimmungen = impf.reiseInfos
                impfstrategie = impf.impfstrategie
            }
        }
        
        for prof in profil_pass{
            if prof.name1 == selectedImpfpass {
                id_profil = prof.id
            }
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd"
        date1 = dateFormatter.string(from: date)
        
        
        let humanName = HumanName()
               humanName.family = FHIRString(impfstoff1)
        humanName.given = [FHIRString("")]
       
        let adresse = Address()
        adresse.city = FHIRString(selectedImpfpass)
        adresse.country = FHIRString(selectedTeilimpfung)
        adresse.text = FHIRString(nebenwirkungen ?? "nicht vorhanden")
        adresse.postalCode = FHIRString(reisebestimmungen ?? "nicht vorhanden")
        adresse.district = FHIRString(impfstrategie ?? "nicht vorhanden")
        
        let patientLink = ContactPoint()
        patientLink.value = FHIRString(id_profil ?? "nicht vorhanden")
        
     let prac = Practitioner()
        prac.name = [humanName] //Impfstoff
        prac.birthDate = FHIRDate(string: date1)  //Imfpdatum
        prac.address = [adresse]  //adresse_city: Person, //adresse_country: teilimpfung
        prac.telecom = [patientLink]
        
        
        provider.createImmunization(impfung: prac)
        createNotification(date: date)
        
        print("The name is: \(selectedImpfpass)")
        print("The impfstoff is: \(selectedImpfstoff)")
        print("The date is: \(date)")
        print("The teilimpfung is: \(selectedTeilimpfung)")
    }
    
    func createNotification(date: Date) {
            var dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: date)
            dateComponent.hour = 9
            dateComponent.minute = 0
            
            let content = UNMutableNotificationContent()
            content.title = "Impftermin"
            content.subtitle = "Sie haben heute einen Termin für eine \(impfstoff1) Impfung"
            content.sound = UNNotificationSound.default

            // show this notification five seconds from now
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }


    

}




struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator

        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}


struct Impfung_erstellenView_Previews: PreviewProvider {
    static var previews: some View {
        Impfung_erstellenView(impfungen: [], profil_pass: [], impfpass: [], impfstoff: [])
    }
}
