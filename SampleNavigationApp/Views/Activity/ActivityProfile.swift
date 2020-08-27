//
//  ActivityProfile.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI
import Resolver

struct ActivityProfile: View {
	@EnvironmentObject var navigation: NavigationStack
	
	var body: some View {
		VStack {
			Button(action: {
				self.navigation.pop()
			}, label: {
				Text("Back")
			})
			Spacer()
			Text("Profile")
			Spacer()
		}
	}
}

struct ActivityProfile_Previews: PreviewProvider {
	static var previews: some View {
		ActivityProfile()
	}
}
