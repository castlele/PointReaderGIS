//
//  Line.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import Foundation

final class Line: GeometryObject {
	
	let id = UUID()
	
	var name: String
	var endA: Dot
	var endB: Dot
	
	
	init(name: String, endA a: Dot, endB b: Dot) {
		self.name = name
		self.endA = a
		self.endB = b
	}
	
	convenience init(endA a: Dot, endB b: Dot) {
		let name = a.name + b.name
		self.init(name: name, endA: a, endB: b)
	}
}


