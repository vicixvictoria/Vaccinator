//
//  ImpfungRow.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 07.06.21.
//

import SwiftUI
import SMART

struct ImpfungRow: View {
    var impfung: Impfung
    
    func createDate() -> String {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let datetime = formatter.string(from: impfung.datum!)
        return datetime
    }
   
    var body: some View {
        HStack {
            Text(impfung.name)
            Spacer()
            if (impfung.datum != nil) {
                Text(createDate())
            }
        }
        
    }
}

struct ImpfungRow_Previews: PreviewProvider {
    static var previews: some View {
        ImpfungRow(impfung: Impfung.exmple)
    }
}

