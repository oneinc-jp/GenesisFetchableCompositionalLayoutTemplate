//
//  ExampleModuleRouter
//  GenesisFetchableCompositionalLayoutTemplate
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
        // TODO: Create a Storyboard with the same name as "ExampleModule".
        // TODO: And Change "ExampleModule" of "R.storyboard.ExampleModule" to lowercase.
        // guard let view = R.storyboard.ExampleModule.instantiateInitialViewController() else {
        //     fatalError("Fail to load ExampleModuleViewController from Storyboard.")
        // }
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