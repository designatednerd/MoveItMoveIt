//
//  AssetCatalogColors.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import Foundation
import SwiftUI

enum AssetCatalogColor: String, CaseIterable, Identifiable {
    // Grays
    case gray0 = "Gray 0"
    case gray50 = "Gray 50"
    case gray100 = "Gray 100"
    case gray200 = "Gray 200"
    case gray300 = "Gray 300"
    case gray400 = "Gray 400"
    case gray500 = "Gray 500"
    case gray600 = "Gray 600"
    case gray700 = "Gray 700"
    case gray800 = "Gray 800"
    case gray900 = "Gray 900"
    case gray1000 = "Gray 1000"

    // Purples
    case purple50 = "Purple 50"
    case purple100 = "Purple 100"
    case purple200 = "Purple 200"
    case purple300 = "Purple 300"
    case purple400 = "Purple 400"
    case purple500 = "Purple 500"
    case purple600 = "Purple 600"
    case purple700 = "Purple 700"
    case purple800 = "Purple 800"
    case purple900 = "Purple 900"

    // Yellows
    case yellow50 = "Yellow 50"
    case yellow100 = "Yellow 100"
    case yellow200 = "Yellow 200"
    case yellow300 = "Yellow 300"
    case yellow400 = "Yellow 400"
    case yellow500 = "Yellow 500"
    case yellow600 = "Yellow 600"
    case yellow700 = "Yellow 700"
    case yellow800 = "Yellow 800"
    case yellow900 = "Yellow 900"
    
    // Reds
    case red50 = "Red 50"
    case red100 = "Red 100"
    case red200 = "Red 200"
    case red300 = "Red 300"
    case red400 = "Red 400"
    case red500 = "Red 500"
    case red600 = "Red 600"
    case red700 = "Red 700"
    case red800 = "Red 800"
    case red900 = "Red 900"
    
    var color: Color {
        Color(self.rawValue,
              bundle: .module)
    }
    
    var id: String {
        self.rawValue
    }
}


public extension Color {
    // Grays
    static let gray0 = AssetCatalogColor.gray0.color
    static let gray50 = AssetCatalogColor.gray50.color
    static let gray100 = AssetCatalogColor.gray100.color
    static let gray200 = AssetCatalogColor.gray200.color
    static let gray300 = AssetCatalogColor.gray300.color
    static let gray400 = AssetCatalogColor.gray400.color
    static let gray500 = AssetCatalogColor.gray500.color
    static let gray600 = AssetCatalogColor.gray600.color
    static let gray700 = AssetCatalogColor.gray700.color
    static let gray800 = AssetCatalogColor.gray800.color
    static let gray900 = AssetCatalogColor.gray900.color
    static let gray1000 = AssetCatalogColor.gray1000.color

    // Purples
    static let purple50 = AssetCatalogColor.purple50.color
    static let purple100 = AssetCatalogColor.purple100.color
    static let purple200 = AssetCatalogColor.purple200.color
    static let purple300 = AssetCatalogColor.purple300.color
    static let purple400 = AssetCatalogColor.purple400.color
    static let purple500 = AssetCatalogColor.purple500.color
    static let purple600 = AssetCatalogColor.purple600.color
    static let purple700 = AssetCatalogColor.purple700.color
    static let purple800 = AssetCatalogColor.purple800.color
    static let purple900 = AssetCatalogColor.purple900.color

    // Yellows
    static let yellow50 = AssetCatalogColor.yellow50.color
    static let yellow100 = AssetCatalogColor.yellow100.color
    static let yellow200 = AssetCatalogColor.yellow200.color
    static let yellow300 = AssetCatalogColor.yellow300.color
    static let yellow400 = AssetCatalogColor.yellow400.color
    static let yellow500 = AssetCatalogColor.yellow500.color
    static let yellow600 = AssetCatalogColor.yellow600.color
    static let yellow700 = AssetCatalogColor.yellow700.color
    static let yellow800 = AssetCatalogColor.yellow800.color
    static let yellow900 = AssetCatalogColor.yellow900.color
    
    // Reds
    static let red50 = AssetCatalogColor.red50.color
    static let red100 = AssetCatalogColor.red100.color
    static let red200 = AssetCatalogColor.red200.color
    static let red300 = AssetCatalogColor.red300.color
    static let red400 = AssetCatalogColor.red400.color
    static let red500 = AssetCatalogColor.red500.color
    static let red600 = AssetCatalogColor.red600.color
    static let red700 = AssetCatalogColor.red700.color
    static let red800 = AssetCatalogColor.red800.color
    static let red900 = AssetCatalogColor.red900.color
}

#if DEBUG
struct AssetColor_Previews: PreviewProvider {
    static let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
    ]
    
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: self.columns, spacing: 10) {
                ForEach(AssetCatalogColor.allCases) { color in
                    VStack(spacing: 0) {
                        Text(color.rawValue)
                        Rectangle()
                            .fill(color.color)
                    }
                    .frame(width: 100, height: 100)
                    .border(.black)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
#endif
