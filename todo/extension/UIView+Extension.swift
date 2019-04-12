//
//  UIView+Extenstion.swift
//  todo
//
//  Created by Adam Wlodarczyk on 28/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import SnapKit

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        
        container.addSubview(self);
        container.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
    }
}
