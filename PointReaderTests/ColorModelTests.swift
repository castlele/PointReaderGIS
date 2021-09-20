//
//  ColorModelTests.swift
//  ColorModelTests
//
//  Created by Nikita Semenov on 19.09.2021.
//

import XCTest
@testable import PointReader

class ColorModelTests: XCTestCase {
	
	var colorModel: ColorModel!

	override func tearDown() {
		colorModel = nil
	}
	
	func testColorModelInitWithinColorsKitCount() throws {
		colorModel = ColorModel(colorIndex: 0)
		
		XCTAssertEqual(colorModel.color, "red")
	}
	
	func testColorModelInitOutsideColorsKitCount() throws {
		colorModel = ColorModel(colorIndex: 12)
		
		XCTAssertEqual(colorModel.color, "brown")
	}
}
