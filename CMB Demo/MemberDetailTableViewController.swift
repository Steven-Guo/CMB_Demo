//
//  MemberDetailTableViewController.swift
//  CMB Demo
//
//  Created by Minxin Guo on 4/30/17.
//  Copyright © 2017 Minxin Guo. All rights reserved.
//

import UIKit

class MemberDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - Properties for header
    fileprivate struct HeaderConstants {
        static let headerHeight: CGFloat = 350
        static let headerCut: CGFloat = 60
    }
    
    var headerView: UIView!
    var newHeaderLayer: CAShapeLayer!

    // MARK: - Properties for data
    fileprivate struct Constants {
        static let cellId = "bioCell"
    }

    var member: Member! {
        didSet {
            self.title = member.firstName
            updateUI()
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! MemberDetailCell
        // Display member info
        let fullName = "\(member.firstName) \(member.lastName)"
        cell.nameLabel.text = fullName
        cell.titleLabel.text = member.title
        cell.bioTextArea.text = member.bio
        return cell
    }
}

extension MemberDetailTableViewController {
    func updateUI() {
        DispatchQueue.main.async {
            let url = URL(string: self.member.avatarUrlString)
            self.avatarImageView.sd_setImage(with: url)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - For header
    func updateView() {
        // For table rows, not for header
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // For header
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        newHeaderLayer = CAShapeLayer()
        headerView.layer.mask = newHeaderLayer
        
        let newHeight = HeaderConstants.headerHeight - HeaderConstants.headerCut / 2
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        
        configureHeaderViewCut()
    }
    
    func configureHeaderViewCut() {
        let newHeight = HeaderConstants.headerHeight - HeaderConstants.headerCut / 2
        var getHeaderFrame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: HeaderConstants.headerHeight)
        
        if tableView.contentOffset.y < newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y + HeaderConstants.headerCut / 2
        }
        
        headerView.frame = getHeaderFrame
        let cutDirection = UIBezierPath()
        cutDirection.move(to: CGPoint(x: 0, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: getHeaderFrame.height))
        cutDirection.addLine(to: CGPoint(x: 0, y: getHeaderFrame.height - HeaderConstants.headerCut))
        newHeaderLayer.path = cutDirection.cgPath
    }
    
    // Scroll View
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        configureHeaderViewCut()
    }
}
