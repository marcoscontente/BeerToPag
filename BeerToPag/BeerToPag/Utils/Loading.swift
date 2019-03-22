//
//  Loading+Extensions.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 21/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

extension UIView {
    
    enum LoadingContext {
        case fullScreen
        case component
    }
    
    private func createBlur(inView style: UIBlurEffect.Style = .light, alpha: CGFloat = 0.85) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = alpha
        return blurEffectView
    }
    
    private func createActivityIndicator(_ style: UIActivityIndicatorView.Style = .whiteLarge, color: UIColor = .lightGray) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.color = color
        return activityIndicatorView
    }
    
    func startLoading(in context: LoadingContext = .component,
                      blur: Bool = true,
                      backgroundColor: UIColor = .clear,
                      activityIndicatorViewStyle: UIActivityIndicatorView.Style? = nil,
                      activityIndicatorColor: UIColor = .darkGray) {
        guard let parentView = context == .fullScreen ? (UIApplication.shared.delegate)!.window! : self else { return }
        
        let loadingView = UIView(frame: parentView.frame)
        loadingView.backgroundColor = backgroundColor
        loadingView.tag = 11111
        loadingView.center = parentView.center
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        
        if blur {
            let blurView = createBlur()
            blurView.frame = loadingView.frame
            blurView.center = loadingView.center
            blurView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.addSubview(blurView)
        }
        
        var activityIndicatorStyle: UIActivityIndicatorView.Style = context == .fullScreen ? .whiteLarge : .white
        if let activityIndicatorViewStyle = activityIndicatorViewStyle {
            activityIndicatorStyle = activityIndicatorViewStyle
        }
        let activityIndicator = createActivityIndicator(activityIndicatorStyle, color: activityIndicatorColor)
        activityIndicator.frame = loadingView.frame
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            let holderView = (UIApplication.shared.delegate)!.window!!.viewWithTag(11111)
            UIView.animate(withDuration: 0.2, animations: {
                holderView?.alpha = 0
            }, completion: { (completed) in
                holderView?.removeFromSuperview()
            })
        }
    }
}
