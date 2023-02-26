//
//  ContentView.swift
//  MoveItMoveIt
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "box.truck")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("I like to move it, move it")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
