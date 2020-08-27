//
//  MainView.swift
//  SampleNavigationApp
//
//  Created by Farid on 24.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct MainView: View {
	@State var index: Int = 1
	
	var body: some View {
		TabView(selection: $index) {
			FeedRootView()
				.tabItem {
						Image(systemName: "00.circle")
						Text("Feed")
				}.tag(0)

			DashboardView()
				.tabItem {
						Image(systemName: "01.circle")
						Text("Dashboard")
				}.tag(1)
			
			ActivitiesRoot()
				.tabItem {
						Image(systemName: "02.circle")
						Text("Activities")
				}.tag(2)
		}
	}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
