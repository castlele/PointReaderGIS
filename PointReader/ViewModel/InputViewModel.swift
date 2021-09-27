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

public typealias Coordinates = (x: String, y: String)

// MARK: - InputViewModel
final class InputViewModel: ObservableObject {
	
	@Published var dots: [Dot] = []
	@Published var lineEndA = Dot(x: 0.0, y: 0.0, color: "red")
	@Published var lineEndB = Dot(x: 0.0, y: 0.0, color: "red")
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
	
	func onSubmit(coordinates: Coordinates, name: String, color: String) {
		guard let numbercalCords = convert(coordinates: coordinates) else {
			return
		}
		let dot = makeDot(withName: name, color: color, coordinates: numbercalCords)
		dots.append(dot)
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
	
	func onDelete(dot: Dot) {
		dots.removeFirst(element: dot)
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
