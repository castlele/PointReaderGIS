//
//  InputLineView.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct InputLineView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	var text: String
	let controllsType: ControllsType
	@State var endA: Coordinates
	var onSubmit: (() -> Void)?
	var onCancel: (() -> Void)?
	
	@State private var name = ""
	@State private var color = ColorModel.colors[0]
	@State private var endB: Coordinates = ("", "")
	
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
				
					TextField("x₁", text: $endA.x)
						.textFieldStyle(RoundedBorderTextFieldStyle())
					
					TextField("y₁", text: $endA.y)
						.textFieldStyle(RoundedBorderTextFieldStyle())
				
					TextField("x₂", text: $endB.x)
						.textFieldStyle(RoundedBorderTextFieldStyle())
					
					TextField("y₂", text: $endB.y)
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
				inputVM.onSubmitLine(endA: endA, endB: endB, name: name, color: color)
				endA = ("", "")
				endB = ("", "")
				name = ""
				
				onSubmit?()
			}
		}
		.keyboardShortcut(.defaultAction)
		.disabled(!inputVM.isCoordinatesValid(endA) || !inputVM.isCoordinatesValid(endB))
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
		text: String = "Line Settings",
		controllsType: ControllsType = .default,
		firstEndCoordinats cords: Coordinates = ("", ""),
		onSubmit: (() -> Void)? = nil,
		onCancel: (() -> Void)? = nil
	) {
		self.text = text
		self.controllsType = controllsType
		self.endA = cords
		self.onCancel = onCancel
		self.onSubmit = onSubmit
	}
}
