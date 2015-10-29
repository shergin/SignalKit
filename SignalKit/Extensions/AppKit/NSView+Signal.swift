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
	private weak var view: NSView?
	private var trackingArea: NSTrackingArea!

	init(signal: Signal<Bool>, view: NSView) {

		self.view = view
		self.signal = signal

		let hovered = self.mouseInView()

		self.trackingArea = NSTrackingArea(
			rect: CGRectZero,
			options: [.MouseEnteredAndExited, .ActiveAlways, .InVisibleRect, hovered ? .AssumeInside : NSTrackingAreaOptions(rawValue: 0)],
			owner: self,
			userInfo: nil
		)

		view.addTrackingArea(trackingArea)

		self.signal?.dispatch(hovered)
	}

	func dispose() {

		self.view?.removeTrackingArea(self.trackingArea)
	}

	dynamic func mouseEntered(event: NSEvent) {

		self.signal?.dispatch(true)
	}

	dynamic func mouseExited(event: NSEvent) {

		self.signal?.dispatch(false)
	}

	private func mouseInView() -> Bool {
		guard self.view?.window != nil else {
			return false
		}

		let view = self.view!

		let mouseLocationRelativeToScreen = CGRect(origin: NSEvent.mouseLocation(), size: NSZeroSize)
		let mouseLocationRelativeToWindow = view.window!.convertRectFromScreen(mouseLocationRelativeToScreen)
		let mouseLocationRelativeToView = view.convertRect(mouseLocationRelativeToWindow, fromView: nil)
		return CGRectContainsRect(view.bounds, mouseLocationRelativeToView)
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
