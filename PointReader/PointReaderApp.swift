//
//  PointReaderApp.swift
//  PointReader
//
//  Created by Nikita Semenov on 19.09.2021.
//

import SwiftUI

@main
struct PointReaderApp: App {
    var body: some Scene {
		WindowGroup {
			AppView()
		}
		.windowToolbarStyle(DefaultWindowToolbarStyle())
		.commands {
			SidebarCommands()
		}
    }
}

struct AppView: View {
	var body: some View {
		NavigationView {
			InputBarView()
			
			CoordinateSystemView()
		}
	}
}
