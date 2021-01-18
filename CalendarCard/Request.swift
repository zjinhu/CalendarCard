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

class Request: ObservableObject {
    
    @Published var holiday: HolidayResult?

    func getHoliday(_ date: String) {
        MeshManager.shared.requestWithConfig { (config) in
            config.URLString = "https://timor.tech/api/holiday/info/" + date
            config.requestMethod = .get
        } success: { (config) in
            let decoder = JSONDecoder()
            guard let data = config.responseData, let model = try? decoder.decode(HolidayResult.self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                // 更新我们的UI
                self.holiday = model
            }
        } failure: { (_) in
            print("error getHoliday")
        }
    }

}

struct HolidayResult: Codable  {
    var holiday: Holiday?
    var type: HolidayType?
    var code : Int?
}

struct HolidayType: Codable  {
    var type: Int?
    var name : String?
    var week : Int?
}

struct Holiday: Codable {
    var holiday: Bool?
    var name : String?
    var wage : Int?
    var after: Bool?
    var target: String?
    var date : String?
}
