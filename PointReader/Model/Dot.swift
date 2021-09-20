//
//  Dot.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

struct Dot: Identifiable {
	
	let id = UUID()
	
	let x: CGFloat
	let y: CGFloat
	
	let color: String
	
	var cartesianX: CGFloat { determineOffset(x: x) }
	var cartesianY: CGFloat { determineOffset(y: y) }
	
	private let dotCenter = dotRadius / 2 - 0.25
	
	private func determineOffset(x: CGFloat) -> CGFloat { coordinateSpaceHeight / 2 + (x * squareHeight) - dotCenter }
	
	private func determineOffset(y: CGFloat) -> CGFloat { coordinateSpaceHeight / 2 - (y * squareHeight) - dotCenter }
}

extension Dot {
	init(x: Double, y: Double, color: String) {
		self.x = CGFloat(x)
		self.y = CGFloat(y)
		self.color = color
	}
}

extension Dot: Equatable {
	static func == (lhs: Dot, rhs: Dot) -> Bool {
		let xExp = lhs.x == rhs.x
		let yExp = lhs.y == rhs.y
		let colorExp = lhs.color == rhs.color
		
		return xExp && yExp && colorExp
	}
}
