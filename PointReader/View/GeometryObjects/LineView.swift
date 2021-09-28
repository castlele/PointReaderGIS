//
//  LineView.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct LineView: View {
	
	var line: Line
	
    var body: some View {
		ZStack {
			GeometryReader { _ in
				Path { path in
					path.move(to: CGPoint(x: line.endA.cartesianX + dotRadius / 2, y: line.endA.cartesianY + dotRadius / 2))
					path.addLine(to: CGPoint(x: line.endB.cartesianX + dotRadius / 2, y: line.endB.cartesianY + dotRadius / 2))
				}
				.stroke(Color.black, style: .init(lineWidth: 3, lineCap: .round, lineJoin: .miter, miterLimit: 0, dash: [], dashPhase: 0))
				
				DotView(line.endA)
				
				DotView(line.endB)
			}
		}
    }
	
	init(_ line: Line) {
		self.line = line
	}
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
		LineView(Line(endA: Dot(name: "A", x: 0, y: 0, color: "blue"), endB: Dot(name: "B", x: 0, y: 0, color: "blue")))
    }
}
