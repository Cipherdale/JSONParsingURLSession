//
//  DataService.swift
//  JSONParsingURLSession
//
//  Created by Andrian Rahardja on 04/01/18.
//  Copyright © 2018 episquare. All rights reserved.
//

import UIKit

class DataService {
    
    static let shared = DataService()
    
    func getData(urlString: String, completion: @escaping (_ jsonObject: Any?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print("Failed to fetch data from server", err!.localizedDescription)
                completion(nil)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                completion(nil)
                return
            }
            print(responseData)
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                completion(json)
            } catch let jsonErr {
                print(jsonErr)
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
}
