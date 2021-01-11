//
//  NodeExtension.swift
//  something
//
//  Created by Yu Hong on 2021/1/9.
//

import Foundation

import SceneKit

extension SCNNode{
    func isNotContainedXZ(in boxnode: SCNNode) -> Bool{
        let box = boxnode.geometry as! SCNBox
        let width = Float(box.width)
        if abs(position.x - boxnode.position.x) > width / 2.0{
            return true
        }
        if abs(position.z - boxnode.position.z) > width / 2.0{
            return true
        }
        return false
    }
}
