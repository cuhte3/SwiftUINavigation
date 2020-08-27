//
//  DashboardView.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
	@EnvironmentObject var navigation: NavigationStack

	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.navigation.popToRoot()
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
