//
//  DashboardView.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI
import Resolver

struct DashboardView: View {
	private var navigation: NavigationCoordinator = Resolver.resolve()

	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.navigation.pop(to: .landing)
				}) {
					Text("Logout")
				}
				.padding(.trailing, 20)
			}
			Spacer ()
			Text("Dashboard")
			Spacer()
		}
	}
}

struct DashboardView_Previews: PreviewProvider {
	static var previews: some View {
			DashboardView()
	}
}
