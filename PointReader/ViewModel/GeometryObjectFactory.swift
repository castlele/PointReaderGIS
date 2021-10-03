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
		case polygon(name: String, lines: [Line])
	}
	
	func makeObject(withAttributes attr: Attributes) -> GeometryObject {
		switch attr {
			case let .dot(name, color, coordinates):
				return makeDot(withName: name, color: color, coordinates: coordinates)
				
			case let .line(name, endA, endB):
				return makeLine(withName: name, endA: endA, endB: endB)
				
			case let .polygon(name, lines):
				return makePolygon(withName: name, lines: lines)
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
	
	private func makePolygon(withName name: String, lines: [Line]) -> Polygon {
		let polygon = Polygon(name: name, lines: lines)
		return polygon
	}
}
