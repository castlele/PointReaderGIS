//
//  Color.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import Foundation

struct ColorModel {
	
	private enum ColorsKit: String, CaseIterable {
		case red, green, blue, brown, purple, pink, orange
		
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
	
	static var colors: [String] = {
		ColorsKit.allCases.map { $0.rawValue }
	}()
	
	static func getColor(for index: Int) -> String {
		let kit = ColorsKit(colorIndex: index)
		return kit.rawValue
	}
}
