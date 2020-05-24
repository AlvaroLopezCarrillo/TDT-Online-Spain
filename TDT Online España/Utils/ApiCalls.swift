//
//  ApiCalls.swift
//  TDT Online España
//
//  Created by Álvaro López Carrillo on 14/01/2020.
//  Copyright © 2020 Iberian Apps. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiCalls{
    
    static let URL_DATA = "http://www.tdtchannels.com/lists/channels.json"
    
    
    static func loadChannels(completionHandler:@escaping (_ result: [Channel], _ errorCode: Int?) -> Void){
        var allChannels = [Channel]()
        
        AF.request(URL_DATA, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            
            switch response.result{
            case .success:
          
                let countries = JSON(response.value!)["countries"].array
                for country in countries!{
                    if(country["name"].stringValue == "Spain"){
                        
                        let ambits = country["ambits"].array //Categories
                        for ambit in ambits!{
                            
                            let channels = ambit["channels"].array //Channels inside categories
                            for channel in channels! {
                                let urlChannel = channel["options"].array!.isEmpty ? "" : channel["options"].array![0]["url"].stringValue
                                // Only channels with url and M3U8 format
                                guard channel["options"][0]["format"] == "m3u8", urlChannel != "" else {
                                    continue
                                }
                                //Only channels with url
                                allChannels.append(Channel(name: channel["name"].stringValue, logo: channel["logo"].stringValue, url: urlChannel))
                            }
                            
                        }
                        
                    }
                }
                
                completionHandler(allChannels,response.response?.statusCode)
            case .failure:
                completionHandler(allChannels,response.response?.statusCode)
            }
    
        }
    }
    
}
