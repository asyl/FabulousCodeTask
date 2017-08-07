//
//  FabulousColor.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/06.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: CGFloat(a) / 255.0
    )
  }
  
  convenience init(argb: Int) {
    self.init(
      red: (argb >> 16) & 0xFF,
      green: (argb >> 8) & 0xFF,
      blue: argb & 0xFF,
      a: (argb >> 24) & 0xFF
    )
  }
  
  class var fabulousCyan: UIColor { return UIColor(argb: 0xFF00838F) }
  class var fabulousBlue: UIColor { return UIColor(argb: 0xFF2962FF) }
  class var fabulousPink: UIColor { return UIColor(argb: 0xFFF50057) }
  class var fabulousGray: UIColor { return UIColor(argb: 0xFF212121) }
  class var fabulousPurple: UIColor { return UIColor(argb: 0xFF6A1B9A) }
  class var fabulousBrown: UIColor { return UIColor(argb: 0xFF3E2723) }
  
  class var materialDarkText: UIColor { return UIColor(argb: 0xD6000000) }
  class var materialDarkText2: UIColor { return UIColor(argb: 0x91000000) }
  class var materialLightText: UIColor { return UIColor(argb: 0xD6FFFFFF) }
  class var materialLightText2: UIColor { return UIColor(argb: 0x91FFFFFF) }
}
