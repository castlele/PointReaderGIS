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
}
