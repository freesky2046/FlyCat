//
//  FCSettingItem.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/17.
//

import Foundation
import HandyJSON

class FCSettingItem {
    var name:String?  = ""
    var showNext:Bool? = false
    var detail:String? = ""
    var imageUrl:String? = ""
    
    var isImage:Bool {
        if(imageUrl != nil && imageUrl!.count > 0) {
            return true
        }else {
            return false
        }
    }
}

//baidu_name    string    百度帐号
//netdisk_name    string    网盘帐号
//avatar_url    string    头像地址
//vip_type    int    会员类型，0普通用户、1普通会员、2超级会员
//uk    int    用户ID

class FCUserInfo : HandyJSON {
    var baidu_name:String?
    var netdisk_name:String?
    var avatar_url:String?
    var vip_type:Int?
    var uk:Int?
    required init() {}
}
