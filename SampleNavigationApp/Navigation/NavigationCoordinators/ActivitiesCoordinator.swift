//
//  ActivitiesCoordinator.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import Combine

class ActivityCoordinator: ObservableObject, NavigationCoordinator {
	@Published var navStack: NavigationStack
	private var anyCancellables = Set<AnyCancellable>()
	
	init() {
    self.navStack = NavigationStack(easing: transitionAnimation)
  }
	
	func push(_ screen: Screen) {
		 switch screen {
			case .acivityLikes:
				activityLikes()
			case .activityProfile:
				activityProfiles()
			default:
				break
		 }
	}
	
	private func activityLikes() {
		navStack.push(
			ActivityLikes().animation(transitionAnimation),
			withId: Screen.acivityLikes
		)
	}
	
	private func activityProfiles() {
		navStack.push(
			ActivityProfile().animation(transitionAnimation),
			withId: Screen.activityProfile
		)
	}
}
