//
//  InputLineView.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import SwiftUI

struct InputLineView: View {
	
	@EnvironmentObject var inputVM: InputViewModel
	
	var body: some View {
		VStack {
			HStack {
				Text("Connect the dots")
					.fixedSize()
				
				Spacer()
				
				
			}
			
			HStack {
				Spacer()
				
				Button("Add Line") {
					withAnimation(.easeOut) {
						inputVM.onAddLine()
					}
				}
				.keyboardShortcut(.defaultAction)
				.disabled(true)
			}
		}
	}
}

struct InputLineView_Previews: PreviewProvider {
    static var previews: some View {
        InputLineView()
    }
}
