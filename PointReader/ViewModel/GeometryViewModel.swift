//
//  GeometryViewModel.swift
//  GeometryViewModel
//
//  Created by Nikita Semenov on 22.09.2021.
//

import Foundation

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

// MARK: - GeometryViewModel
final class GeometryViewModel: ObservableObject, CartesianConvertable {
	
	private typealias NumericalCoordinates = (x: CGFloat, y: CGFloat)
	
	var objectOffset = dotRadius / 2 - 0.25
	
	@Published var mouseLocation = CGPoint(x: 0, y: 0)
	@Published var lastTapped = CGPoint(x: 0, y: 0)
	
	func convertToCartesian(point: CGPoint) {
		DispatchQueue.global(qos: .background).async { [self] in
			let x = convertToCartesian(x: point.x)
			let y = convertToCartesian(y: point.y)
			let (roundedX, roundedY) = roundCoordinates(coordinates: (x, y))
			let newPoint = CGPoint(x: roundedX, y: roundedY)
			
			DispatchQueue.main.async { [self] in
				mouseLocation = newPoint
			}
		}
	}
	
	func setLastTapped() {
		lastTapped = mouseLocation
	}
	
	private func roundCoordinates(coordinates cords: NumericalCoordinates) -> NumericalCoordinates {
		// Rounding two decimal places
		let roundedX = round(cords.x * 100) / 100
		let roundedY = round(cords.y * 100) / 100
		
		return (x: roundedX, y: roundedY)
	}
}
