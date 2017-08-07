//
//  FabulousCardCell.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/07.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit

class FabulousCardCell: UITableViewCell {

  
  
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var showButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.textColor = UIColor.materialLightText
    subtitleLabel.textColor = UIColor.materialLightText2
    showButton.setTitleColor(UIColor.fabulousPink, for: .normal)
    
    cardView.layoutCardShadowPath()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    cardView.layoutCardShadowPath()
  }
  
}
