//
//  Neu_anlegenView.swift
//  Vaccinator
//
//  Created by Vici Zeillinger on 06.06.21.
//

import SwiftUI

struct Neu_anlegenView: View {
    @State private var selection: String? = nil
    
    var body: some View {
        ZStack{
            //Color(.sRGB, red: 0/255, green: 33/255, blue: //245/255, opacity: 0.58)
            //Image("verlauf1")
               // .edgesIgnoringSafeArea(.all)
            VStack {
                NavigationLink(destination: Profil_anlegenView(), tag: "Second", selection: $selection) { EmptyView() }
                
                NavigationLink(destination: Impfung_erstellenView(impfungen: [], profil_pass: [], impfpass: [], impfstoff: []), tag: "Third", selection: $selection) { EmptyView() }
                
                
                //Text
                Label("Neuen Impfpass für Angehörige erstellen", systemImage: "heart.text.square")
                    .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    .padding()
                    .offset(x:0, y:30)
                Label("oder", systemImage: "")
                    .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    .offset(x:0, y:20)
                Label("Neue Impfung in den Impfpass eintragen", systemImage: "cross.circle")
                    .foregroundColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                    .padding()
                    .offset(x:0, y:5)
                
                
                //Buttons with Navigation
                Button(action: {
                    self.selection = "Second"
                }) {
                
                    HStack{
                    Image(systemName: "heart.text.square")
                    Text("Imfpass anlegen ")
                    
                    }
                    .padding()
                        .foregroundColor(.white)
                    .background(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1).opacity(1))
                        .cornerRadius(40)
                  //  .offset(x:0, y:-50)
                    }
                
                
                Button(action: {
                    self.selection = "Third"
                }) {
                
                    HStack{
                    Image(systemName: "cross.circle")
                    Text("Impfung erstellen  ")
                    
                    }
                    .padding()
                        .foregroundColor(.white)
                    .background(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1).opacity(1))
                        .cornerRadius(40)
                    //.offset(x:0, y:-50)
                    }
                
            
                        }
            .background(Color(.sRGB, red: 228/255, green: 230/255, blue: 235/255, opacity: 0.8).opacity(0.8))
             .cornerRadius(11)
             .overlay(
                 RoundedRectangle(cornerRadius: 10.0)
                     .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                     .shadow(color: .black, radius: 10.0)
             )
        
}
        
    }
    
}
struct Neu_anlegenView_Previews: PreviewProvider {
    static var previews: some View {
        Neu_anlegenView()
    }
}
