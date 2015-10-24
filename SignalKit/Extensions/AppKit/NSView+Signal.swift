//
//  NSView+Signal.swift
//  SignalKit
//
//  Created by Valentin Shergin on 10/24/15.
//  Copyright © 2015 Valentin Shergin. All rights reserved.
//

import AppKit

final class NSTrackingAreaOwner: Disposable {

	private weak var signal: Signal<Bool>?
	private var view: NSView
	private var trackingArea: NSTrackingArea!

	init(signal: Signal<Bool>, view: NSView) {

		self.view = view
		self.signal = signal

		self.trackingArea = NSTrackingArea(
			rect: CGRectZero,
			options: [.MouseEnteredAndExited, .ActiveAlways, .InVisibleRect],
			owner: self,
			userInfo: nil
		)

		view.addTrackingArea(trackingArea)
	}

	func dispose() {

		self.view.removeTrackingArea(self.trackingArea)
	}

	dynamic func mouseEntered(event: NSEvent) {

		self.signal?.dispatch(true)
	}

	dynamic func mouseExited(event: NSEvent) {

		self.signal?.dispatch(false)
	}
}

extension SignalEventType where Sender: NSView {

	/**
	Observe the view for mouse entered and exited events

	*/
	public func mouseHover() -> Signal<Bool> {

		let signal = Signal<Bool>()

		signal.disposableSource = NSTrackingAreaOwner(signal: signal, view: sender)

		return signal
	}
}
