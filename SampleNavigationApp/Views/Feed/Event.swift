//
//  Event.swift
//  SampleNavigationApp
//
//  Created by Farid on 27.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct Event: View {
	@EnvironmentObject var navigation: NavigationStack

	var body: some View {
		VStack {
			Button(action: {
				self.navigation.pop()
			}, label: {
				Text("Back")
			})
			Spacer()
			Text("Event")
			Spacer()
		}
	}
}

struct Event_Previews: PreviewProvider {
    static var previews: some View {
        Event()
    }
}
