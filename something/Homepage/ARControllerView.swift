//
//  ARControllerView.swift
//  ARTapJump
//
//  Created by Yu Hong on 2021/1/10.
//

import Foundation
import UIKit
import SwiftUI

struct ARControllerView: UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> some UIViewController {
        guard let arView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ARview") as? ViewController else{
            fatalError("something")
        }
        return arView
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
