//
//  ListOfGeometryObjects.swift
//  PointReader
//
//  Created by Nikita Semenov on 01.10.2021.
//

import SwiftUI

// MARK: - ListOfGeometryObjects View
struct ListOfGeometryObjects: View {
	
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
	
	// MARK: - List of Geometry objects Body
	var body: some View {
		VStack {
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
					.padding(.horizontal, 2)
					.overlay(
						Group {
							if obj.isSelected {
								Image(systemName: "checkmark.circle.fill")
									.resizable()
									.scaledToFit()
									.frame(width: 20, height: 20)
									.foregroundColor(.green)
							} else {
								EmptyView()
							}
						}
						
						, alignment: .topTrailing
					)
					.contextMenu {
						Button {
							inputVM.selectObject(obj)
						} label: {
							Text(obj.isSelected ? "Deselect" : "Select")
						}
						
						Button {
							inputVM.onDelete(object: obj)
						} label: {
							Text("Delete")
						}
					}
					
					Divider()
				}
			}
			
			Rectangle()
				.fill(Color.primary.opacity(0.5))
				.frame(height: 50)
				.clipShape(RoundedCorner(cornerHeight: 8))
				.overlay(
					Button {
						inputVM.merge()
					} label: {
						Text(inputVM.determineMergingType())
					}
					.opacity(inputVM.determineMergingType().isEmpty ? 0 : 1)
				)
		}
	}
}

fileprivate struct RoundedCorner: Shape {
	var cornerWidth: CGFloat = 0
	var cornerHeight: CGFloat = 0
	
	func path(in rect: CGRect) -> Path {
		let path = CGMutablePath(roundedRect: rect, cornerWidth: cornerWidth, cornerHeight: cornerHeight, transform: nil)
		return Path(path)
		
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
