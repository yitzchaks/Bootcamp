//
//  State.swift
//  Shop
//
//  Created by Yitzchak Schechter on 05/07/2023.
//

import SwiftUI

struct StateView: View {
    @Binding var state: StateModel
    
    var body: some View {
        VStack {
            switch self.state {
            case .load:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
                    .padding()
            case .success, .idle:
                EmptyView()
            case .error:
                Text("Error!")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
        }
    }
}

//struct State_Previews: PreviewProvider {
//    static var previews: some View {
//        State()
//    }
//}
