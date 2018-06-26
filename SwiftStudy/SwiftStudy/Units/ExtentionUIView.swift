//
//  ExtentionUIView.swift
//  SwiftLogin
//
//  Created by gao on 16/6/14.
//  Copyright © 2016年 GaoHF. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    //MARK: x值
    public var x : CGFloat {
        get{
            return self.frame.origin.x
        }
        
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    //MARK: y值
    public var y : CGFloat {
        get{
            return self.frame.origin.y
        }
        
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    //width
    public var width : CGFloat{
        get{
            return self.frame.size.width
        }
        
        set{
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    //height
    public var height : CGFloat{
        get{
            return self.frame.size.height
        }
        
        set{
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    //MARK: max x值
    public var maxX : CGFloat{
        get{
            return self.frame.maxX
        }
    }
    
    //MARK:maxY
    public var maxY : CGFloat{
        get{
            return self.frame.maxY
        }
    }
    
    //MARK:centerX
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        
        set{
            var point = self.center
            point.x = newValue
            self.center = point
        }
    }
    
    //MARK: centerY
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        
        set{
            var point = self.center
            point.y = newValue
            self.center = point
        }
    }
}
