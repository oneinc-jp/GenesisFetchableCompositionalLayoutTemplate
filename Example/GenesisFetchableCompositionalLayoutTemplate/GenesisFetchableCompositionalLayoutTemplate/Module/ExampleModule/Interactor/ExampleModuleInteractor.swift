//
//  ExampleModuleInteractor
//  GenesisFetchableCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/14.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerExtension
import CompositionalLayoutViewControllerFetchableExtension
import Foundation

protocol ExampleModuleInteractorInput: CollectionViewInteractorInput, CollectionViewFetchableInteractorInput {
    // MARK: Methods for modifying repository
}

protocol ExampleModuleInteractorOutput: AnyObject {
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
    func fetch(force: Bool = true) async throws -> [CollectionViewSection] {
        let result = try await repository.fetch(force: force)
        await MainActor.run(body: {
            store([
                ListSection<ListItem>(
                    items: result
                ) { cell, item in
                    var content = cell.defaultContentConfiguration()
                    content.text = item.title
                    return content
                }
            ])
        })
        return sections
    }
}
