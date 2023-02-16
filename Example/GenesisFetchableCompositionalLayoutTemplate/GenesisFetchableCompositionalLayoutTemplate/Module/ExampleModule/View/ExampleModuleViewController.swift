//
//  ExampleModuleViewController
//  GenesisFetchableCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/14.
//

import Combine
import CompositionalLayoutViewController
import CompositionalLayoutViewControllerExtension
import JGProgressHUD
import UIKit

// MARK: - ExampleModuleViewInput

protocol ExampleModuleViewInput: CollectionViewInput {
    // MARK: Callback from presenter
}

// MARK: - ExampleModuleViewController

final class ExampleModuleViewController: CompositionalLayoutViewController {
    // MARK: Internal

    // MARK: Stored instance properties

    var presenter: ExampleModulePresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Example"
        provider = self
        presenter.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loading in
                guard let self else {
                    return
                }
                if loading {
                    let hud = JGProgressHUD()
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                }
                else if let hud = self.view.subviews.first(where: { $0 is JGProgressHUD }) as? JGProgressHUD {
                    hud.dismiss()
                }
            }.store(in: &cancellable)
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        presenter.viewDidLoad()
    }

    override func didSelectItem(at indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didItemSelect(indexPath: indexPath)
    }

    // MARK: Private

    private var cancellable = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()

    // MARK: Other private methods

    @objc
    private func reload() {
        Task {
            do {
                try await self.presenter.reload()
            }
            catch {
                // TODO: handle error
            }
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: SectionProvider

extension ExampleModuleViewController: SectionProvider {
    var sections: [CollectionViewSection] {
        return presenter.sections
    }
}

// MARK: ExampleModuleViewInput

extension ExampleModuleViewController: ExampleModuleViewInput {
    func update(sections: [CollectionViewSection]) {
        // TODO:
        updateDataSource(sections)
    }
}
