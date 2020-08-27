//
//  AppDelegate+Injection.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
	public static func registerAllServices() {
		register { MainCoordinator() as NavigationCoordinator }.scope(application)
		register(name: "activities navigation") { ActivityCoordinator() as NavigationCoordinator }.scope(application)
	}
}
