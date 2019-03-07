//
//  UIFontKitDownloader.swift
//  UIFontKit
//
//  Created by Quinn on 2019/3/5.
//  Copyright © 2019 Quinn. All rights reserved.
//

import UIKit

class UFDownloader: NSObject {
    class func down(urlPath:String,handler:((_ error:Error?,_ local:URL,_ url:String)->Void)? = nil){
        let localPath = UF().getNewPath(urlPath: urlPath, ofType: nil)
        if FileManager.default.isExecutableFile(atPath: localPath.path){
            handler?(nil,localPath,urlPath)
            return
        }
        let url = URL.init(string: urlPath)
        let urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
        let task = urlSession.dataTask(with: url!) {(data, response, error) in
            if error != nil{
                handler?(error,localPath,urlPath)
            }else{
                do{
                    try data?.write(to: localPath)
                    handler?(nil,localPath,urlPath)
                }catch{
                    handler?(error,localPath,urlPath)
                }
            }
            
        }
        task.resume()
    }
    
}
