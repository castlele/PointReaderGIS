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
	@State var coordinates = ("", "")
	
    var body: some View {
		VStack {
			InputDotCoordinatesView(text: "Enter coordinates", coordinates: $coordinates, onSubmit: inputVM.onSubmit(coordinates:))
				.padding(.horizontal)
				.animation(.easeOut)
			
			Spacer()
			
			ListOfGeometryObjects(dots: $inputVM.dots, onDelete: inputVM.onDelete(dot:))
		}
    }
}

// MARK: - InputDotCoordinatesView
fileprivate struct InputDotCoordinatesView: View {
	
	var text: String
	@Binding var coordinates: (String, String)
	var onSubmit: (((String, String)) -> Void)
	
	var body: some View {
		VStack {
			HStack {
				Text(text)
					.font(.title2)
					.fixedSize()
				
				TextField("x", text: $coordinates.0)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				TextField("y", text: $coordinates.1)
					.textFieldStyle(RoundedBorderTextFieldStyle())
			}
			if !coordinates.0.isEmpty, !coordinates.1.isEmpty {
				HStack {
					Spacer()
					
					Button("Add dot") {
						withAnimation(.easeOut) {
							onSubmit(coordinates)
							coordinates = ("", "")
						}
					}
					.keyboardShortcut(.defaultAction)
				}
			}
		}
	}
}

// MARK: - ListOfGeometryObjects
fileprivate struct ListOfGeometryObjects: View {
	
	@Binding var dots: [Dot]
	var onDelete: ((Dot) -> Void)
	
	// MARK: - DotDescriptionRow
	private struct DotDescriptionRow: View {
		
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
			}
		}
	}
}

// MARK: - InputLineCoordinates
fileprivate struct InputLineCoordinatesView: View {
	var body: some View {
		VStack {
			
		}
	}
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
