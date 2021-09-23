//
//  MouseLocationTracker.swift
//  MouseLocationTracker
//
//  Created by Nikita Semenov on 22.09.2021.
//

import SwiftUI

extension View {
	func trackingMouseLocation(onTrack: @escaping ((CGPoint) -> Void)) -> some View {
		MouseLocationTracker(onTrack: onTrack) { self }
	}
}

// MARK: - MouseLocationTracker
fileprivate struct MouseLocationTracker<Content: View>: View {
	let onTrack: ((CGPoint) -> Void)
	let content: () -> Content
	
	init(onTrack: @escaping ((CGPoint) -> Void), @ViewBuilder content: @escaping () -> Content) {
		self.onTrack = onTrack
		self.content = content
	}
	
	var body: some View {
		TrackingAreaRepresentable(onTrack: onTrack, content: content())
	}
}

// MARK: - TrackingAreaRepresentable
fileprivate struct TrackingAreaRepresentable<Content: View>: NSViewRepresentable {
	
	let onTrack: ((CGPoint) -> Void)
	let content: Content
	
	func makeNSView(context: Context) -> NSHostingView<Content> {
		TrackingNSHostingView(onTrack: onTrack, rootView: content)
	}
	
	func updateNSView(_ nsView: NSViewType, context: Context) {
	}
}

// MARK: - TrackingNSHostingView
fileprivate final class TrackingNSHostingView<Content>: NSHostingView<Content> where Content: View {
	
	let onTrack: ((CGPoint) -> Void)
	
	init(onTrack: @escaping ((CGPoint) -> Void), rootView: Content) {
		self.onTrack = onTrack
		
		super.init(rootView: rootView)
		
		setUpTrackingArea()
	}
	
	required init(rootView: Content) {
		fatalError("init(rootView:) has not been implemented")
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUpTrackingArea() {
		let options: NSTrackingArea.Options = [.mouseMoved, .activeAlways, .inVisibleRect]
		addTrackingArea(NSTrackingArea(rect: .zero, options: options, owner: self, userInfo: nil))
	}
	
	override func mouseMoved(with event: NSEvent) {
		onTrack(convert(event.locationInWindow, from: nil))
	}
}
