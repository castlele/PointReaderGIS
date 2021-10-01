//
//  InputViewModel.swift
//  PointReader
//
//  Created by Nikita Semenov on 20.09.2021.
//

import SwiftUI

// MARK: - InputViewModel
final class InputViewModel: ObservableObject {
	
	enum AddingMode {
		case none, dot, line
	}
	
	@Published var inputView = AnyView(EmptyView())
	@Published var objects: [GeometryObject] = []
	@Published var addingMode: AddingMode = .none
	
	func isCoordinatesValid(_ coordinates: Coordinates) -> Bool {
		let x = coordinates.x
		let y = coordinates.y
		
		guard !x.isEmpty, !y.isEmpty else {
			return false
		}
		
		return isConvertable(coordinates: coordinates)
	}
	
	func onSubmitButton(coordinates cords: Coordinates, name: String, color: String) {
		guard let numbercalCords = convert(coordinates: cords) else {
			return
		}
		
		let attributs: GeometryObjectFactory.Attributes = .dot(name: name, color: color, coordinates: numbercalCords)
			let dot = GeometryObjectFactory.shared.makeObject(withAttributes: attributs)
		
		objects.append(dot)
	}
	
	func onSubmitLine(endA a: Coordinates, endB b: Coordinates, name: String, color: String) {
		guard let numACords = convert(coordinates: a) else { return }
		guard let numBCords = convert(coordinates: b) else { return }
		
		let endAAttr: GeometryObjectFactory.Attributes = .dot(name: "", color: color, coordinates: numACords)
		let endBAttr: GeometryObjectFactory.Attributes = .dot(name: "", color: color, coordinates: numBCords)
		let endA = GeometryObjectFactory.shared.makeObject(withAttributes: endAAttr) as! Dot
		let endB = GeometryObjectFactory.shared.makeObject(withAttributes: endBAttr) as! Dot
		
		let lineAttr: GeometryObjectFactory.Attributes = .line(name: name, endA: endA, endB: endB)
		let line = GeometryObjectFactory.shared.makeObject(withAttributes: lineAttr)
		
		objects.append(line)
	}
	
	func tapToAddGeometryObject(lastTapped: Binding<CGPoint>) {
		if addingMode != .none {
			
			var inputObjectType: InputViewFactory.InputObjectType? = nil
			
			switch addingMode {
				case .none:
					break
				case .dot:
					inputObjectType = .dot(coordinates: lastTapped) {
						self.addingMode = .none
						self.inputView = AnyView(EmptyView())
					} onCancel: {
						self.addingMode = .none
						self.inputView = AnyView(EmptyView())
					}
				case .line:
					inputObjectType = .line(coordinates: lastTapped) {
						self.addingMode = .none
						self.inputView = AnyView(EmptyView())
					} onCancel: {
						self.addingMode = .none
						self.inputView = AnyView(EmptyView())
					}
			}
			
			guard let inputObjectType = inputObjectType else {
				return
			}
			
			inputView = InputViewFactory.makeView(type: inputObjectType) as! AnyView
		}
	}
	
	func convert(coordinates: Coordinates) -> NumericalCoordinates? {
		guard let x = CGFloat(coordinates.x),
			  let y = CGFloat(coordinates.y) else {
			return nil
		}
		return (x, y)
	}
	
	func onDelete(object: GeometryObject) {
		objects.removeFirst(element: object, compareBy: compare)
	}
	
	func selectObject(_ obj: GeometryObject) {
		var object = objects.popFirst(element: obj, compareBy: compare)
		object?.isSelected = !obj.isSelected
		guard let object = object else { return }
		objects.append(object)
	}
	
	private func isConvertable(coordinates: Coordinates) -> Bool {
		guard let _ = Double(coordinates.x),
		   let _ = Double(coordinates.y) else {
			return false
		}
		return true
	}
	
	private func compare(_ obj1: GeometryObject, _ obj2: GeometryObject) -> Bool {
		obj1.id == obj2.id
	}
}
