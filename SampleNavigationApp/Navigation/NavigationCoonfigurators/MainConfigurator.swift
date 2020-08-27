//
//  ActivityConfigurator.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import SwiftUI

struct MainConfigurator: NavigationConfigurator {
  func configure(_ screen: Screen) -> ViewElement? {
    switch screen {
      case .main:
        return main(screen)
      case .landing:
        return landing(screen)
      case .phoneNumber:
        return phoneNumber(screen)
      case .usernameSignUp:
        return usernameSignUp(screen)
      case .verification:
        return verification(screen)
			default:
				return nil
		}
	}
	
	private func main(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(MainView().animation(transitionAnimation))
		)
	}
  
  private func landing(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(LandingView()),
			pushTransition: .asymmetric(insertion: .opacity, removal: .move(edge: .leading))
		)
  }
  
  private func usernameSignUp(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(UsernameView().animation(transitionAnimation))
		)
	}
			
  private func phoneNumber(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(PhoneNumberView().animation(transitionAnimation))
		)
  }
  
  private func verification(_ screen: Screen) -> ViewElement {
		ViewElement(
			id: screen,
			wrappedElement: AnyView(CodeConfirmationView().animation(transitionAnimation))
		)
	}
}
