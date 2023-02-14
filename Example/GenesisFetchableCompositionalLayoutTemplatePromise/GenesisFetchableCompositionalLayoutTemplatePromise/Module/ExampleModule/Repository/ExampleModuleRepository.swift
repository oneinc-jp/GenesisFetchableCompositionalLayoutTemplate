//
//  ExampleModulePresenter
//  GenesisFetchableCompositionalLayoutTemplatePromise
//
//  Created by Akira Matsuda on 2023/02/14.
//

import CompositionalLayoutViewController
import Promises
import Foundation

protocol ExampleModuleRepositoryInterface {
    func fetch(force: Bool) -> Promise<[ListItem]>
}

final class ExampleModuleRepository: ExampleModuleRepositoryInterface {
    private var promise: Promise<[ListItem]>!

    func fetch(force: Bool) -> Promise<[ListItem]> {
        promise = Promise<[ListItem]>.pending()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else {
                return
            }
            self.promise.fulfill([
                ListItem(title: String(Int.random(in: 0...100))),
                ListItem(title: String(Int.random(in: 0...100))),
                ListItem(title: String(Int.random(in: 0...100)))
            ])
        }
        return promise
    }
}
