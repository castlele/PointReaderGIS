//
//  PolygonView.swift
//  PointReader
//
//  Created by Nikita Semenov on 03.10.2021.
//

import SwiftUI

struct PolygonView: View {
	
	var polygon: Polygon
	
    var body: some View {
		ZStack {
			ForEach(polygon.lines, id: \.id) { line in
				LineView(line)
			}
		}
    }
	
	init(_ polygon: Polygon) {
		self.polygon = polygon
	}
}

struct PolygonView_Previews: PreviewProvider {
    static var previews: some View {
        PolygonView(Polygon(lines: [
			Line(endA: Dot(name: "A", x: 0, y: 0, color: "blue"), endB: Dot(name: "B", x: 0, y: 0, color: "blue")),
			Line(endA: Dot(name: "A", x: 0, y: 0, color: "blue"), endB: Dot(name: "B", x: 0, y: 0, color: "blue")),
			Line(endA: Dot(name: "A", x: 0, y: 0, color: "blue"), endB: Dot(name: "B", x: 0, y: 0, color: "blue"))
		]))
    }
}
