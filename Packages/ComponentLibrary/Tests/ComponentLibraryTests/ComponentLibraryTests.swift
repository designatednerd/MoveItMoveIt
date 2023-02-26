import XCTest
import SwiftUI
@testable import ComponentLibrary

final class ComponentLibraryTests: XCTestCase {
    
    func testColorsAllPullValidValueFromAssetCatalog() {
        let invalidColor = Color("Definitely not legit", bundle: .module)
        XCTAssertNil(invalidColor.cgColor, "Not legit color should not have a CGColor")
        
        for color in AssetCatalogColor.allCases {
            XCTAssertNil(color.color.cgColor,
                         "Color \(color.rawValue) has a nil CGColor, indicating it was not pulled out of the asset catalog!")
        }
    }
}
