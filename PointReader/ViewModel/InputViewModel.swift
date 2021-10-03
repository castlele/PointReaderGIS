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
	@Published var selectedObjects: [GeometryObject] = []
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
		
		createLine(numACords, numBCords, name: name, color: color)
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
		guard let x = Double(coordinates.x),
			  let y = Double(coordinates.y) else {
			return nil
		}
		return (x, y)
	}
	
	func onDelete(object: GeometryObject) {
		objects.removeFirst(element: object, compareBy: compare)
	}
	
	func onDelete(objects: GeometryObject...) {
		for obj in objects {
			self.objects.removeFirst(element: obj, compareBy: compare)
		}
	}
	
	func selectObject(_ obj: GeometryObject) {
		guard let index = objects.firstIndex(where: { compare($0, obj) }) else {
			return
		}
		
		objects[index].isSelected = !obj.isSelected
		
		if objects[index].isSelected {
			selectedObjects.append(objects[index])
		} else {
			selectedObjects.removeFirst(element: objects[index], compareBy: compare)
		}
	}
	
	func determineMergingType() -> String {
		if let _ = onCreatingLine() {
			return "Create a line"
		}
		
		return ""
	}
	
	func merge() {
		if let (endA, endB) = onCreatingLine() {
			createLine(endA.getNumericalCords(), endB.getNumericalCords(), color: endA.color)
			onDelete(objects: endA, endB)
			selectedObjects.removeAll()
		}
	}
	
	private func createLine(
		_ a: NumericalCoordinates,
		_ b: NumericalCoordinates,
		name: String = "",
		color: String = "red"
	) {
		let endAAttr: GeometryObjectFactory.Attributes = .dot(name: "", color: color, coordinates: a)
		let endBAttr: GeometryObjectFactory.Attributes = .dot(name: "", color: color, coordinates: b)
		let endA = GeometryObjectFactory.shared.makeObject(withAttributes: endAAttr) as! Dot
		let endB = GeometryObjectFactory.shared.makeObject(withAttributes: endBAttr) as! Dot
		
		let lineAttr: GeometryObjectFactory.Attributes = .line(name: name, endA: endA, endB: endB)
		let line = GeometryObjectFactory.shared.makeObject(withAttributes: lineAttr)
		
		objects.append(line)
	}
	
	private func onCreatingLine() -> (Dot, Dot)? {
		guard selectedObjects.count == 2,
			  let dots = (selectedObjects[0], selectedObjects[1]) as? (Dot, Dot)
		else {
			return nil
		}
		
		return dots
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
