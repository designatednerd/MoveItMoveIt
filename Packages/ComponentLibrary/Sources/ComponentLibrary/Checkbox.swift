//
//  Checkbox.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI

public struct Checkbox: View {
    var isChecked: Binding<Bool>
    
    public init(isChecked: Binding<Bool>) {
        self.isChecked = isChecked
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(.clear)
                .frame(width: 40, height: 40)
                .roundedBorder(BorderInfo(color: .purple500, width: 3), radius: 5)
            if self.isChecked.wrappedValue {
                AssetCatalogImage.checkmark.image
                    .padding(.bottom, 5)
            }
        }
    }
}

public struct CheckboxInput: View {
    let content: any StringProtocol
    @State var isChecked: Bool
    
    public init(content: any StringProtocol,
         isChecked: Bool) {
        self.content = content
        self._isChecked = State(initialValue: isChecked)
    }
    
    public var body: some View {
        Button {
            self.isChecked.toggle()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Checkbox(isChecked: self.$isChecked)
                BodyText(self.content)
                    .foregroundColor(.gray1000)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#if DEBUG
struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            HStack {
                Checkbox(isChecked: .constant(false))
                Checkbox(isChecked: .constant(true))
            }
            CheckboxInput(content: "See how I work", isChecked: false)
            
            CheckboxInput(content: "See how I work with some very long text which wraps all over the place", isChecked: false)
                   
        }
        .padding(20)
    }
}
#endif
