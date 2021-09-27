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
					Circle()
						.fill(Color(dot.color))
						.frame(width: 13, height: 13)
					
					Text("Dot: \(dot.name)")
						.font(.title2)
						.fixedSize()
				}
				.padding(.trailing, 10)
				
				Text("(\(dot.x, specifier: "%.2f"); \(dot.y, specifier: "%.2f"))")
					.font(.title2)
					.fixedSize()
				
				Spacer()
			}
		}
	}
		
	var body: some View {
		List {
			ForEach(inputVM.objects, id: \.id) { obj in
				switch obj {
					case let dot as Dot:
						DotDescriptionRow(dot: dot)
							.contextMenu {
								Button(action: {
									inputVM.onDelete(object: dot)
								}, label: {
									Text("Delete")
								})
							}
							.padding(.horizontal, 2)
							.padding(.vertical, 5)
							.clipShape(RoundedRectangle(cornerRadius: 8))
					default:
						EmptyView()
				}
				
				Divider()
			}
		}
	}
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
