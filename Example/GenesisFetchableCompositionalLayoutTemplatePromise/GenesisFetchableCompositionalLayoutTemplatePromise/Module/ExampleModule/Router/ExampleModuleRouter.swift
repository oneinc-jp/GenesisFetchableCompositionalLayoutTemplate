//
//  ExampleModuleRouter
//  GenesisFetchableCompositionalLayoutTemplatePromise
//
//  Created by Akira Matsuda on 2023/02/14.
//

import UIKit

protocol ExampleModuleRouterInput: AnyObject {
    // MARK: View transitions
}

final class ExampleModuleRouter {
    private unowned let viewController: ExampleModuleViewController

    init(viewController: ExampleModuleViewController) {
        self.viewController = viewController
    }

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
}

extension ExampleModuleRouter: ExampleModuleRouterInput {}
