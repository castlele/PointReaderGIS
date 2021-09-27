//
//  GeometryObjectFactory.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct GeometryObjectFactory {
	
	static var shared = GeometryObjectFactory()
	
	enum Attributes {
		case dot(name: String, color: String, coordinates: NumericalCoordinates)
	}
	
	func makeObject(withAttributes attr: Attributes) -> GeometryObject {
		switch attr {
			case .dot(let name, let color, let coordinates):
				return makeDot(withName: name, color: color, coordinates: coordinates)
		}
	}
	
	private func makeDot(withName name: String, color: String, coordinates cords: NumericalCoordinates) -> Dot {
		let dot = Dot(name: name, coordinates: cords, color: color)
		return dot
	}
}
