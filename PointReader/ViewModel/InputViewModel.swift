//
//  InputViewModel.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

public typealias Coordinates = (x: String, y: String)

// MARK: - InputViewModel
final class InputViewModel: ObservableObject {
	
	@Published var dotCoordinates: Coordinates = ("", "") {
		willSet(newCords) {
			guard let newDot = convert(coordinates: newCords) else {
				return
			}
			
			dots.append(newDot)
		}
	}
	
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
	
	func onSubmit(coordinates: (String, String)) {
		dotCoordinates = coordinates
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
	
	private func convert(coordinates: Coordinates) -> Dot? {
		guard let x = Double(coordinates.x),
			  let y = Double(coordinates.y) else {
			return nil
		}
		
		let color = ColorModel.getColor(for: dots.count)
		let dot = Dot(x: x, y: y, color: color)
		
		return dot
	}
}
