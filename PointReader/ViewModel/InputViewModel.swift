//
//  InputViewModel.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

extension Array where Element: Equatable {
	mutating func removeFirst(element: Element) {
		var result = [Element]()
		
		for el in self {
			if el != element {
				result.append(el)
				continue
			}
		}
		
		self = result
	}
}

final class InputViewModel: ObservableObject {
	
	@Published var dotCoordinates = ("", "") {
		willSet(newCords) {
			guard let newDot = convert(coordinates: newCords) else {
				return
			}
			
			dots.append(newDot)
		}
	}
	
	@Published var dots: [Dot] = []
	
	func onSubmit(coordinates: (String, String)) {
		dotCoordinates = coordinates
	}
	
	func onDelete(dot: Dot) {
		dots.removeFirst(element: dot)
	}
	
	private func convert(coordinates: (String, String)) -> Dot? {
		guard let x = Double(coordinates.0),
			  let y = Double(coordinates.1) else {
			return nil
		}
		
		let color = ColorModel.getColor(for: dots.count)
		let dot = Dot(x: x, y: y, color: color)
		
		return dot
	}
}
