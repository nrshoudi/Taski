//
//  FloatingActionButton.swift
//  Animation
//
//  Created by Noura Aziz on 3/13/19.
//  Copyright © 2019 Noura Aziz. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButtonX {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
                self.backgroundColor = #colorLiteral(red: 0.8196, green: 0.2196, blue: 0.3333, alpha: 1) /* #d13855 */

            } else {
                self.transform = .identity
                self.backgroundColor = #colorLiteral(red: 0.9412, green: 0.251, blue: 0.3843, alpha: 1) /* #f04062 */

            }
        })
        
        
        
        
        return super.beginTracking(touch, with: event)
    }
    
    
}
