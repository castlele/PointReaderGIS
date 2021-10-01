//
//  Dot.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

struct Dot: GeometryObject {
	
	let id = UUID()
	var isSelected = false
	
	var name: String
	var x: CGFloat
	var y: CGFloat
	
	var color: String
		
	init(name: String = "dot", x: CGFloat, y: CGFloat, color: String) {
		self.name = name
		self.x = CGFloat(x)
		self.y = CGFloat(y)
		self.color = color
	}
	
	init(name: String = "dot", coordinates cords: NumericalCoordinates, color: String) {
		self.init(name: name, x: cords.x, y: cords.y, color: color)
	}
	
	var cartesianX: CGFloat { determineOffset(x: x) }
	var cartesianY: CGFloat { determineOffset(y: y) }
	
	var objectOffset = dotRadius / 2 - 0.25
	
	func getNumericalCords() -> NumericalCoordinates { (x, y) }
	func getCGPoint() -> CGPoint { CGPoint(x: cartesianX, y: cartesianY) }
}

extension Dot: CartesianConvertable { }
