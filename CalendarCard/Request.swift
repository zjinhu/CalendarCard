//
//  Request.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//
import SwiftUI
import Combine
import Foundation
import SwiftMesh
///http://timor.tech/api/holiday 日历相关接口
///
///接口地址：http://timor.tech/api/holiday/info/$date
///@params $date: 指定日期的字符串，格式 ‘2018-02-23’。可以省略，则默认服务器的当前时间。
///@return json: 如果不是节假日，holiday字段为null。

class Request {
    public static var shared : Request = Request()
    
    var holiday: [String: [String : Any]]?

    func getHoliday(_ date: String) {
        MeshManager.shared.requestWithConfig { (config) in
            config.URLString = "https://timor.tech/api/holiday/year/\(date)/"
            config.requestMethod = .get
        } success: { (config) in

            guard let data : [String: Any] = config.response?.value as? [String : Any] else {
                return
            }
            self.holiday = data["holiday"] as? [String : [String : Any]]
            
        } failure: { (_) in
            print("error getHoliday")
        }
    }

    func getInfo(_ date: String) -> Holiday?{
        guard let dic = holiday  else {
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
}

struct Holiday: Codable {
    var holiday: Bool?
    var name : String?
    var wage : Int?
    var after: Bool?
    var target: String?
    var date : String?
}
