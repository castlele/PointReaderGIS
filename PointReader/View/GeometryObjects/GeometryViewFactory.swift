//
//  GeometryViewFactory.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct GeometryViewFactory {
	
	static func makeView(object obj: GeometryObject) -> some View {
		switch obj {
			case let dot as Dot:
				return AnyView(DotView(dot))
			default:
				return AnyView(EmptyView())
		}
	}
}
