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
	
    var body: some View {
		List {
			Section(header: Text("Dot")) {
				InputDotView(controllsType: .default)
					.padding(.horizontal)
					.animation(.easeOut)
			}
			
			Section(header: Text("Line")) {
				InputLineView()
					.padding(.horizontal)
					.animation(.easeOut)
			}
						
			Spacer()
			
			ListOfGeometryObjects()
				.frame(minHeight: 500)
				.background(Color.white)
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
    }
}

// MARK: - ListOfGeometryObjects
fileprivate struct ListOfGeometryObjects: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	
	// MARK: - DotDescriptionRow
	fileprivate struct DotDescriptionRow: View {
		
		let dot: Dot
		
		var body: some View {
			HStack {
				Group {
					GeometryObjectTypeView(type: .dot(dot))
					
					Text("\(dot.name)")
						+
					Text("(\(dot.x, specifier: "%.2f"); \(dot.y, specifier: "%.2f"))")
				}
				.font(.title2)
				.fixedSize()
				.padding(5)
				
				Spacer()
			}
		}
	}
	
	// MARK: - LineDescriptionRow
	fileprivate struct LineDescriptionRow: View {
		
		let line: Line
		
		var body: some View {
			HStack {
				Group {
					GeometryObjectTypeView(type: .line(line))
					
					Text("\(line.name)")
					+
					Text("(\(line.endA.x, specifier: "%.2f"); \(line.endA.y, specifier: "%.2f"))")
					+
					Text(" - ")
					+
					Text("(\(line.endB.x, specifier: "%.2f"); \(line.endB.y, specifier: "%.2f"))")
				}
				.font(.title2)
				.fixedSize()
				.padding(.horizontal, 2)
				
				Spacer()
			}
			.frame(minHeight: 40)
		}
	}
	
	// MARK: - List of Geometry objects
	var body: some View {
		List {
			ForEach(inputVM.objects, id: \.id) { obj in
				Group {
					switch obj {
						case let dot as Dot:
							DotDescriptionRow(dot: dot)
							
							
						case let line as Line:
							LineDescriptionRow(line: line)
							
						default:
							EmptyView()
					}
				}
				.contextMenu {
					Button(action: {
						inputVM.onDelete(object: obj)
					}, label: {
						Text("Delete")
					})
				}
				.padding(.horizontal, 2)
				.clipShape(RoundedRectangle(cornerRadius: 8))
				
				Divider()
			}
		}
	}
}

// MARK: - Icons of geometry objects
fileprivate struct GeometryObjectTypeView: View {
	
	enum IconObjectType {
		case dot(Dot)
		case line(Line)
	}
	
	var type: IconObjectType
	var width = CGFloat(40)
	var height = CGFloat(40)
	var dotRadius = CGFloat(12)
	
	var body: some View {
		Rectangle()
			.fill(Color.clear)
			.frame(width: width, height: height)
			.overlay(icon)
	}
	
	private var icon: some View {
		Group {
			switch type {
				case .dot:
					dotIcon
				case .line:
					lineIcon
			}
		}
	}
	
	// MARK: - Icons
	private var dotIcon: some View {
		guard case let .dot(dot) = type else { fatalError("Invalid property icon switch declaration") }
		
		return ZStack {
			Circle()
				.fill(Color(dot.color))
				.frame(width: dotRadius, height: dotRadius)
		}
	}
	
	private var lineIcon: some View {
		guard case let .line(line) = type else { fatalError("Invalid property icon switch declaration") }
		let offset = dotRadius / 2
		let widthQuarter = width / 4
		let heightQuarter = height / 4
		let dotA = CGPoint(x: widthQuarter - offset, y: height - heightQuarter + offset)
		let dotB = CGPoint(x: width - widthQuarter + offset, y: heightQuarter - offset)
		
		return ZStack {
			
			Path { path in
				path.move(to: dotA)
				path.addLine(to: dotB)
			}
			.stroke(Color.black, style: .init(lineWidth: 3, lineCap: .round, lineJoin: .miter, miterLimit: 0, dash: [], dashPhase: 0))
			.overlay(
				GeometryReader { _ in
					Circle()
						.fill(Color(line.endA.color))
						.frame(width: dotRadius, height: dotRadius)
						.offset(x: 0, y: height - dotRadius)
					
					Circle()
						.fill(Color(line.endB.color))
						.frame(width: dotRadius, height: dotRadius)
						.offset(x: width - dotRadius, y: 0)
				}
			)
		}
	}
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
