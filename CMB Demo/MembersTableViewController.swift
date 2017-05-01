//
//  MembersTableViewController.swift
//  CMB Demo
//
//  Created by Minxin Guo on 4/30/17.
//  Copyright © 2017 Minxin Guo. All rights reserved.
//

import UIKit
import SwiftyJSON

class MembersTableViewController: UITableViewController {

    fileprivate struct Constants {
        static let segueId = "showDetail"
        static let cellId = "memberCell"
    }
    
    // MARK: - Properties
    fileprivate var members = [Member]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var selectedMember: Member?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! MemberTableViewCell
        cell.member = members[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMember = members[indexPath.row]
        performSegue(withIdentifier: Constants.segueId, sender: self)
    }
}

// MARK: - Segue
extension MembersTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueId {
            guard let destinationVC = segue.destination as? MemberDetailTableViewController,
                let selectedMember = self.selectedMember else {
                    return
            }
            destinationVC.member = selectedMember
        }
    }
}

// MARK: - Load data
extension MembersTableViewController {
    func loadData() {
        if let path = Bundle.main.path(forResource: "team", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    let parser = MemberParser(json: jsonObj)
                    members = parser.parseMember()
                } else {
                    print("Json data is not valid")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename or file doesn't exist")
        }
    }
}
