//
//  NavigationButtons.swift
//  
//
//  Created by Ellen Shapiro on 2/27/23.
//

import SwiftUI

public struct BackButton: View {
    let action: () -> Void
    
    public init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: self.action) {
            ZStack {
                Circle()
                    .fill(Color.gray200)
                    .frame(width: 44, height: 44)
                Image(systemName: "chevron.backward")
                    .renderingMode(.template)
                    .foregroundColor(.purple500)
            }
        }
        
    }
}


public struct CloseButton: View {
    let action: () -> Void
    
    public init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: self.action) {
            ZStack {
                Circle()
                    .fill(Color.gray200)
                    .frame(width: 44, height: 44)
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .foregroundColor(.purple500)
            }
        }
        
    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            BackButton({})
            CloseButton({})
        }
    }
}
#endif
