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
    
    static let URL_DATA = "https://www.tdtchannels.com/lists/tv.json"
    
    
    
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
                                
                                let options = channel["options"].array
                                for option in options! {
                                    if(option["format"].stringValue == "m3u8"){
                                        //Only channels with url m3u8
                                        allChannels.append(Channel(name: channel["name"].stringValue, logo: channel["logo"].stringValue, url: option["url"].stringValue))
                                        break
                                    }
                                }
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
