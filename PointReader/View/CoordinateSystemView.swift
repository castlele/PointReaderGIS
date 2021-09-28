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
	@StateObject var geometryVM = GeometryViewModel()
		
	private let height = coordinateSpaceHeight
	
    var body: some View {
		ZStack {
			Color.white
			
			// MARK: - Coordinate System
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
			.trackingMouseLocation { location in
				geometryVM.convertToCartesian(point: location)
				
			}
			.frame(width: height, height: height)
			.overlay(
				ZStack {
					Path { path in
						// MARK: - OX and OY
						path.move(to: CGPoint(x: 0, y: height / 2))
						path.addLine(to: CGPoint(x: height, y: height / 2))
						
						path.move(to: CGPoint(x: height / 2, y: 0))
						path.addLine(to: CGPoint(x: height / 2, y: height))
					}
					.stroke(Color.black, lineWidth: 2)
					
					// MARK: - Coordinates bar
					VStack {
						Spacer()
						
						HStack {
							Spacer()
							
							Text("\(geometryVM.mouseLocation.x, specifier: "%.2f"); \(geometryVM.mouseLocation.y, specifier: "%.2f")")
								.foregroundColor(.white)
								.padding(5)
								.background(Color.secondary)
								.clipShape(RoundedRectangle(cornerRadius: 5))
								.padding()
						}
					}
					
					if inputVM.addingMode != .none {
						GeometryReader { geometry in
							
							//MARK: - InputDotCoordinatesView
							inputVM.inputView
								.offset(x: geometry.size.width / 2 - 150, y: geometry.size.height * 1/3 )
						}
					}
					
					GeometryReader { _ in
						// MARK: - Geometry objects showing
						ForEach(inputVM.objects, id: \.id) { obj in
							GeometryViewFactory.makeView(object: obj)
						}
					}
				}
			)
			// MARK: - Tool bar
			.toolbar {
				Button(action: {
					inputVM.addingMode = inputVM.addingMode == .dot ? .none : .dot
					
				}, label: {
					Image(systemName: "dot.squareshape.split.2x2")
						.foregroundColor(inputVM.addingMode == .dot ? .accentColor : nil)
						.help("Add dot")
				})
				.keyboardShortcut("d", modifiers: [.shift, .option])
				
				Button(action: {
					inputVM.addingMode = inputVM.addingMode == .line ? .none : .line
					
				}, label: {
					Image(systemName: "arrow.up.and.down.square")
						.foregroundColor(inputVM.addingMode == .line ? .accentColor : nil)
						.help("Add line")
				})
				.keyboardShortcut("l", modifiers: [.shift, .option])
			}
		}
		// MARK: - Tap to add an geometry object
		.onTapGesture {
			geometryVM.setLastTapped()
			inputVM.tapToAddGeometryObject(lastTapped: $geometryVM.lastTapped)
		}
    }
}

// MARK: - CoordinateSegment View
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

struct CoordinateSystemView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemView()
    }
}
