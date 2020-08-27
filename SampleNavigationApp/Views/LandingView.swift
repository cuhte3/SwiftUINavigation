//
//  LandingView.swift
//  SampleNavigationApp
//
//  Created by Farid on 24.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct LandingView: View {
	@EnvironmentObject var navigation: NavigationStack
	private var isLoggedIn: Bool = true
		
	init() {
		isLoggedIn = false
	}
	
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
		.onAppear {
			if self.isLoggedIn {
				self.navigation.push(.main)
			}
		}
	}
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
