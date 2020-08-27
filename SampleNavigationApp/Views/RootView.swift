//
//  RootView.swift
//  KnowApp
//
//  Created by Edward Psyk on 4/2/20.
//  Copyright © 2020 Know. All rights reserved.
//

import SwiftUI
import Combine
import Resolver

class RootViewModel: ObservableObject {
	private var hasUser: Bool = false
	private var cancellables = Set<AnyCancellable>()
	private var mainNavigation: NavigationCoordinator
	private var activitiesNavigation: NavigationCoordinator
	
  @Published var currentView: ViewElement? = nil
	
	var currentTransition: AnyTransition {
		guard let view = currentView else { return .opacity }
		switch mainNavigation.navStack.navigationType {
		case .pop:
			return view.popTransition
		case .push:
			return view.pushTransition
		}
	}
		
	init() {
		mainNavigation = Resolver.resolve()
		activitiesNavigation = Resolver.resolve(name: "activities navigation")
		
		if hasUser {
			mainNavigation.push(.landing)
			mainNavigation.push(.main)
    } else {
			mainNavigation.push(.landing)
    }
		
		activitiesNavigation.navStack.$currentView
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { view in
				self.currentView = view
			})
			.store(in: &cancellables)
		
		mainNavigation.navStack.$currentView
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { view in
				self.currentView = view
			})
			.store(in: &cancellables)
	}
}

struct RootView: View {
  @State private var currentView: ViewElement? = nil
	@ObservedObject private var viewModel = RootViewModel()
	
  var body: some View {
		guard let view = viewModel.currentView else { return AnyView(EmptyView()) }
		return AnyView(
			VStack {
				view.wrappedElement
					.id(view.id)
					.transition(viewModel.currentTransition)
			}
			.onReceive(viewModel.$currentView) { view in
				self.currentView = view
			}
		)
	}
}
