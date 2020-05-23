//
//  BaseApi.swift
//  Magic Recipe
//
//  Created by Apple on 12/04/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import Foundation
import Alamofire

class BaseApi {
   

    static let shared = BaseApi()
  
 
    func getTypeURLSession(_ i: String?, _ q: String?, _ p : Int? ,outputBlock:@escaping(_ result : AnyObject, _ responseCode: Int) -> Void){
    
    let session = URLSession.shared
    let url = URL(string:"http://www.recipepuppy.com/api/?i=\(i ?? "")&q=\(q ?? "")&p=\(p ?? 1)" )!

    let task = session.dataTask(with: url) { data, response, error in

        if error != nil || data == nil {
            print("Client error!")
            return
        }

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("Server error!")
            return
        }


        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
           
            outputBlock(json as AnyObject, 1)
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
        
        
        
    }

    task.resume()
    
}
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseRecipes(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Recipes>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}


