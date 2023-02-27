//
//  AssetCatalogImages.swift
//  
//
//  Created by Ellen Shapiro on 2/26/23.
//

import Foundation
import SwiftUI

enum AssetCatalogImage: String, CaseIterable, Identifiable {
    case checkmark
    
    var image: Image {
        Image(self.rawValue,
              bundle: .module)
    }
    
    var id: String {
        self.rawValue
    }
}

#if DEBUG
struct AssetCatalogImage_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack() {
                ForEach(AssetCatalogImage.allCases) { image in
                    Text(image.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                        .background(Color.gray400)

                    image.image
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#endif
