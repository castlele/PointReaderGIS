//
//  GeometryViewModel.swift
//  GeometryViewModel
//
//  Created by Nikita Semenov on 22.09.2021.
//

import Foundation

// MARK: - GeometryViewModel
final class GeometryViewModel: ObservableObject, CartesianConvertable {
	
	var objectOffset = dotRadius / 2 - 0.25
	
	@Published var mouseLocation = CGPoint(x: 0, y: 0)
	@Published var lastTapped = CGPoint(x: 0, y: 0)
	
	func convertToCartesian(point: CGPoint) {
		DispatchQueue.global(qos: .utility).async { [self] in
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
