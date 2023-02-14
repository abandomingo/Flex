//
//  ContentView.swift
//  Project332
//
//  Created by Aban Domingo on 2/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            VStack {
                Image("muscle")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(100)
                Text("Flex")
                    .bold()
                    .font(.system(size:50))
            }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
