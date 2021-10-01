//
//  Array.swift
//  Array
//
//  Created by Nikita Semenov on 22.09.2021.
//

extension Array {
	mutating func removeFirst(element: Element, compareBy: @escaping ((Element, Element) -> Bool)) {
		var result = [Element]()
		
		for el in self {
			if compareBy(el, element) {
				continue
			}
			result.append(el)
		}
		
		self = result
	}
}

extension Array {
	subscript(safe i: Int) -> Element? {
		guard i < count else {
			return nil
		}
		
		guard i >= 0 else {
			return nil
		}
		
		return self[i]
	}
}
