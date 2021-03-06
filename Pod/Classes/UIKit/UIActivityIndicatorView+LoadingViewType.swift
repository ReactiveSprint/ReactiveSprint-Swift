//
//  UIActivityIndicatorView+LoadingViewType.swift
//  Pods
//
//  Created by Ahmad Baraka on 3/16/16.
//  Copyright © 2016 ReactiveSprint. All rights reserved.
//

import Foundation

extension UIActivityIndicatorView: LoadingViewType
{
    public var loading: Bool {
        get {
            return isAnimating()
        }
        
        set {
            if newValue
            {
                startAnimating()
            }
            else
            {
                stopAnimating()
            }
        }
    }
}
