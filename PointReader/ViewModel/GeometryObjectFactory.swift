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
		case line(name: String, endA: Dot, endB: Dot)
	}
	
	func makeObject(withAttributes attr: Attributes) -> GeometryObject {
		switch attr {
			case let .dot(name, color, coordinates):
				return makeDot(withName: name, color: color, coordinates: coordinates)
				
			case let .line(name, endA, endB):
				return makeLine(withName: name, endA: endA, endB: endB)
		}
	}
	
	private func makeDot(withName name: String, color: String, coordinates cords: NumericalCoordinates) -> Dot {
		let dot = Dot(name: name, coordinates: cords, color: color)
		return dot
	}
	
	private func makeLine(withName name: String, endA: Dot, endB: Dot) -> Line {
		let line = Line(name: name, endA: endA, endB: endB)
		return line
	}
}
