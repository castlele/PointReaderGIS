//
//  InspectorView.swift
//  PointReader
//
//  Created by Nikita Semenov on 19.09.2021.
//

import SwiftUI

// MARK: - InspectorView
struct InspectorView: View, Equatable {
	
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
				.frame(minHeight: 400)
				.background(Color.white)
				.clipShape(RoundedRectangle(cornerRadius: 8))
		}
    }
	
	static func == (lhs: InspectorView, rhs: InspectorView) -> Bool {
		lhs.inputVM.objects.map { $0.id } == rhs.inputVM.objects.map { $0.id }
	}
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
