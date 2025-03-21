//
//  DetailansichtMitDatumView.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 10.06.21.
//

import SwiftUI

struct DetailansichtMitDatumView: View {
    let impfung : Impfung
    @State private var revealDetailsTermin = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var revealDetailsNebenwirkungen = true
    func createDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        //formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy-HH-mm")
        formatter.timeStyle = .short

        let datetime = formatter.string(from: impfung.datum!)
        return datetime
    }
    
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ScrollView {
        VStack{
            
            Text(impfung.name).font(.largeTitle).padding()
            
            DisclosureGroup(isExpanded: $revealDetailsTermin,
                content: {
                    VStack {
                        Text(createDate())
                        if impfung.teilimpfung != nil {
                            Text(impfung.teilimpfung ?? "")
                        }
                    }
                },
                label: {
                    Image(systemName: "calendar")
                    Text("Impftermin")
                        .font(.title2)
                        
                }
            ).padding()
            
            
            DisclosureGroup(isExpanded: $revealDetailsNebenwirkungen,
                content: {
                    Text(impfung.nebenwirkungen)
                        .font(.body)
                        .fontWeight(.light)
                },
                label: {
                    Image(systemName: "bandage")
                    Text("Nebenwirkungen")
                        .font(.title2)
                        
                }
            ).padding()
            
            DisclosureGroup(
                content: {
                    Text(impfung.reiseInfos)
                        .font(.body)
                        .fontWeight(.light)
                    
                },
                label: {
                    Image(systemName: "airplane")
                    Text("Informationen für Reisende")
                        .font(.title2)
                        
                }
            ).padding()
            
            DisclosureGroup(
                content: {
                    Text(impfung.impfstrategie)
                        .font(.body)
                        .fontWeight(.light)
                    
                },
                label: {
                    Image(systemName: "arrowshape.bounce.right")
                    Text("Informationen über Impfstrategie")
                        .font(.title2)
                        
                }
            ).padding()
        
            
            
            Spacer()
                
            
            Button(action: {
                delete()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    //Spacer()
                    Image(systemName: "trash")
                    Text("Löschen").foregroundColor(Color.white).bold()
                    //Spacer()
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color(.sRGB, red: 191/255, green: 0/255, blue: 0/255, opacity: 1))
            .cornerRadius(40)
            .offset(x:0, y:-15)
       
            
            
        }.navigationTitle(impfung.name)
        .navigationBarTitleDisplayMode(.inline)
        //.navigationBarBackButtonHidden(true)
       // .navigationBarHidden(true)
        }
        }
    }
    
    func delete() {
        let endpoint = ImmunizationEndpoint()
        endpoint.deleteImmunization(id: impfung.id)
    }
}



struct DetailansichtMitDatumView_Previews: PreviewProvider {
    static var previews: some View {
        DetailansichtMitDatumView(impfung: Impfung.exmple)
    }
}
