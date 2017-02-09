//
//  Networking.swift
//  xtract
//
//  Created by Harry Merzin on 2/5/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    static func getTextForImage(image: Data, completion: @escaping (_ error: Error?, _ array: [String]?) -> Void) {
        var request = URLRequest(url: URL(string: "https://westus.api.cognitive.microsoft.com/vision/v1.0/ocr?detectOrientation=true")!)
        request.setValue(Constants.apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = image
        Alamofire.request(request).responseData(completionHandler: {response in
            print(response.data ?? "no dataz")
            var parsedResult: Any
            if (response.result.error != nil) {
                completion(response.result.error, nil)
            }
            do {
                parsedResult = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                print(parsedResult)
                completion(nil, self.getStrings(data: parsedResult as! [String: AnyObject]))
            } catch let error as NSError {
                print(error)
            }
        })
        
    }
    
    static func getStrings(data: [String: AnyObject]) -> [String] {
        var wordsArray = [String]()
        (data["regions"] as! [[String: AnyObject]]).forEach({(region) in
            let lines = region["lines"] as! [[String: AnyObject]]
            lines.forEach({line in
                let words = line["words"] as! [[String: AnyObject]]
                words.forEach({word in
                    wordsArray.append(word["text"] as! String)
                })
            })
            
        })
        return wordsArray
    }
    
}
