//
//  ContentView.swift
//  MoveItMoveIt
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI
import ComponentLibrary

enum Views {
    case loginView
}

struct ContentView: View {
    @State var path =  [Views]()
    
    var body: some View {
        NavigationStack(path: self.$path) {
            VStack {
                Image(systemName: "box.truck")
                    .imageScale(.large)
                    .font(.system(size: 100))
                    .foregroundColor(.purple500)
                Title2Text("I like to move it, move it")
                PrimaryButton(title: "Show me the app") {
                    self.path.append(.loginView)
                }
            }
            .navigationDestination(for: Views.self) { view in
                switch view {
                case .loginView:
                    LoginView()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
