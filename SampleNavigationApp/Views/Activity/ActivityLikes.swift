//
//  ActivityLikes.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct ActivityLikes: View {
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
				self.navigation.push(.activityProfile)
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
