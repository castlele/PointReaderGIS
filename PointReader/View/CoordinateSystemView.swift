//
//  ContentView.swift
//  PointReader
//
//  Created by Nikita Semenov on 19.09.2021.
//

import SwiftUI

public let dotRadius = CGFloat(8)
public let squareHeight = CGFloat(10)
public let segmentHeight = squareHeight * 10
public let coordinateSpaceHeight = segmentHeight * 8

struct CoordinateSystemView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	
	private let height = coordinateSpaceHeight
	
    var body: some View {
		ZStack {
			Color.white
			
			VStack(spacing: 0) {
				ForEach(0..<8) { _ in
					HStack(spacing: 0) {
						ForEach(0..<8) { _ in
							CoordinateSegment()
								.stroke(Color.gray)
								.frame(width: segmentHeight, height: segmentHeight, alignment: .center)
								.background(Rectangle().stroke(Color.black))
								.scaleEffect(1)
						}
					}
				}
			}
			.frame(width: height, height: height)
			.overlay(
				Path { path in
					// OX and OY
					path.move(to: CGPoint(x: 0, y: height / 2))
					path.addLine(to: CGPoint(x: height, y: height / 2))
					
					path.move(to: CGPoint(x: height / 2, y: 0))
					path.addLine(to: CGPoint(x: height / 2, y: height))
				}
				.stroke(Color.black, lineWidth: 2)
			)
			.overlay(
				GeometryReader { _ in
					ForEach(inputVM.dots) { dot in
						DotView(dot)
					}
					ForEach(inputVM.dots) { dot in
						Path { path in
							if let lineEnd = dot.correspondingLineEnd {
								path.move(to: dot.getCGPoint())
								path.addLine(to: lineEnd.getCGPoint())
							}
						}
						.stroke(
							Color.black,
							style: .init(
								lineWidth: 2,
								lineCap: .round,
								lineJoin: .round,
								miterLimit: 10,
								dash: [],
								dashPhase: 0)
						)
					}
				}
			)
		}
    }
}

private struct CoordinateSegment: Shape {
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let width = rect.width
		let widthOfSubSegment = width / 10
		
		for i in 1..<10 {
			path.move(to: CGPoint(x: widthOfSubSegment * CGFloat(i) + 1, y: 0))
			path.addLine(to: CGPoint(x: widthOfSubSegment * CGFloat(i) + 1, y: width))
		}
		
		for i in 0..<10 {
			path.move(to: CGPoint(x: 0, y: widthOfSubSegment * CGFloat(i) + 1))
			path.addLine(to: CGPoint(x: width, y: widthOfSubSegment * CGFloat(i) + 1))
		}
		
		return path
	}
}

private struct DotView: View {
	
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

struct CoordinateSystemView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemView()
    }
}
