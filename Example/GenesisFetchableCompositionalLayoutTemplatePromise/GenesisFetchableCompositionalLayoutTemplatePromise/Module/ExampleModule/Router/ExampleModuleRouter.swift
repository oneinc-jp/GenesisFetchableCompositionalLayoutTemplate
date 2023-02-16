//
//  ExampleModuleRouter
//  GenesisFetchableCompositionalLayoutTemplatePromise
//
//  Created by Akira Matsuda on 2023/02/14.
//

import UIKit

// MARK: - ExampleModuleRouterInput

protocol ExampleModuleRouterInput: AnyObject {
    // MARK: View transitions
}

// MARK: - ExampleModuleRouter

final class ExampleModuleRouter {
    // MARK: Lifecycle

    init(viewController: ExampleModuleViewController) {
        self.viewController = viewController
    }

    // MARK: Internal

    static func assembleModule() -> ExampleModuleViewController {
        let view = ExampleModuleViewController()
        let repository = ExampleModuleRepository()
        let interactor = ExampleModuleInteractor(repository: repository)
        let router = ExampleModuleRouter(viewController: view)
        let presenter = ExampleModulePresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }

    // MARK: Private

    private unowned let viewController: ExampleModuleViewController
}

// MARK: ExampleModuleRouterInput

extension ExampleModuleRouter: ExampleModuleRouterInput {}
