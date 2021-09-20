//
//  InputViewModel.swift
//  PointReaderTests
//
//  Created by Nikita Semenov on 20.09.2021.
//

import XCTest
@testable import PointReader

class InputViewModelTests: XCTestCase {
	
	var vm: InputViewModel!
	
	override func setUp() {
		vm = InputViewModel()
	}
	
	override func tearDown() {
		vm = nil
	}
	
	func testFillingInCorrectCoordinates() throws {
		vm.dotCoordinates = ("123.5", "321")
		
		let expectedDot = Dot(x: 123.5, y: 321, color: "red")
		
		XCTAssertTrue(vm.dots[0] == expectedDot)
	}
	
	func testFillingInIncorrectCoordinates() throws {
		vm.dotCoordinates = ("", "")
		
		XCTAssertTrue(vm.dots.isEmpty)
	}
	
	func testFillingInMultipleCorrectCoordinates() throws {
		vm.dotCoordinates = ("123.5", "321")
		vm.dotCoordinates = ("", "")
		vm.dotCoordinates = ("2", "2")
		vm.dotCoordinates = ("4", "1")
		vm.dotCoordinates = ("5", "3")
		vm.dotCoordinates = ("asdf", "asdf")
		
		XCTAssertTrue(vm.dots.count == 4)
	}
	
	func testFillingInMultipleIncorrectCoordinates() throws {
		vm.dotCoordinates = ("", "")
		vm.dotCoordinates = ("", "")
		vm.dotCoordinates = ("", "")
		vm.dotCoordinates = ("", "")
		
		XCTAssertTrue(vm.dots.isEmpty)
	}
}
