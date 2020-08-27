//
//  LandingView.swift
//  SampleNavigationApp
//
//  Created by Farid on 24.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI
import Resolver

struct LandingView: View {
	private var navigation: NavigationCoordinator = Resolver.resolve()
	
	var body: some View {
		VStack {
			Spacer()
			Text("LandingView")
			Spacer()
			Button(action: {
				self.navigation.push(.usernameSignUp)
			}, label: {
				Text("Next")
			})
		}
	}
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
