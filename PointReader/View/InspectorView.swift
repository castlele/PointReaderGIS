//
//  InspectorView.swift
//  PointReader
//
//  Created by Nikita Semenov on 19.09.2021.
//

import SwiftUI

// MARK: - InspectorView
struct InspectorView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	
    var body: some View {
		List {
			Section(header: Text("Dot")) {
				InputDotCoordinatesView(controllsType: .default)
					.padding(.horizontal)
					.animation(.easeOut)
			}
			
			Section(header: Text("Line")) {
				InputLineCoordinatesView()
					.padding(.horizontal)
					.animation(.easeOut)
			}
						
			Spacer()
			
			ListOfGeometryObjects(dots: $inputVM.dots, onDelete: inputVM.onDelete(dot:))
				.frame(minHeight: 500)
				.background(Color.white)
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
    }
}

// MARK: - InputDotCoordinatesView
struct InputDotCoordinatesView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	var text: String
	@State var coordinates: Coordinates
	var controllsType: ControllsType
	var onSubmit: (() -> Void)?
	var onCancel: (() -> Void)?
	
	enum ControllsType {
		case `default`, cancel
	}
	
	@State private var name = ""
	@State private var color = ColorModel.colors[0]
	
	var body: some View {
		VStack {
			Text(text)
				.fixedSize()
			
			LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
				
				HStack {
					Circle()
						.fill(Color(color))
						.frame(width: 10, height: 10)
					
					Picker("Color", selection: $color) {
						ForEach(ColorModel.colors, id: \.self) { color in
							Text(color.capitalized)
						}
					}
					.labelsHidden()
				}
								
				TextField("Name", text: $name)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				TextField("x", text: $coordinates.x)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				TextField("y", text: $coordinates.y)
					.textFieldStyle(RoundedBorderTextFieldStyle())
			}
			
			controlls
		}
	}
	
	var controlls: some View {
		Group {
			switch controllsType {
				case .default:
					defaultControlls
				case .cancel:
					cancelControlls
			}
		}
	}
	
	private var defaultControlls: some View {
		HStack {
			Spacer()
			
			addButton
		}
	}
	
	private var cancelControlls: some View {
		HStack {
			cancelButton
			
			Spacer()
			
			addButton
		}
	}
		
	private var addButton: some View {
		Button("Add dot") {
			withAnimation(.easeOut) {
				inputVM.onSubmit(coordinates: coordinates, name: name, color: color)
				coordinates = ("", "")
				name = ""
				
				onSubmit?()
			}
		}
		.keyboardShortcut(.defaultAction)
		.disabled(!inputVM.isCoordinatesValid(coordinates))
	}
		
	private var cancelButton: some View {
		Button("Cancel") {
			withAnimation(.easeOut) {
				onCancel?()
			}
		}
		.keyboardShortcut(.cancelAction)
	}
	
	init(
		text: String = "Dot settings",
		coordinates: Coordinates = ("", ""),
		controllsType: ControllsType = .default,
		onSubmit: (() -> Void)? = nil,
		onCancel: (() -> Void)? = nil
	) {
		self.text = text
		self.coordinates = coordinates
		self.controllsType = controllsType
		self.onSubmit = onSubmit
		self.onCancel = onCancel
	}
}

extension InputDotCoordinatesView: Equatable {
	static func == (lhs: InputDotCoordinatesView, rhs: InputDotCoordinatesView) -> Bool {
		let xExp = lhs.coordinates.x == rhs.coordinates.x
		let yExp = lhs.coordinates.y == rhs.coordinates.y
		return xExp && yExp
	}
}

// MARK: - ListOfGeometryObjects
fileprivate struct ListOfGeometryObjects: View {
	
	@Binding var dots: [Dot]
	var onDelete: ((Dot) -> Void)
	
	// MARK: - DotDescriptionRow
	fileprivate struct DotDescriptionRow: View {
		
		let dot: Dot
		
		var body: some View {
			HStack {
				Group {
					Circle()
						.fill(Color(dot.color))
						.frame(width: 13, height: 13)
					
					Text("Dot: \(dot.name)")
						.font(.title2)
						.fixedSize()
				}
				.padding(.trailing, 10)
				
				Text("(\(dot.x, specifier: "%.2f"); \(dot.y, specifier: "%.2f"))")
					.font(.title2)
					.fixedSize()
				
				Spacer()
			}
		}
	}
	
	@State private var selected: Dot? = nil
	
	var body: some View {
		List {
			ForEach(dots) { dot in
				DotDescriptionRow(dot: dot)
					.contextMenu {
						Button(action: {
							onDelete(dot)
						}, label: {
							Text("Delete")
						})
					}
					.padding(.horizontal, 2)
					.padding(.vertical, 5)
					.clipShape(RoundedRectangle(cornerRadius: 8))
				
				Divider()
			}
		}
	}
}

// MARK: - InputLineCoordinates
fileprivate struct InputLineCoordinatesView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	
	var body: some View {
		VStack {
			HStack {
				Text("Connect the dots")
					.fixedSize()
				
				Spacer()
				
				Picker("First dot", selection: $inputVM.lineEndA) {
					ForEach(inputVM.dots.filter { $0 != inputVM.lineEndB }, id: \.self) { dot in
						Text("\(dot.x, specifier: "%.2f"); \(dot.y, specifier: "%.2f")")
							.foregroundColor(Color(dot.color))
					}
				}
				.labelsHidden()
				.pickerStyle(RadioGroupPickerStyle())
				
				Picker("Second dot", selection: $inputVM.lineEndB) {
					ForEach(inputVM.dots.filter { $0 != inputVM.lineEndA }, id: \.self) { dot in
						Text("\(dot.x, specifier: "%.2f"); \(dot.y, specifier: "%.2f")")
							.foregroundColor(Color(dot.color))
					}
				}
				.labelsHidden()
				.pickerStyle(RadioGroupPickerStyle())
			}
			
			HStack {
				Spacer()
				
				Button("Add Line") {
					withAnimation(.easeOut) {
						inputVM.onAddLine()
					}
				}
				.keyboardShortcut(.defaultAction)
				.disabled(true)
			}
		}
	}
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
