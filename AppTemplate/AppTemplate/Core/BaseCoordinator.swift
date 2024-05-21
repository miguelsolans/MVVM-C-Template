//
//  BaseCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit

/// Base class for a Coordinator
///
/// Each scene should have its very own coordinator. Coordinator's should be created by extending the Coordinator base class
///
/// For a each coordinator, it needs to override both `start()` and `finish()`
/// Base coordinators should have the following responsabilities:
///
///     - Instantiate ViewModel's and ViewController's
///     - Instantiate and inject dependencies into ViewController's and ViewModel's
///     - Present or push ViewController's to the screen
///
public class BaseCoordinator {

    private(set) var childCoordinators: [BaseCoordinator] = []

    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

}

extension BaseCoordinator: Equatable {
    
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
    
}
