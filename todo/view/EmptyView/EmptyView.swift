//
//  EmptyView.swift
//  todo
//
//  Created by Adam Wlodarczyk on 28/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class EmptyView: UIView {

    let CONTENT_XIB_NAME = "EmptyView"
    let color = UIColor.init(red: 1/255, green: 183/255, blue: 210/255, alpha: 1.0)
    @IBOutlet var contentView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var noItemsLabel: UILabel!
    
    var animationView: LOTAnimationView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
}
extension EmptyView{
    func commonInit(){
        
        Bundle.main.loadNibNamed(CONTENT_XIB_NAME, owner: self, options: nil)
        self.addSubview(contentView);
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        setAnimation()
    }
    func setAnimation(){
        animationView = LOTAnimationView(name: "empty_box", bundle: Bundle.main)
        animationView.contentMode = .scaleAspectFit
        animationView.autoReverseAnimation = true
        animationView.play()
        self.containerView.addSubview(animationView)
        setConstraints()
    }
    func setConstraints(){
        containerView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        animationView.snp.makeConstraints { (make) -> Void in
            make.width.height.width.equalTo(self.containerView)
                make.center.equalTo(self.containerView)
            }
    }
}

