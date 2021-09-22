//
//  Color.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

struct ColorModel {
	
	private enum ColorsKit: String, CaseIterable {
		case red, green, blue, yellow, brown, purple, pink, orange
		
		init(colorIndex: Int) {
			let allCases = ColorsKit.allCases
			var index = colorIndex
			var kit: ColorsKit? = nil
			
			while kit == nil, index >= 0 {
				kit = allCases[safe: index]
				index -= allCases.count
			}
			
			self = kit!
		}
	}
	
	private var colorIndex: Int
	
	init(colorIndex: Int) {
		self.colorIndex = colorIndex
	}
	
	init() {
		self.colorIndex = 0
	}
	
	var color: String { Self.getColor(for: colorIndex) }
	
	static func getColor(for index: Int) -> String {
		let kit = ColorsKit(colorIndex: index)
		return kit.rawValue
	}
}
