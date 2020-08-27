//
//  RootView.swift
//  KnowApp
//
//  Created by Edward Psyk on 4/2/20.
//  Copyright © 2020 Know. All rights reserved.
//

import SwiftUI
import Combine

struct RootView: View {
	let navigation = NavigationStackView<LandingView>(configurator: MainConfigurator(), rootView: LandingView())
	
  var body: some View {
		navigation
	}
}
