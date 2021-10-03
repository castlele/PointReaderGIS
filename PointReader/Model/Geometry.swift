//
//  Geometry.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import Foundation

typealias Coordinates = (x: String, y: String)
typealias NumericalCoordinates = (x: Double, y: Double)

protocol GeometryObject {
	var id: UUID { get }
	var isSelected: Bool { get set }
}

// MARK: - CartesianConvertable
protocol CartesianConvertable {
	var objectOffset: CGFloat { get }
	
	func convertToCartesian(x: CGFloat) -> CGFloat
	func convertToCartesian(y: CGFloat) -> CGFloat
	func determineOffset(x: CGFloat) -> CGFloat
	func determineOffset(y: CGFloat) -> CGFloat
}

extension CartesianConvertable {
	
	func convertToCartesian(x: CGFloat) -> CGFloat {
		(-coordinateSpaceHeight / 2 + x) / 10
	}
	
	func convertToCartesian(y: CGFloat) -> CGFloat {
		(coordinateSpaceHeight / 2 - y) / 10
	}
	
	func determineOffset(x: CGFloat) -> CGFloat {
		coordinateSpaceHeight / 2 + (x * squareHeight) - objectOffset
	}
	
	func determineOffset(y: CGFloat) -> CGFloat {
		coordinateSpaceHeight / 2 - (y * squareHeight) - objectOffset
	}
}
