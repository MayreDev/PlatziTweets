//
//  CustomBanner.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 01-12-22.
//

import Foundation
import UIKit
import NotificationBannerSwift

class CustomBanner: BannerColorsProtocol {
    
    internal func color(for style: BannerStyle) -> UIColor {
        switch style{
        case .danger: return UIColor.systemPink   // Your custom .danger color
        case .info:  return UIColor.blue     // Your custom .info color
        case .customView:  return UIColor.cyan  // Your custom .customView color
        case .success: return   UIColor.magenta// Your custom .success color
        case .warning: return   UIColor.orange // Your custom .warning color
        }
    }
    
}
