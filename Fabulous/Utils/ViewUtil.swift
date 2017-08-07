//
//  LayoutConstraint+Fabulous.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/06.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit

extension NSLayoutAnchor {
  func constraint(equalTo anchor: NSLayoutAnchor!, constant: CGFloat, identifier: String) -> NSLayoutConstraint! {
    let constraint = self.constraint(equalTo: anchor, constant:constant)
    constraint.identifier = identifier
    return constraint
  }
}

extension NSLayoutDimension {
  func constraint(equalToConstant: CGFloat, identifier: String) -> NSLayoutConstraint! {
    let constraint = self.constraint(equalToConstant: equalToConstant)
    constraint.identifier = identifier
    return constraint
  }
}

extension UIView {
  func constraint(withIdentifier: String) -> NSLayoutConstraint? {
    return self.constraints.filter{ $0.identifier == withIdentifier }.first
  }
  
  func layoutShadowPath() {
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.bounds.height/2)
    layer.masksToBounds = false
    layer.shadowColor = UIColor.darkGray.cgColor
    layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 5
    layer.shadowPath = shadowPath.cgPath
  }
  
  func layoutCardShadowPath() {
    let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 2)
    layer.masksToBounds = false
    layer.shadowColor = UIColor.darkGray.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 2
    layer.cornerRadius = 2
    layer.shadowPath = shadowPath.cgPath
  }
}

extension UIButton {
  func alignVertical(spacing: CGFloat = 0) {
    guard let imageSize = self.imageView?.image?.size,
      let text = self.titleLabel?.text,
      let font = self.titleLabel?.font
      else { return }
    self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
    let labelString = NSString(string: text)
    let titleSize = labelString.size(attributes: [NSFontAttributeName: font])
    self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
    let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
    self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
  }
}
