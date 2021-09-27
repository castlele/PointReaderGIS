//
//  Dot.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

final class Dot: CartesianConvertable, Identifiable {
	
	let id = UUID()
	
	var name: String
	var x: CGFloat
	var y: CGFloat
	
	var color: String
	
	var correspondingLineEnd: Dot? = nil
	
	init(name: String = "dot", x: CGFloat, y: CGFloat, color: String) {
		self.name = name
		self.x = CGFloat(x)
		self.y = CGFloat(y)
		self.color = color
	}
	
	convenience init(name: String = "dot", coordinates cords: NumericalCoordinates, color: String) {
		self.init(name: name, x: cords.x, y: cords.y, color: color)
	}
	
	var cartesianX: CGFloat { determineOffset(x: x) }
	var cartesianY: CGFloat { determineOffset(y: y) }
	
	var objectOffset = dotRadius / 2 - 0.25
	
	func getCGPoint() -> CGPoint { CGPoint(x: cartesianX, y: cartesianY) }
}

extension Dot: Equatable, Hashable {
	
	func hash(into hasher: inout Hasher) {
		hasher.combine("\(name)\(id)\(x)\(y)")
	}
	
	static func == (lhs: Dot, rhs: Dot) -> Bool {
		let xExp = lhs.x == rhs.x
		let yExp = lhs.y == rhs.y
		let colorExp = lhs.color == rhs.color
		
		return xExp && yExp && colorExp
	}
}
