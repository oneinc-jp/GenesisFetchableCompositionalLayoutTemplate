//
//  ExampleModulePresenter
//  GenesisFetchableCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/14.
//

import CompositionalLayoutViewController

protocol ExampleModuleRepositoryInterface {
    func fetch(force: Bool) async throws -> [ListItem]
}

final class ExampleModuleRepository: ExampleModuleRepositoryInterface {
    func fetch(force: Bool) async throws -> [ListItem] {
        try await Task.sleep(for: .seconds(2))
        return [
            ListItem(title: String(Int.random(in: 0...100))),
            ListItem(title: String(Int.random(in: 0...100))),
            ListItem(title: String(Int.random(in: 0...100)))
        ]
    }
}
