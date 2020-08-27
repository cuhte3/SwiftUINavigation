//
//  FeedView.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct FeedRootView: View {
	let navigation = NavigationStackView<FeedView>(configurator: FeedConfigurator(), rootView: FeedView())
	
	var body: some View {
		navigation
	}
}

struct FeedView: View {
	@EnvironmentObject var navigation: NavigationStack

	var body: some View {
		VStack {
			Spacer()
			Text("Feed")
			Spacer()
			Button(action: {
				self.navigation.push(.feedEvent)
			}, label: {
				Text("Next")
			})
				.padding(.bottom, 12)
		}
	}
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
