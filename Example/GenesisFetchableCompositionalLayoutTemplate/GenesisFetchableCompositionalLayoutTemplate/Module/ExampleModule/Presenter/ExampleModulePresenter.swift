//
//  ExampleModulePresenter
//  GenesisFetchableCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/14.
//

import Combine
import CompositionalLayoutViewController
import CompositionalLayoutViewControllerExtension
import CompositionalLayoutViewControllerFetchableExtension
import UIKit

protocol ExampleModulePresenterInput: CollectionViewPresenterInput, CollectionViewFetchablePresenterInput {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class ExampleModulePresenter {
    // MARK: VIPER properties

    weak var view: ExampleModuleViewInput!
    var interactor: ExampleModuleInteractorInput!
    var router: ExampleModuleRouterInput!
    @Published var isLoading = false

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: ExampleModuleViewInput, interactor: ExampleModuleInteractorInput, router: ExampleModuleRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ExampleModulePresenter: ExampleModulePresenterInput {
    var isLoadingPublisher: Published<Bool>.Publisher {
        return $isLoading
    }

    var sections: [CollectionViewSection] {
        return interactor.sections
    }

    func viewDidLoad() {
        Task {
            do {
                try await self.fetch()
            } catch {
                // TODO: handle error
            }
        }
    }

    func section(for sectionIndex: Int) -> CollectionViewSection {
        return interactor.section(for: sectionIndex)
    }

    func didItemSelect(indexPath: IndexPath) {
        if let section = section(for: indexPath.section) as? ListSection<ListItem> {
            let item = section.items[indexPath.row]
            print("Item selected: \(item.title)")
        }
    }

    func fetch(force: Bool = true) async throws {
        isLoading = true
        do {
            defer {
                isLoading = false
            }
            view.update(sections: try await interactor.fetch(force: force))
        } catch {
            isLoading = false
            throw error
        }
    }
}

extension ExampleModulePresenter: ExampleModuleInteractorOutput {
}
