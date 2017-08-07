//
//  FabView.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/06.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit

@objc protocol FabButtonDelegate {
  @objc optional func fabButton(_ fabButton: FabButton, willPresent toAppear: Bool)
  @objc optional func fabButton(_ fabButton: FabButton, didPresent toAppear: Bool)
}

class FabButton: UIButton {
  
  var isAppeared: Bool! {
    didSet {
      present(toAppear: isAppeared)
    }
  }
  var delegate: FabButtonDelegate?
  var oldWidth: CGFloat = 0
  var oldBottomMargin: CGFloat = 0
  
  fileprivate struct Metric {
    static let animDuration = 0.3
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.zPosition = 1000
    tintColor = UIColor.white
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layoutShadowPath()
    self.layer.cornerRadius = self.bounds.size.width * 0.5
  }
  
  
  //temporary solution to animate circular view
  
  func present(toAppear: Bool) {
    if isAppeared != toAppear {
      delegate?.fabButton?(self, willPresent: toAppear)
      
      self.transform = toAppear ? CGAffineTransform(scaleX: 0, y: 0) : CGAffineTransform.identity
      
      UIView.animate(
        withDuration: Metric.animDuration,
        animations: {
          self.transform = toAppear ? CGAffineTransform.identity : CGAffineTransform(scaleX: 0.01, y: 0.01)
      }, completion: { finished in
        self.delegate?.fabButton?(self, didPresent: toAppear)
      })
      isAppeared = toAppear
    }
  }
  
}
