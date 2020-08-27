//
//  FeedConfigurator.swift
//  SampleNavigationApp
//
//  Created by Farid on 27.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import SwiftUI

class FeedConfigurator: ObservableObject, NavigationConfigurator {
	func configure(_ screen: Screen) -> ViewElement? {
		 switch screen {
			case .feedEvent:
				return feedEvent(screen)
			default:
				return nil
		 }
	}
	
	private func feedEvent(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(Event().animation(transitionAnimation))
		)
	}
	
	private func activityProfiles(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(ActivityProfile().animation(transitionAnimation))
		)
	}
}
