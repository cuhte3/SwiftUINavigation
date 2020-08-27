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
  case landing = "Landing"
  case usernameSignUp = "Username SignUp"
  case phoneNumber = "Phone Number"
  case verification = "Varification"
  case main = "Main"
  case pop = "Go Back"
	//MARK: DashboardCoordinator
	case activities = "Activities"
	case acivityLikes = "Activity Likes"
	case activityProfile = "ActivityProfile"
}
