//
//  Array.swift
//  Array
//
//  Created by Nikita Semenov on 22.09.2021.
//

extension Array {
//	map<T>(_ transform: ((offset: Int, element: Base.Element)) throws -> T) rethrows -> [T]
	mutating func removeFirst(element: Element, compareBy: @escaping ((Element, Element) -> Bool)) {
		var result = [Element]()
		
		for el in self {
			if compareBy(el, element) {
				result.append(el)
				continue
			}
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
