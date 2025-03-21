//
//  ImpfungenView.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 15.05.21.
//

import SwiftUI
import SMART

struct ImpfungenView: View {
    @State private var selectedTab: Int = 0
    
    let tabs: [Tab] = [
            .init(icon: Image(systemName: "calendar"), title: "Geplant"),
            .init(icon: Image(systemName: "heart"), title: "Empfohlen"),
            .init(icon: Image(systemName: "archivebox"), title: "Erledigt")
        ]
    
    init() {
            UINavigationBar.appearance().barTintColor = UIColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().isTranslucent = false
        }
    
    var body: some View {
        //NavigationView {
                    GeometryReader { geo in
                        VStack(spacing: 0) {
                            // Tabs
                            Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)

                            // Views
                            TabView(selection: $selectedTab,
                                    content: {
                                        GeplantView(impfungen: []).tag(0)
                                        EmpfohlenView(impfungen: [])
                                            .tag(1)
                                        ErledigtView(impfungen: [])
                                            .tag(2)
                                    })
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        }
                        /*.navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Impfungen")
                        //.ignoresSafeArea()
                    }*/
                }
    }
}

struct ImpfungenView_Previews: PreviewProvider {
    static var previews: some View {
        ImpfungenView()
    }
}
