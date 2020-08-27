//
//  Screens.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation

public enum Screen: String {
	//MARK: MainCoordinator
  case landing = "Main.Landing"
  case usernameSignUp = "Main.Username"
  case phoneNumber = "Main.PhoneNumber"
  case verification = "Main.Verification"
  case main = "Main"
	//MARK: DashboardCoordinator
	case activities = "Activities"
	case acivityLikes = "Activity.Likes"
	case activityProfile = "Activity.Profile"
	//MARK: FeedConfigurator
	case feedEvent = "Feed.Event"
}
