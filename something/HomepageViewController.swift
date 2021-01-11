//
//  HomepageViewController.swift
//  ARTapJump
//
//  Created by Yu Hong on 2021/1/10.
//

import UIKit
import SwiftUI

class HomepageViewController: UIViewController {
    
    fileprivate let contentView = UIHostingController(rootView: ContentView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHC()
        setupConstraint()
        
    }
    fileprivate func setupConstraint(){
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    fileprivate func setupHC(){
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.didMove(toParent: self)
    }
    
    
}
