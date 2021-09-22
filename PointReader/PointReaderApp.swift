//
//  PointReaderApp.swift
//  PointReader
//
//  Created by Nikita Semenov on 19.09.2021.
//

import SwiftUI

@main
struct PointReaderApp: App {
	
	@StateObject var inputVM = InputViewModel()

    var body: some Scene {
		WindowGroup {
			AppView()
				.frame(maxWidth: NSScreen.main?.frame.width, minHeight: coordinateSpaceHeight + 5)
				.environmentObject(inputVM)
		}
		.commands {
			SidebarCommands()
		}
    }
}

fileprivate struct AppView: View {
	var body: some View {
		NavigationView {
			InspectorView()
				.frame(minWidth: 300, maxWidth: NSScreen.main!.frame.width - coordinateSpaceHeight + 1)
				.toolbar {
					Button(action: toggleSidebar) {
						Image(systemName: "sidebar.left")
							.help("Toggle Sidebar")
					}
					.keyboardShortcut(KeyEquivalent("C"))
				}
			
			CoordinateSystemView()
				.frame(width: coordinateSpaceHeight + 1, height: coordinateSpaceHeight + 1)
				.navigationViewStyle(DefaultNavigationViewStyle())
		}
	}
	
	private func toggleSidebar() {
		NSApp.keyWindow?.firstResponder?
			.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
	}
}
