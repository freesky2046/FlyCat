//
//  FCPlayerInfo.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/8.
//

import UIKit
import HandyJSON


//{
//    "errno": 0, //遇到133错误码，需先等待广告播放时间后，才可请求到视频流
//    "request_id": 4862391359038922003,
//    "adTime": 15,
//    "adToken": "RqmHZo9Lr8T58HHVqFe5tMZ87DWPQ1tN/IlBTW5ZZ2e0QSMA2cl3c0k6mtKex5aYp3burebiO+teda/WwA5oe71LwnU5iL+xlLGaSbg6suSiX/F/hKFSWqGmaaAMVMDfA+B+WjCIh0LTO0s8eNdn/SbT3adLWX5ZQUTe5oHYWDg=",
//    "ltime": 5
//}
class FCPlayerInfo: HandyJSON {
    var errno:Int?
    var request_id:String?
    var adTime:Int?
    var adToken:String?
    var ltime:Double?
    required init() {}
}
