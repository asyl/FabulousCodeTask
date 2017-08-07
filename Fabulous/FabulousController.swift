//
//  ViewController.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/06.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit

class FabulousController: UIViewController {
  
  //MARK: Constants
  
  fileprivate struct Constant {
    static let cellCount = 10
    static let cellIndexToDismissLauncher = 5
  }
  
  fileprivate struct Metric {
    static let cellHeight: CGFloat = 40
    static let launcherHeight: CGFloat = 60
    static let fabHeight: CGFloat = 60
    static let sideMargin: CGFloat = 16
    static let bottomMargin: CGFloat = 16
  }
  
  let colors = [UIColor.fabulousBrown,
                UIColor.fabulousGray,
                UIColor.fabulousPurple]
  
  //MARK: UI 
  
  fileprivate let tableView = UITableView(
    frame: .zero,
    style: .plain).then {
      $0.estimatedRowHeight = 80
      $0.rowHeight = UITableViewAutomaticDimension
      $0.register(RitualCell.self, forCellReuseIdentifier: String(describing: RitualCell.self))
      $0.register(UINib(nibName: String(describing: FabulousCardCell.self), bundle: Bundle.main),
                  forCellReuseIdentifier: String(describing: FabulousCardCell.self))
      
  }
  
  fileprivate let launcherView = LauncherView(frame: .zero)
  fileprivate let fabButton = FabButton(frame: .zero)
		
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Fabulous"
    tableView.separatorStyle = .none
    automaticallyAdjustsScrollViewInsets = false

    tableView.dataSource = self
    tableView.delegate = self
    
    launcherView.delegate = self
    
    
    view.addSubview(tableView)
    view.addSubview(fabButton)
    view.addSubview(launcherView)
    
    setupConstraints()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    launcherView.present(toAppear: true)
    fabButton.present(toAppear: false)
  }
  
  func setupConstraints() {
    fabButton.translatesAutoresizingMaskIntoConstraints = false
    fabButton.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Metric.bottomMargin).isActive = true
    fabButton.trailingAnchor.constraint(
      equalTo: view.trailingAnchor,
      constant: -Metric.sideMargin).isActive = true
    fabButton.widthAnchor.constraint(
      equalToConstant: Metric.launcherHeight).isActive = true
    fabButton.heightAnchor.constraint(equalTo: fabButton.widthAnchor, constant: 0).isActive = true
    fabButton.backgroundColor = UIColor.fabulousBlue
    fabButton.setImage(UIImage(named: "ic_whatshot_white"), for: .normal)
    fabButton.addTarget(self, action: #selector(fabButtonDidTap(sender:)), for: .touchUpInside)
    
    launcherView.translatesAutoresizingMaskIntoConstraints = false
    launcherView.leadingAnchor.constraint(
      equalTo: view.leadingAnchor,
      constant: Metric.sideMargin).isActive = true
    launcherView.trailingAnchor.constraint(
      equalTo: view.trailingAnchor,
      constant: -Metric.sideMargin).isActive = true
    launcherView.heightAnchor.constraint(equalToConstant: Metric.launcherHeight).isActive = true
    launcherView.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: Metric.launcherHeight,
      identifier: LauncherView.Identifier.constraintBottom).isActive = true
    launcherView.oldHeight = Metric.fabHeight
    launcherView.oldBottomMargin = -Metric.bottomMargin
    launcherView.backgroundColor = UIColor.white
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    
    updateViewConstraints()
  }
  
  func fabButtonDidTap(sender: UIButton) {
    
  }
  
  func launcherViewDidTap(sender: UITapGestureRecognizer){
    
  }
  
}


//MARK: TableView DataSource

extension FabulousController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constant.cellCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: String(describing: FabulousCardCell.self),
      for: indexPath) as! FabulousCardCell
    cell.cardView.backgroundColor = colors[indexPath.row % colors.count]
    if indexPath.row >= Constant.cellIndexToDismissLauncher - 1 {
      cell.titleLabel.textColor = UIColor.black
      cell.subtitleLabel.textColor = UIColor.black
      cell.cardView.backgroundColor = UIColor.white
    }
    return cell
  }
  
}


//MARK: TableView Delegate

extension FabulousController: UITableViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let lastVisibleIndexPath = self.tableView.indexPathsForVisibleRows?.last
    launcherView.present(toAppear: Constant.cellIndexToDismissLauncher >= (lastVisibleIndexPath?.row ?? -1))
  }
  
}

//MARK: FabButton Delegate

extension FabulousController: FabButtonDelegate {
  
  func fabButton(_ fabButton: FabButton, didPresent toAppear: Bool) {
    launcherView.present(toAppear: !toAppear)
  }
  
}


//MARK: LauncherView Delegate

extension FabulousController: LauncherViewDelegate {
  
  func launcherView(_ launcherView: LauncherView, willTranslate toTop: Bool) {
    fabButton.present(toAppear: !toTop)
  }
  
}
