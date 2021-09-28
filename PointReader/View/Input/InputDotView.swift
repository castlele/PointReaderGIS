//
//  InputDotView.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

enum ControllsType {
	case `default`, cancel
}

struct InputDotView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	@State var coordinates: Coordinates
	var text: String
	let controllsType: ControllsType
	var onSubmit: (() -> Void)?
	var onCancel: (() -> Void)?
	
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
					.fixedSize()
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
				inputVM.onSubmitButton(coordinates: coordinates, name: name, color: color)
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
	
	// MARK: - Initialization 
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
