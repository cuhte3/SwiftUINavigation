//
//  NavigationCoordinator.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import SwiftUI

let transitionAnimation: Animation = .easeInOut(duration: 0.3)

protocol NavigationCoordinator {
	var navStack: NavigationStack { get }
	func push(_ screen: Screen)
	func pop(to: Screen)
	func pop()
}

extension NavigationCoordinator {
	func pop(to: Screen) {
		navStack.pop(to: .view(withId: to))
	}
	
	func pop() {
		navStack.pop()
	}
}
