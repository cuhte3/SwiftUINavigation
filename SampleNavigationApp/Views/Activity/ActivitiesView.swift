//
//  ActivitiesView.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct ActivitiesRoot: View {
	let navigationStack = NavigationStackView<ActivitiesView>(configurator: ActivityConfigurator(), rootView: ActivitiesView())

	var body: some View {
		navigationStack
	}
}

struct ActivitiesView: View {
	@EnvironmentObject var navigation: NavigationStack
		
	var body: some View {
		VStack {
			Spacer()
			Text("Activities")
			Spacer()
			Button(action: {
				self.navigation.push(.acivityLikes)
			}, label: {
				Text("Next")
			})
				.padding(.bottom, 12)
		}
	}
}

struct ActivitiesView_Previews: PreviewProvider {
	static var previews: some View {
		ActivitiesView()
	}
}
