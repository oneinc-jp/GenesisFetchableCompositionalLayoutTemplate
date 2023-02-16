//
//  ViewController.swift
//  GenesisFetchableCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentModule(_ sender: Any) {
        navigationController?.pushViewController(ExampleModuleRouter.assembleModule(), animated: true)
    }
}
