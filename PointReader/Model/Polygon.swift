//
//  Polygon.swift
//  PointReader
//
//  Created by Nikita Semenov on 03.10.2021.
//

import Foundation

struct Polygon: GeometryObject {
	
	let id = UUID()
	var isSelected = false
	
	var name: String
	var lines: [Line]
	
	
	init(name: String, lines: [Line]) {
		var lineName = String()
		
		if name.isEmpty {
			for line in lines {
				lineName += line.name
			}
		} else {
			lineName = name
		}
		
		self.name = lineName
		self.lines = lines
	}
	
	init(lines: [Line]) {
		self.init(name: "", lines: lines)
	}
}
