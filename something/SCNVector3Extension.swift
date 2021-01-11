//
//  SCNVector3Extension.swift
//  something
//
//  Created by Yu Hong on 2021/1/9.
//

import Foundation
import SceneKit

extension SCNVector3{
    static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3{
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
}
