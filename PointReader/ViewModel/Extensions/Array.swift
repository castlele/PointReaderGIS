//
//  Array.swift
//  Array
//
//  Created by Nikita Semenov on 22.09.2021.
//

extension Array where Element: Equatable {
	mutating func removeFirst(element: Element) {
		var result = [Element]()
		
		for el in self {
			if el != element {
				result.append(el)
				continue
			}
		}
		
		self = result
	}
}
