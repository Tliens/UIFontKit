//
//  UIKitRegister.swift
//  UIFontKit
//
//  Created by Quinn on 2019/3/5.
//  Copyright © 2019 Quinn. All rights reserved.
//

import UIKit
class UFRegister: NSObject {
    
    
    class func registerFont()throws{
        
        func register(array:[String])throws{
            for path in array{
                let url = UF().downloadFolder.appendingPathComponent(path)
                
                do{
                    try UIFont.register(url: url)
                }catch{
                    throw(error)
                }
            }
        }
        
        let fontFloder = UF().downloadFolder
        do{
            let array = try FileManager.default.contentsOfDirectory(atPath: fontFloder.path)
            try register(array: array)
        }catch{
            throw(error)
        }
    }
    
    class func registerFontByURL(_ url:URL)throws{
        do{
            try UIFont.register(url: url)
        }catch{
            throw(error)
        }
    }
    
}
extension String: Error {}
extension UIFont {
    static func register(url: URL) throws {
        
        guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
            throw "Could not create font data provider for \(url)."
        }
        #if swift(>=4.0)
        guard let font = CGFont(fontDataProvider) else {
            throw "Could not create font for \(url)."
        }
        #else
        let font = CGFont(fontDataProvider)
        #endif
        debugPrint(#function,font.fullName ?? "error")
        var error: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(font, &error) else {
            throw error!.takeUnretainedValue()
        }
    }
}
