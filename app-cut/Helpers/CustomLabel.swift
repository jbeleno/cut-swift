//
//  CustomLabel.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 11/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    override var bounds: CGRect {
        didSet {
            if (bounds.size.width != self.bounds.size.width) {
                self.setNeedsUpdateConstraints();
            }
        }
    }
    
    override func updateConstraints() {
        if(self.preferredMaxLayoutWidth != self.bounds.size.width) {
            self.preferredMaxLayoutWidth = self.bounds.size.width
        }
        super.updateConstraints()
    }

}
