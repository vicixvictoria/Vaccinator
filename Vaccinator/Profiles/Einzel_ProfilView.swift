//
//  Einzel_ProfilView.swift
//  Vaccinator
//
//  Created by Mursal Schwab on 22.06.21.
//

import SwiftUI
import SMART

struct Einzel_ProfilView: View {
    
    var patient: Profil

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .font(.largeTitle)

            VStack(alignment: .leading) {
                Text(patient.given)
                    .font(.title)
                Text(patient.rolle)
                    .font(.subheadline)
            }

            Spacer()
        }
    }
}

struct Einzel_ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        Einzel_ProfilView(patient: Profil(ID:"", given: "", family: "", bday: Date(), rolle: ""))
    }
}
