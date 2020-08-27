//
//  PhoneNumberView.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

struct PhoneNumberView: View {
	@EnvironmentObject var navigation: NavigationStack

	var body: some View {
		VStack {
			Button(action: {
				self.navigation.pop()
			}, label: {
				Text("Back")
			})
			Spacer()
			Text("PhoneNumber")
			Spacer()
			Button(action: {
				self.navigation.push(.verification)
			}, label: {
				Text("Next")
			})
		}
	}
}

struct PhoneNumberView_Previews: PreviewProvider {
	static var previews: some View {
			PhoneNumberView()
	}
}
