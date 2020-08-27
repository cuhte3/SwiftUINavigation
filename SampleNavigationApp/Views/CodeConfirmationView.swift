//
//  CodeConfirmationView.swift
//  SampleNavigationApp
//
//  Created by Farid on 26.08.2020.
//  Copyright © 2020 SintezLab. All rights reserved.
//

import SwiftUI
import Resolver

struct CodeConfirmationView: View {
	private var navigation: NavigationCoordinator = Resolver.resolve()

	var body: some View {
		VStack {
			Button(action: {
				self.navigation.pop()
			}, label: {
				Text("Back")
			})
			Spacer()
			Text("Verification")
			Spacer()
			Button(action: {
				self.navigation.push(.main)
			}, label: {
				Text("Next")
			})
		}
	}
}

struct CodeConfirmationView_Previews: PreviewProvider {
	static var previews: some View {
		CodeConfirmationView()
	}
}
