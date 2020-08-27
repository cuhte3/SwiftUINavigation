//
//  ActivityConfigurator.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityConfigurator: NavigationConfigurator {
	func configure(_ screen: Screen) -> ViewElement? {
		 switch screen {
			case .acivityLikes:
				return activityLikes(screen)
			case .activityProfile:
				return activityProfiles(screen)
			default:
				return nil
		 }
	}
	
	private func activityLikes(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(ActivityLikes().animation(transitionAnimation))
		)
	}
	
	private func activityProfiles(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(ActivityProfile().animation(transitionAnimation))
		)
	}
}
