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

//"tkbind_id": 0,
//"server_mtime": 1637421122,
//"category": 6,
//"real_category": "",
//"fs_id": 268621344570722,

//"dir_empty": 0,
//"oper_id": 0,

//"server_ctime": 1510118922,

//"extent_tinyint7": 0,
//"wpfile": 0,
//"owner_type": 0,
//"local_mtime": 1510118922,
//"size": 0,
//"isdir": 1,
//"share": 0,
//"pl": 1,
//"from_type": 0,
//"local_ctime": 1510118922,
//"path": "/001部-050部",
//"empty": 0,
//"server_atime": 0,
//"server_filename": "001部-050部",
//"owner_id": 0,
//"unlist": 0


class FCVideoListInfo : HandyJSON {
    var tkbind_id:Int?
    var server_mtime:String?
    var category:Int?
    var real_category:String?
    var fs_id:String?
    var dir_empty:Int?
    var oper_id:Int?
    var server_ctime:String?
    var extent_tinyint7:Int?
    var wpfile:Int?
    var owner_type:Int?
    var local_mtime:String?
    var size:Int?
    var isdir:Int?
    var share:Int?
    var pl:Int?
    var from_type:Int?
    var local_ctime:String?
    var path:String?
    var empty:Int?
    var server_atime:Int?
    var server_filename:String?
    var owner_id:Int?
    var unlist:Int?
    required init() {}
}

class FCVideoListInfoRes: HandyJSON {
    var errno:Int?
    var guid_info:String?
    var list:[FCVideoListInfo]?
    var request_id:Int?
    var guid:Int?
    required init() {}
}
