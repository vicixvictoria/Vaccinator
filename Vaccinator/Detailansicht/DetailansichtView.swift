//
//  DetailansichtView.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 10.06.21.
//

import SwiftUI
import SMART

struct DetailansichtView: View {
    let impfung : Impfung
    @State private var revealDetailsNebenwirkungen = true
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
        ScrollView {
        VStack{
            
            Text(impfung.name).font(.largeTitle).padding()
            
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
            NavigationLink(destination: ContentView(), tag: 1, selection: $selection) {
                Button(action: {
                    print("login tapped")
                    self.selection = 1
                }) {
                    HStack {
                        //Spacer()
                        Image(systemName: "pencil")
                        Text("Bearbeiten").foregroundColor(Color.white).bold()
                        //Spacer()
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                .cornerRadius(40)
                .offset(x:0, y:-15)
            }.padding(.top, 50)
        
        }.navigationTitle(impfung.name)
        .navigationBarTitleDisplayMode(.inline)
        }
        }
    }
           
}

struct DetailansichtView_Previews: PreviewProvider {
    static var previews: some View {
        DetailansichtView(impfung: Impfung.exmple)
    }
}
