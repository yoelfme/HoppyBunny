//
//  Goal.swift
//  HappyBunny
//
//  Created by Yoel Monzón on 25/09/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class Goal: CCNode {
    func didLoadFromCCB() {
        physicsBody.sensor = true;
    }
}