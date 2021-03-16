//
//  IDevice.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 21 Jan 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

enum DeviceType
{
    case iPhone
    case iPad
    case mac
}

struct IDevice
{
    static var current: DeviceType
    {
        #if os(iOS)
        return UIDevice.current.model.contains("iPad") ? .iPad : .iPhone
        #else
        return .mac
        #endif
    }
    
    static var screen: CGRect
    {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
        #endif
    }
    
    static var isIPhone: Bool { current == .iPhone }
}
