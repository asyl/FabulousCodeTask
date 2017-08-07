//
//  LauncherView.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/06.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit

@objc protocol LauncherViewDelegate {
  @objc optional func launcherView(_ launcherView: LauncherView, willTranslate toTop: Bool)
  @objc optional func launcherView(_ launcherView: LauncherView, didTranslate toTop: Bool)
}

class LauncherView: UIView {
  
  //MARK: Constants
  fileprivate struct Metric {
    static let animDuration: TimeInterval = 0.3
    static let springDamping: CGFloat = 0.5
    static let springVelocity: CGFloat = 2
    
    static let imageViewMargin: CGFloat = 6
    static let launchButtonMargin: CGFloat = 6
    static let ritualLabelSideMargin: CGFloat = 16
    static let ritualLabelBottomMargin: CGFloat = 4
  }
  
  struct Identifier {
    static let constraintBottom = "launcherBottom"
  }
  
  
  //MARK: Properties
  var isAppeared = false
  var delegate: LauncherViewDelegate?
  var oldHeight: CGFloat = 0
  var oldBottomMargin: CGFloat = 0
  
  
  //MARK: UI Elements
  fileprivate let imageView = UIImageView(frame: .zero).then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  fileprivate let ritualLabel = UILabel(frame: .zero).then {
    $0.font = UIFont.boldSystemFont(ofSize: 20)
    $0.textColor = UIColor.materialDarkText
    $0.clipsToBounds = true
    $0.isUserInteractionEnabled = false
    $0.text = "Afternoon Ritual"
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 1
  }
  
  fileprivate let timeLabel = UILabel(frame: .zero).then {
    $0.font = UIFont.boldSystemFont(ofSize: 14)
    $0.textColor = UIColor.materialDarkText2
    $0.clipsToBounds = true
    $0.isUserInteractionEnabled = false
    $0.text = "1:00PM"
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 1
  }
  
  let launchButton = UIButton(frame: .zero).then {
    $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    $0.setImage(UIImage(named: "ic_whatshot_white"), for: .normal)
    $0.setTitle("Launch", for: .normal)
    $0.tintColor = UIColor.fabulousPink
    $0.setTitleColor(UIColor.fabulousPink, for: .normal)
    $0.clipsToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  //Layout programmatically with constraints
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    layer.zPosition = 1000
    
    addSubview(imageView)
    addSubview(ritualLabel)
    addSubview(timeLabel)
    addSubview(launchButton)
    
    
    imageView.topAnchor.constraint(
      equalTo: self.topAnchor,
      constant: Metric.imageViewMargin).isActive = true
    imageView.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: Metric.imageViewMargin).isActive = true
    imageView.bottomAnchor.constraint(
      equalTo: self.bottomAnchor,
      constant: -Metric.imageViewMargin).isActive = true
    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    imageView.backgroundColor = UIColor.black

    ritualLabel.leadingAnchor.constraint(
      equalTo: imageView.trailingAnchor,
      constant: Metric.ritualLabelSideMargin).isActive = true
    let horizontal = ritualLabel.trailingAnchor.constraint(
      equalTo: launchButton.leadingAnchor, constant: Metric.ritualLabelSideMargin)
    horizontal.priority = launchButton.contentHuggingPriority(for: .horizontal)
    horizontal.isActive = true
    ritualLabel.bottomAnchor.constraint(
      equalTo: self.centerYAnchor,
      constant: Metric.ritualLabelBottomMargin).isActive = true
    
    timeLabel.leadingAnchor.constraint(equalTo: ritualLabel.leadingAnchor).isActive = true
    timeLabel.topAnchor.constraint(equalTo: ritualLabel.bottomAnchor).isActive = true
    timeLabel.trailingAnchor.constraint(equalTo: ritualLabel.trailingAnchor).isActive = true
    
    launchButton.topAnchor.constraint(
      equalTo: self.topAnchor,
      constant: Metric.launchButtonMargin).isActive = true
    launchButton.trailingAnchor.constraint(
      equalTo: self.trailingAnchor,
      constant: -Metric.launchButtonMargin).isActive = true
    launchButton.bottomAnchor.constraint(
      equalTo: self.bottomAnchor,
      constant: -Metric.launchButtonMargin).isActive = true
    
    
    setNeedsUpdateConstraints()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layoutShadowPath()
    layer.cornerRadius = bounds.height * 0.5
    imageView.layer.cornerRadius = imageView.bounds.height * 0.5
    launchButton.alignVertical()
  }
  
  func present(toAppear: Bool) {
    if isAppeared != toAppear {
      delegate?.launcherView?(self, willTranslate: toAppear)
      self.superview?.constraint(withIdentifier: Identifier.constraintBottom)?
        .constant = toAppear ? oldBottomMargin : self.frame.size.height + -oldBottomMargin
      UIView.animate(
        withDuration: Metric.animDuration,
        delay: toAppear ? Metric.animDuration : 0,
        usingSpringWithDamping: Metric.springDamping,
        initialSpringVelocity: Metric.springVelocity,
        options: .curveLinear,
        animations: {
          self.superview?.layoutIfNeeded()
      }, completion: { finished in
        if finished {
          self.delegate?.launcherView?(self, didTranslate: toAppear)
        }
      })
    }
    isAppeared = toAppear
  }
  
}
