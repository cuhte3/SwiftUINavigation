//
//  NavigationStack.swift
//  KnowApp
//
//  Created by Edward Psyk on 3/31/20.
//  Copyright © 2020 Know. All rights reserved.
//

import Combine
import SwiftUI

/// The transition type for the whole NavigationStackView
public enum NavigationTransition {
  case none
  case `default`
  case custom(AnyTransition)
  
  static var defaultTransitions: (push: AnyTransition, pop: AnyTransition) {
    let pushTrans = AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    let popTrans = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
    return (pushTrans, popTrans)
  }
}

enum NavigationType {
  case push
  case pop
}

public enum PopDestination {
  case previous
  case root
  case view(withId: Screen)
}

public class NavigationStack: ObservableObject {
	var navigationType = NavigationType.push
  private let easing: Animation
	private let configurator: NavigationConfigurator
  
	init(configurator: NavigationConfigurator, easing: Animation) {
		self.configurator = configurator
    self.easing = easing
  }
  
  private var viewStack = ViewStack() {
    didSet {
      currentView = viewStack.peek()
    }
  }
  
  @Published var currentView: ViewElement?

	func push(_ sceen: Screen) {
		if let element = configurator.configure(sceen) {
			withAnimation(easing) {
				navigationType = .push
				viewStack.push(element)
			}
		}
	}
	
	func pop(to: PopDestination = .previous) {
    withAnimation(easing) {
      navigationType = .pop
      switch to {
        case .root:
          viewStack.popToRoot()
        case .view(let viewId):
          viewStack.popToView(withId: viewId)
        default:
          viewStack.popToPrevious()
      }
    }
  }
	
	func popToRoot() {
    viewStack.popToRoot()
  }
  
  //the actual stack
  private struct ViewStack {
    private var views = [ViewElement]()
    
    func peek() -> ViewElement? {
      views.last
    }
    
    mutating func push(_ element: ViewElement) {
      if indexForView(withId: element.id) != nil {
        self.popToView(withId: element.id)
      }
      views.append(element)
    }
    
    mutating func popToPrevious() {
      _ = views.popLast()
    }
    
    mutating func popToView(withId identifier: Screen) {
      guard let viewIndex = indexForView(withId: identifier) else {
        fatalError("Identifier \"\(identifier)\" not found. You are trying to pop to a view that doesn't exist.")
      }
      views.removeLast(views.count - (viewIndex + 1))
    }
    
    mutating func popToRoot() {
      views.removeAll()
    }
    
    private func indexForView(withId identifier: Screen) -> Int? {
      views.firstIndex {
        $0.id == identifier
      }
    }
  }
}

//the actual element in the stack
struct ViewElement: Identifiable, Equatable {
  let id: Screen
  let wrappedElement: AnyView
  let pushTransition: AnyTransition
  let popTransition: AnyTransition
    
  init(id: Screen, wrappedElement: AnyView, pushTransition: AnyTransition? = nil, popTransition: AnyTransition? = nil) {
    self.id = id
    self.wrappedElement = wrappedElement
    if let push = pushTransition {
      self.pushTransition = push
    } else {
			self.pushTransition = NavigationTransition.defaultTransitions.push
    }
    if let pop = popTransition {
      self.popTransition = pop
    } else {
      self.popTransition = NavigationTransition.defaultTransitions.pop
    }
  }
  
  static func == (lhs: ViewElement, rhs: ViewElement) -> Bool {
    lhs.id == rhs.id
  }
}

public struct NavigationStackView<Root>: View where Root: View {
	@ObservedObject private var navigationStack: NavigationStack
	private let rootViewID = "Root"
	private let rootView: Root
	private let rootViewtransitions: (push: AnyTransition, pop: AnyTransition)

	init(transitionType: NavigationTransition = .default, easing: Animation = .easeOut(duration: 0.2), configurator: NavigationConfigurator, rootView: Root) {
		self.rootView = rootView
		self.navigationStack = NavigationStack(configurator: configurator, easing: easing)
		switch transitionType {
		case .none:
				self.rootViewtransitions = (.identity, .identity)
		case .custom(let trans):
				self.rootViewtransitions = (trans, trans)
		default:
				self.rootViewtransitions = NavigationTransition.defaultTransitions
		}
	}

	public var body: some View {
		let showRoot = navigationStack.currentView == nil
		let navigationType = navigationStack.navigationType
		let currentView = navigationStack.currentView
		let currentViewPushTransition = currentView?.pushTransition ?? NavigationTransition.defaultTransitions.push
		let currentViewPopTransition = currentView?.popTransition ?? NavigationTransition.defaultTransitions.pop
		
		return ZStack {
			if showRoot {
				rootView
					.id(rootViewID)
					.transition(navigationType == .push ? rootViewtransitions.push : rootViewtransitions.pop)
					.environmentObject(navigationStack)
			} else {
				currentView?.wrappedElement
					.id(currentView!.id)
					.transition(navigationType == .push ? currentViewPushTransition : currentViewPopTransition)
					.environmentObject(navigationStack)
			}
		}
	}
}
