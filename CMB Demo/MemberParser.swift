//
//  MemberParser.swift
//  CMB Demo
//
//  Created by Minxin Guo on 4/30/17.
//  Copyright © 2017 Minxin Guo. All rights reserved.
//

import Foundation
import SwiftyJSON

class MemberParser {
    private var json: JSON
    
    init(json: JSON) {
        self.json = json
    }
    
    func parseMember() -> [Member] {
        var result = [Member]()
        for (_, object) in json {
            let id = object["id"].stringValue
            let avatar = object["avatar"].stringValue
            let bio = object["bio"].stringValue
            let firstName = object["firstName"].stringValue
            let lastName = object["lastName"].stringValue
            let title = object["title"].stringValue
            let member = Member(id: id, avatarUrlString: avatar, bio: bio, firstName: firstName, lastName: lastName, title: title)
            result.append(member)
        }
        return result
    }
}
