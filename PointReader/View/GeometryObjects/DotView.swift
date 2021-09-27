//
//  DotView.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct DotView: View {
	
	var dot: Dot
	
	var body: some View {
		Circle()
			.fill(Color(dot.color))
			.frame(width: dotRadius, height: dotRadius)
			.offset(x: dot.cartesianX, y: dot.cartesianY)
	}
	
	init(_ dot: Dot) {
		self.dot = dot
	}
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
		DotView(Dot(x: 0, y: 0, color: "blue"))
    }
}
