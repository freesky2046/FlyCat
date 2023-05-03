//
//  FCVideoListInfo.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/3.
//

import UIKit
import HandyJSON

class FCThumbs: HandyJSON {
    var icon:String?
    var url3:String?
    var url2:String?
    var url1:String?
    required init() {}
}

class FCVideoListInfo : HandyJSON {
    var server_mtime:Int?
    var category:Int?
    var fs_id:Int?
    var server_ctime:Int?
    var isdir:Int?
    var thumbs:FCThumbs?
    var local_mtime:Int?
    var size:Int?
    var md5:String?
    var share:Int?
    var path:String?
    var local_ctime:Int?
    var object_key:String?
    var server_filename:String?
    required init() {}
}

class FCVideoListInfoRes: HandyJSON {
    var errno:Int?
    var guid_info:String?
    var info:[FCVideoListInfo]?
    var request_id:Int?
    var guid:Int?
    required init() {}
}
