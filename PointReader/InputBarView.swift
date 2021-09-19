//
//  InputBarView.swift
//  PointReader
//
//  Created by Nikita Semenov on 19.09.2021.
//

import SwiftUI

struct InputBarView: View {
    var body: some View {
		List {
			Text("Hello")
		}.listStyle(SidebarListStyle())
    }
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
        InputBarView()
    }
}
