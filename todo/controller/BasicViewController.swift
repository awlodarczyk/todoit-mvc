//
//  BasicViewController.swift
//  todo
//
//  Created by Adam Wlodarczyk on 28/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import SnapKit
#if SHOW_ADS
import GoogleMobileAds
#endif

class BasicViewController: UIViewController {
    let adUnit = "ca-app-pub-3940256099942544/2934735716"
    var appDelegate: AppDelegate!
#if SHOW_ADS
    var bannerView: GADBannerView!
#endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
#if SHOW_ADS
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = adUnit
        bannerView.rootViewController = self
        bannerView.delegate = self
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID ];
        bannerView.load(request)
#endif
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self))
    }
}
extension BasicViewController{
    func addBannerViewToViewAtBottomIfNeeded() {
#if SHOW_ADS
            self.bannerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(bannerView)
            self.view.addConstraints(
                [NSLayoutConstraint(item: bannerView,
                                    attribute: .bottom,
                                    relatedBy: .equal,
                                    toItem: bottomLayoutGuide,
                                    attribute: .top,
                                    multiplier: 1,
                                    constant: 0),
                 NSLayoutConstraint(item: bannerView,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
                ])
#endif
    }
    
    func addBannerViewToViewAtTopIfNeeded() {
#if SHOW_ADS
            self.bannerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(bannerView)
            self.view.addConstraints(
                [NSLayoutConstraint(item: bannerView,
                                    attribute: .top,
                                    relatedBy: .equal,
                                    toItem: topLayoutGuide,
                                    attribute: .bottom,
                                    multiplier: 1,
                                    constant: 0),
                 NSLayoutConstraint(item: bannerView,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
                ])
#endif
    }
}
#if SHOW_ADS
extension BasicViewController:GADBannerViewDelegate{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        bannerView.bringSubviewToFront(self.view)
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
    }
    
}
#endif
