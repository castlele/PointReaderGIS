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
	@State var coordinates: Coordinates = ("", "")
	
    var body: some View {
		List {
			Section(header: Text("Dot")) {
				InputDotCoordinatesView(text: "Enter coordinates", coordinates: $coordinates)
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
fileprivate struct InputDotCoordinatesView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	var text: String
	@Binding var coordinates: Coordinates
	
	var body: some View {
		VStack {
			HStack {
				Text(text)
					.fixedSize()
				
				TextField("x", text: $coordinates.0)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				TextField("y", text: $coordinates.1)
					.textFieldStyle(RoundedBorderTextFieldStyle())
			}
			
			HStack {
				Spacer()
				
				Button("Add dot") {
					withAnimation(.easeOut) {
						inputVM.onSubmit(coordinates: coordinates)
						coordinates = ("", "")
					}
				}
				.keyboardShortcut(.defaultAction)
				.disabled(!inputVM.isCoordinatesValid(coordinates))
			}
		}
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
					
					Text("Type: Dot")
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
