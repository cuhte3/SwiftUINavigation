//
//  Nav.swift
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

// MARK: ViewModel

public class NavigationStack: ObservableObject {
  var navigationType = NavigationType.push
  /// Customizable easing to apply in pop and push transitions
  private let easing: Animation
  
  init(easing: Animation) {
    self.easing = easing
  }
  
  private var viewStack = ViewStack() {
    didSet {
//			guard let destinationView = viewStack.peek() else { return }
      currentView = viewStack.peek()
    }
  }
  
  @Published var currentView: ViewElement?

  
  public func popToRoot() {
    viewStack.popToRoot()
  }
  
  public func push<Element: View>(_ element: Element, withId identifier: Screen, pushTransition: AnyTransition? = .none, popTransition: AnyTransition? = .none) {
    if viewStack.peek()?.id != identifier {
      withAnimation(easing) {
        navigationType = .push
        viewStack.push(ViewElement(id: identifier,
                                   wrappedElement: AnyView(element), pushTransition: pushTransition, popTransition: popTransition))
      }
    }
  }
  
  public func pop(to: PopDestination = .previous) {
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
  
  //the actual stack
  private struct ViewStack {
    private var views = [ViewElement]()
    
    func peek() -> ViewElement? {
      views.last
    }
    
    mutating func push(_ element: ViewElement) {
      if indexForView(withId: element.id) != nil {
        self.popToView(withId: element.id)
//        fatalError("Duplicated view identifier: \"\(element.id)\". You are trying to push a view with an identifier that already exists on the navigation stack.")
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
  var pushTransition: AnyTransition
  var popTransition: AnyTransition
  
  let pushTrans = AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
  let popTrans = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
  
  init(id: Screen, wrappedElement: AnyView, pushTransition: AnyTransition?, popTransition: AnyTransition?) {
    self.id = id
    self.wrappedElement = wrappedElement
    if let push = pushTransition {
      self.pushTransition = push
    } else {
      self.pushTransition = pushTrans
    }
    if let pop = popTransition {
      self.popTransition = pop
    } else {
      self.popTransition = popTrans
    }
  }
  
  static func == (lhs: ViewElement, rhs: ViewElement) -> Bool {
    lhs.id == rhs.id
  }
}

/// An alternative SwiftUI NavigationView implementing classic stack-based navigation giving also some more control on animations and programmatic navigation.
public struct NavigationStackView<Root>: View where Root: View {
    @ObservedObject private var navViewModel: NavigationStack
    private let rootViewID = "root"
    private let rootView: Root
    private let transitions: (push: AnyTransition, pop: AnyTransition)

    /// Creates a NavigationStackView.
    /// - Parameters:
    ///   - transitionType: The type of transition to apply between views in every push and pop operation.
    ///   - easing: The easing function to apply to every push and pop operation.
    ///   - rootView: The very first view in the NavigationStack.
    public init(transitionType: NavigationTransition = .default, easing: Animation = .easeOut(duration: 0.2), @ViewBuilder rootView: () -> Root) {
        self.rootView = rootView()
        self.navViewModel = NavigationStack(easing: easing)
        switch transitionType {
        case .none:
            self.transitions = (.identity, .identity)
        case .custom(let trans):
            self.transitions = (trans, trans)
        default:
            self.transitions = NavigationTransition.defaultTransitions
        }
    }

    public var body: some View {
        let showRoot = navViewModel.currentView == nil
        let navigationType = navViewModel.navigationType

        return ZStack {
            Group {
                if showRoot {
                    rootView
                        .id(rootViewID)
                        .transition(navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(navViewModel)
                } else {
                    navViewModel.currentView!.wrappedElement
                        .id(navViewModel.currentView!.id)
                        .transition(navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(navViewModel)
                }
            }
        }
    }
}
