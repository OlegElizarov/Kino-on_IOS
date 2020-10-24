//
//  ViewController.swift
//  TestApp
//
//  Created by Олег Елизаров on 05.10.2020.
//

import UIKit

class ViewController: UIViewController {
    var collectionViewController: CollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewController = CollectionViewController()
        view.addSubview(collectionViewController.view)
    }
}
