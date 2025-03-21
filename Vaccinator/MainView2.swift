//
//  MainView2.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 22.06.21.
//

import SwiftUI

struct MainView2: View {
    
    var profile = SharedProfile()
   
    init(sharedProfile: SharedProfile) {
        UINavigationBar.appearance().barTintColor = UIColor(Color(.sRGB, red: -10/255, green: 4/255, blue: 53/255, opacity: 1).opacity(1))
        UITabBar.appearance().barTintColor = UIColor(Color(.sRGB, red: 204/255, green: 213/255, blue: 235/255, opacity: 1))
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        print(profile.GetValue().family)
        self.profile = sharedProfile
        }
    
    
    
    var body: some View {
      
            TabView{
                NavigationView{
                    ImpfungenView()
                        .navigationBarTitle("Impfungen")
                        .navigationBarTitleDisplayMode(.inline)
                       
                }
                .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                .accentColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
               // .padding()
                .tabItem {
                    Image(systemName: "list.bullet")
                                        Text("Impfpass")
                }
                .tag(1)
                
                NavigationView{
                    Neu_anlegenView()
                        .navigationBarTitle(Text("Neu erstellen"), displayMode: .inline)
                }
                .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                .accentColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
               // .padding()
                .tabItem {
                    Image(systemName: "plus.circle")
                                        Text("new")
                }
                .tag(2)
                
                NavigationView{
                    Profil_ansichtView(profile: [], profil_pass: [])
                        .navigationBarTitle(Text("Profil"), displayMode: .inline)
                }
                .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                .accentColor(Color(.sRGB, red: 27/255, green: 37/255, blue: 80/255, opacity: 1))
                //.padding()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                                        Text("Profil")
                }
                .tag(3)
                          
            }
            .environmentObject(profile)
           
        }
        
    }



struct MainView2_Previews: PreviewProvider {
    static var previews: some View {
        MainView2(sharedProfile: SharedProfile())
    }
}
