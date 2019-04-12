//
//  ViewController.swift
//  todo
//
//  Created by Adam Wlodarczyk on 27/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

class IntroViewController: BasicViewController {
    
    var animationView: LOTAnimationView!
    let color = UIColor.init(red: 103/255, green: 58/255, blue: 183/255, alpha: 1.0)
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBannerViewToViewAtBottomIfNeeded()
        configureView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            
            self.segueToDoViewController()
        }
    }
}

extension IntroViewController{
    func segueToDoViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TodoViewController")

        self.present(controller, animated: true, completion: nil)
    }
    func configureView(){
        animationView = LOTAnimationView.init(name: "main_animation", bundle: Bundle.main)
        self.view.backgroundColor = color
        animationView.backgroundColor = color
        animationView.autoReverseAnimation = true
        animationView.contentMode = .scaleAspectFit
        self.view.addSubview(animationView)
        
        animationView.snp.makeConstraints { (make) -> Void in
            make.width.height.width.equalTo(300)
            make.center.equalTo(self.view)
        }
        self.nameLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(animationView.snp.bottom).offset(16)
            make.width.equalTo(self.view)
        }
        self.nameLabel.text = "To do IT"
        animationView.play()
        
    }
}
