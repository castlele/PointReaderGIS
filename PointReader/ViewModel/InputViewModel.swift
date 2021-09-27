//
//  InputViewModel.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

extension CGFloat {
	init?(_ strNum: String) {
		guard let doubleNum = Double(strNum) else {
			return nil
		}
		self.init(doubleNum)
	}
}

// MARK: - InputViewModel
final class InputViewModel: ObservableObject {
	
	@Published var objects: [GeometryObject] = []
	@Published var isDotAddingMode = false
	@Published var isDotAddingView = false
	
	func isCoordinatesValid(_ coordinates: Coordinates) -> Bool {
		let x = coordinates.x
		let y = coordinates.y
		
		guard !x.isEmpty, !y.isEmpty else {
			return false
		}
		
		return isConvertable(coordinates: coordinates)
	}
	
	func onSubmitButton(coordinates cords: Coordinates, name: String, color: String) {
		guard let numbercalCords = convert(coordinates: cords) else {
			return
		}
		
		let dot = makeDot(withName: name, color: color, coordinates: numbercalCords)
		objects.append(dot)
	}
	
	func convert(coordinates: Coordinates) -> NumericalCoordinates? {
		guard let x = CGFloat(coordinates.x),
			  let y = CGFloat(coordinates.y) else {
			return nil
		}
		return (x, y)
	}
	
	func onAddLine() {
		print("adding line")
	}
	
	func onDelete(object: GeometryObject) {
		objects.removeFirst(element: object) {
			$0.id != $1.id
		}
	}
	
	private func isConvertable(coordinates: Coordinates) -> Bool {
		guard let _ = Double(coordinates.x),
		   let _ = Double(coordinates.y) else {
			return false
		}
		return true
	}
	
	private func makeDot(withName name: String, color: String, coordinates cords: NumericalCoordinates) -> Dot {
		let dot = Dot(name: name, coordinates: cords, color: color)
		return dot
	}
}
