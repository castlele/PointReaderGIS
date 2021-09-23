//
//  MouseLocation.swift
//  MouseLocation
//
//  Created by Nikita Semenov on 22.09.2021.
//

import Cocoa

final class MouseLocation {
		
	enum MouseArea {
		case inspector, coordinateSystem
	}
	
	static func setUpCursor(to areaType: MouseArea, isInside: Bool) {
		if isInside {
			switch areaType {
				case .inspector:
					NSCursor.pop()
					NSCursor.currentSystem?.push()
					
				case .coordinateSystem:
					NSCursor.pop()
					NSCursor.crosshair.push()
					
			}
		}
	}
}
