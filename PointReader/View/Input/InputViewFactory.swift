//
//  InputViewFactory.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct InputViewFactory {
	
	enum InputObjectType {
		case dot(coordinates: Binding<CGPoint>, onSubmit: (() -> Void)? = nil, onCancel: (() -> Void)? = nil)
		case line(coordinates: Binding<CGPoint>, onSubmit: (() -> Void)? = nil, onCancel: (() -> Void)? = nil)
	}
	
	static func makeView(type: InputObjectType) -> some View {
		switch type {
			case let .dot(coordinates: cords, onSubmit: onSubmit, onCancel: onCancel):
				return AnyView(
					InputDotView(
						coordinates: ("\(cords.x.wrappedValue)", "\(cords.y.wrappedValue)"),
						controllsType: .cancel,
						onSubmit: onSubmit,
						onCancel: onCancel)
						.padding(5)
						.frame(maxWidth: 300)
						.background(Color.init(red: 0.9255852103, green: 0.9175997376, blue: 0.9215269089))
						.clipShape(RoundedRectangle(cornerRadius: 8))
				)
				
			case let .line(coordinates: cords, onSubmit: onSubmit, onCancel: onCancel):
				return AnyView(
					InputLineView(
						controllsType: .cancel,
						firstEndCoordinats: ("\(cords.x.wrappedValue)", "\(cords.y.wrappedValue)"),
						onSubmit: onSubmit,
						onCancel: onCancel)
						.padding(5)
						.frame(maxWidth: 300)
						.background(Color.init(red: 0.9255852103, green: 0.9175997376, blue: 0.9215269089))
						.clipShape(RoundedRectangle(cornerRadius: 8))
				)
		}
	}
}
