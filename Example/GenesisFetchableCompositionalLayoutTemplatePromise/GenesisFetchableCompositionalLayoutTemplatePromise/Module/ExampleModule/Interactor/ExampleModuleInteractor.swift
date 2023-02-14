//
//  ExampleModuleInteractor
//  GenesisFetchableCompositionalLayoutTemplatePromise
//
//  Created by Akira Matsuda on 2023/02/14.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerExtension
import CompositionalLayoutViewControllerFetchableExtensionPromises
import Promises
import Foundation

protocol ExampleModuleInteractorInput: CollectionViewInteractorInput, CollectionViewFetchableInteractorInput {
    // MARK: Methods for modifying repository
}

protocol ExampleModuleInteractorOutput: CollectionViewFetchableInteractorOutput {
    // MARK: Callback methods from repository
}

final class ExampleModuleInteractor {
    // MARK: VIPER property
    weak var presenter: ExampleModuleInteractorOutput!

    // MARK: Stored instance properties

    private var repository: ExampleModuleRepositoryInterface
    var sections: [CollectionViewSection] = []

    // MARK: Computed instance properties

    // MARK: Initializer
    
    init(repository: ExampleModuleRepositoryInterface) {
        self.repository = repository
    }

    // MARK: Other private methods
}

extension ExampleModuleInteractor: ExampleModuleInteractorInput {
    @discardableResult
    func fetch(force: Bool) -> Promise<[CollectionViewSection]> {
        let promise = Promise<[CollectionViewSection]>.pending()
        presenter.prepareFetch(self.repository.fetch(force: force).then { [weak self] result in
            guard let self else {
                return
            }
            self.presenter.willFetchEnd()
            self.store([
                ListSection<ListItem>(
                    items: result
                ) { cell, item in
                    var content = cell.defaultContentConfiguration()
                    content.text = item.title
                    return content
                }
            ])
            promise.fulfill(self.sections)
        }.catch { error in
            promise.reject(error)
        })
        return promise
    }
}
