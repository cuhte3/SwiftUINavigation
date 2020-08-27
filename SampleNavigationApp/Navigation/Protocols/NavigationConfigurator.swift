//
//  NavigationConfigurator.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import Foundation
import SwiftUI

let transitionAnimation: Animation = .easeInOut(duration: 0.3)

protocol NavigationConfigurator {
	func configure(_ screen: Screen) -> ViewElement?
}
