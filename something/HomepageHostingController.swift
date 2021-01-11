//
//  HomepageHostingController.swift
//  ARTapJump
//
//  Created by Yu Hong on 2021/1/10.
//

import Foundation
import SwiftUI

class uiHostingController: UIHostingController<ContentView>{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ContentView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
