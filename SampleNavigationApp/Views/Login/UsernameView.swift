//
//  UsernameView.swift
//  SampleNavigationApp
//
//  Created by Farid on 24.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI

class UsernameViewModel {
	init() {
		print("UsernameViewModel init")
	}
	deinit {
		print("UsernameViewModel deinit")
	}
}

struct UsernameView: View {
//	private var viewModel = UsernameViewModel()
	@EnvironmentObject var navigation: NavigationStack

	var body: some View {
		VStack {
			Button(action: {
				self.navigation.pop()
			}, label: {
				Text("Back")
			})
			Spacer()
			Text("Username")
			Spacer()
			Button(action: {
				self.navigation.push(.phoneNumber)
			}, label: {
				Text("Next")
			})
		}
	}
}

struct UsernameView_Previews: PreviewProvider {
	static var previews: some View {
			UsernameView()
	}
}
