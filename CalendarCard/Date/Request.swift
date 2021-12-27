//
//  Request.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//
import SwiftUI
import SwiftMesh
///http://timor.tech/api/holiday 日历相关接口
///
///接口地址：http://timor.tech/api/holiday/info/$date
///@params $date: 指定日期的字符串，格式 ‘2018-02-23’。可以省略，则默认服务器的当前时间。
///@return json: 如果不是节假日，holiday字段为null。

class Request {
    public static var shared : Request = {
        var re = Request()
        return re
    }()
    
    var holiday: [String: [String : Any]]?
//        = ["01-01":["holiday":true,"name":"元旦","wage":3,"date":"2021-01-01","rest":1],
//                                                    "01-02":["holiday":true,"name":"元旦","wage":2,"date":"2021-01-02","rest":1],
//                                                    "01-03":["holiday":true,"name":"元旦","wage":2,"date":"2021-01-03","rest":1],
//                                                    "02-07":["holiday":false,"name":"春节前调休","after":false,"wage":1,"target":"春节","date":"2021-02-07","rest":35],
//                                                    "02-11":["holiday":true,"name":"除夕","wage":2,"date":"2021-02-11","rest":1],
//                                                    "02-12":["holiday":true,"name":"初一","wage":3,"date":"2021-02-12","rest":1],
//                                                    "02-13":["holiday":true,"name":"初二","wage":3,"date":"2021-02-13","rest":1],
//                                                    "02-14":["holiday":true,"name":"初三","wage":3,"date":"2021-02-14","rest":1],
//                                                    "02-15":["holiday":true,"name":"初四","wage":2,"date":"2021-02-15","rest":1],
//                                                    "02-16":["holiday":true,"name":"初五","wage":2,"date":"2021-02-16","rest":1],
//                                                    "02-17":["holiday":true,"name":"初六","wage":2,"date":"2021-02-17","rest":1],
//                                                    "02-20":["holiday":false,"name":"春节后调休","after":true,"wage":1,"target":"春节","date":"2021-02-20","rest":1],
//                                                    "04-03":["holiday":true,"name":"清明节","wage":3,"date":"2021-04-03","rest":43],
//                                                    "04-04":["holiday":true,"name":"清明节","wage":2,"date":"2021-04-04","rest":1],
//                                                    "04-05":["holiday":true,"name":"清明节","wage":2,"date":"2021-04-05","rest":1],
//                                                    "04-25":["holiday":false,"name":"劳动节前调休","after":false,"wage":1,"target":"劳动节","date":"2021-04-25"],
//                                                    "05-01":["holiday":true,"name":"劳动节","wage":3,"date":"2021-05-01"],
//                                                    "05-02":["holiday":true,"name":"劳动节","wage":2,"date":"2021-05-02"],
//                                                    "05-03":["holiday":true,"name":"劳动节","wage":2,"date":"2021-05-03"],
//                                                    "05-04":["holiday":true,"name":"劳动节","wage":2,"date":"2021-05-04"],
//                                                    "05-05":["holiday":true,"name":"劳动节","wage":2,"date":"2021-05-05"],
//                                                    "05-08":["holiday":false,"name":"劳动节后调休","after":true,"wage":1,"target":"劳动节","date":"2021-05-08"],
//                                                    "06-12":["holiday":true,"name":"端午节","wage":3,"date":"2021-06-12","rest":11],
//                                                    "06-13":["holiday":true,"name":"端午节","wage":2,"date":"2021-06-13"],
//                                                    "06-14":["holiday":true,"name":"端午节","wage":2,"date":"2021-06-14"],
//                                                    "09-18":["holiday":false,"after":false,"name":"中秋节前调休","wage":1,"target":"中秋节","date":"2021-09-18"],
//                                                    "09-19":["holiday":true,"name":"中秋节","wage":3,"date":"2021-09-19"],
//                                                    "09-20":["holiday":true,"name":"中秋节","wage":2,"date":"2021-09-20"],
//                                                    "09-21":["holiday":true,"name":"中秋节","wage":2,"date":"2021-09-21"],
//                                                    "09-26":["holiday":false,"after":false,"name":"国庆节前调休","wage":1,"target":"国庆节","date":"2021-09-26","rest":2],
//                                                    "10-01":["holiday":true,"name":"国庆节","wage":3,"date":"2021-10-01","rest":7],
//                                                    "10-02":["holiday":true,"name":"国庆节","wage":3,"date":"2021-10-02"],
//                                                    "10-03":["holiday":true,"name":"国庆节","wage":3,"date":"2021-10-03"],
//                                                    "10-04":["holiday":true,"name":"国庆节","wage":2,"date":"2021-10-04"],
//                                                    "10-05":["holiday":true,"name":"国庆节","wage":2,"date":"2021-10-05"],
//                                                    "10-06":["holiday":true,"name":"国庆节","wage":2,"date":"2021-10-06"],
//                                                    "10-07":["holiday":true,"name":"国庆节","wage":2,"date":"2021-10-07"],
//                                                    "10-09":["holiday":false,"name":"国庆节后调休","after":true,"wage":1,"target":"国庆节","date":"2021-10-09"]]

    func getHoliday() {

        let entry = UserDefaults.standard.object(forKey: "holiday\(Date().getYear())")

        if let str = entry as? String, let dic = stringValueDic(str) {
            self.holiday = dic
            return
        }
        
        Mesh.requestWithConfig { (config) in
            config.URLString = "https://timor.tech/api/holiday/year/\(Date().getYear())/"
            config.requestMethod = .get
        } success: { (config) in

            guard let data : [String: Any] = config.response?.value as? [String : Any],
                  let holiday = data["holiday"] as? [String : [String : Any]] else {
                return
            }
            self.holiday = holiday
            UserDefaults.standard.set(self.dicValueString(holiday) ?? "", forKey: "holiday\(Date().getYear())")
            
        } failure: { (_) in
            print("error getHoliday")
        }
    }

    func getInfo(_ date: String) -> Holiday?{
        let entry = UserDefaults.standard.object(forKey: "holiday\(Date().getYear())")

        guard let str = entry as? String, let dic = stringValueDic(str) else {
            return nil
        }

        for e in dic {
            if e.key == date {
                let data = try! JSONSerialization.data(withJSONObject: e.value, options: [])
                let holiday = try? JSONDecoder().decode(Holiday.self, from: data)
                return holiday
            }
        }
        return nil
    }
    
    // MARK: 字典转字符串
    func dicValueString(_ dic: [String: [String : Any]]) -> String?{
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
    // MARK: 字符串转字典
    func stringValueDic(_ str: String) -> [String: [String : Any]]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: [String : Any]] {
            return dict
        }
        return nil
    }
}

struct Holiday: Codable {
    var holiday: Bool = false
    var name : String?
    var wage : Int?
    var after: Bool?
    var target: String?
    var date : String?
}
