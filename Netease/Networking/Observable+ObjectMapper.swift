//
//  Observable+ObjectMapper.swift
//  Netease
//
//  Created by user on 2017/8/16.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import ObjectMapper

extension Response {

    // 这一个主要是将JSON解析为单个的Model
    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
        guard let object = Mapper<T>().map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    /*
    // 这个主要是将JSON解析成多个Model并返回一个数组，不同的json格式写法不相同
    public func mapArray<T: BaseMappable>(_ type: T.Type) throws -> [T] {
        let json = JSON(data: self.data)
        let jsonArray = json["data"]["data"]
        
        guard let array = jsonArray.arrayObject as? [[String: Any]],
            let objects = Mapper<T>().mapArray(JSONArray: array) else {
                throw MoyaError.jsonMapping(self)
        }
        return objects
    }*/
}

extension ObservableType where E == Response {
    // 这个是将JSON解析为Observable类型的Model
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        }
    }
    
    // 这个是将JSON解析为Observable类型的[Model]
//    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
//        return flatMap { response -> Observable<[T]> in
//            return Observable.just(try response.mapArray(T.self))
//        }
//    }
}
