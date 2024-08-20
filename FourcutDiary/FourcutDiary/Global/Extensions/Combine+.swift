//
//  Combine+.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import Combine
import UIKit

extension UIControl {
	func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
		return UIControl.EventPublisher(control: self, event: event)
	}
	
	// Publisher
	struct EventPublisher: Publisher {
		typealias Output = UIControl
		typealias Failure = Never
		
		let control: UIControl
		let event: UIControl.Event
		
		func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
			let subscription = EventSubscriber(control: control, event: event, subscriber: subscriber)
			subscriber.receive(subscription: subscription)
		}
	}
	
	// Subscription
	fileprivate class EventSubscriber<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {
		
		let control: UIControl
		let event: UIControl.Event
		var subscriber: EventSubscriber?
		
		init(control: UIControl, event: UIControl.Event, subscriber: EventSubscriber? = nil) {
			self.control = control
			self.event = event
			self.subscriber = subscriber
		}
		
		func request(_ demand: Subscribers.Demand) { }
		
		func cancel() {
			subscriber = nil
			control.removeTarget(self, action: #selector(eventDidOccur), for: event)
		}
		
		@objc func eventDidOccur() {
			_ = subscriber?.receive(control)
		}
	}
}

extension UIButton {
	var tapPublisher: AnyPublisher<Void, Never> {
		controlPublisher(for: .touchUpInside)
			.map { _ in }
			.eraseToAnyPublisher()
	}
}
