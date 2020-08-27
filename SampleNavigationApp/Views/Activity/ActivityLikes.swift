//
//  ActivityLikes.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI
import Resolver

struct ActivityLikes: View {
//	private var navigation: NavigationCoordinator = Resolver.resolve(name: "activities navigation")
//	private var mainNavigation: NavigationCoordinator = Resolver.resolve()
	@EnvironmentObject var navigation: NavigationStack
	
	var body: some View {
		VStack {
			Button(action: {
				self.navigation.pop()
			}, label: {
				Text("Back")
			})
			Spacer()
			Text("Activity Likes")
			Spacer()
			Button(action: {
				self.navigation.push(ActivityProfile(), withId: .activityProfile)
			}, label: {
				Text("Next")
			})
				.padding(.bottom, 12)
		}
	}
}

struct ActivityLikes_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLikes()
    }
}
