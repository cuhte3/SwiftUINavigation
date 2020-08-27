//
//  MainCoordinator.swift
//  KnowApp
//
//  Created by Edward Psyk on 4/2/20.
//  Copyright © 2020 Know. All rights reserved.
//

import Foundation
import Combine

class MainCoordinator: ObservableObject, NavigationCoordinator {
  @Published var navStack: NavigationStack
  private var anyCancellables = Set<AnyCancellable>()
  
  init() {
    self.navStack = NavigationStack(easing: transitionAnimation)
  }
  
  func push(_ screen: Screen) {
    switch screen {
      case .main:
        main()
      case .landing:
        landing()
      case .phoneNumber:
        phoneNumber()
      case .usernameSignUp:
        usernameSignUp()
      case .verification:
        verification()
      case .pop:
        pop()
			default:
				break
		}
	}
  
  private func landing() {
    navStack.push(
			LandingView().animation(transitionAnimation),
			withId: Screen.landing,
			pushTransition: .asymmetric(insertion: .opacity, removal: .move(edge: .leading))
		)
  }
  
  private func main() {
    navStack.push(
			MainView().animation(transitionAnimation),
			withId: Screen.main,
			pushTransition: .opacity,
			popTransition: .opacity
		)
  }
  
  private func usernameSignUp() {
		navStack.push(
			UsernameView().animation(transitionAnimation),
			withId: Screen.usernameSignUp
		)
  }
			
  private func phoneNumber() {
    navStack.push(
			PhoneNumberView().animation(transitionAnimation),
			withId: Screen.phoneNumber
		)
  }
  
  private func verification() {
    navStack.push(
			CodeConfirmationView().animation(transitionAnimation),
			withId: Screen.verification
		)
  }
}
