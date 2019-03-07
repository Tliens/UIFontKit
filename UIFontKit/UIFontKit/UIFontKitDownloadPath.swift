//
//  UIFontKitDownloadPath.swift
//  UIFontKit
//
//  Created by Quinn on 2019/3/5.
//  Copyright © 2019 Quinn. All rights reserved.
//

import UIKit
import Foundation
import CommonCrypto
class UF: NSObject {
    var downloadFolder: URL{
        let library = FileManager.default.urls(for: .allLibrariesDirectory, in: .userDomainMask).first!
        let folder = library.appendingPathComponent("UIFontKit")
        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
        }
        return folder
    }
    private var localPath:URL{
        let md5 = urlPath.md5
        return downloadFolder.appendingPathComponent("\(md5).\(ofType)")
    }
    private var ofType:String = "ttf"
    private var urlPath:String = "UIFontKit"

    func getNewPath(urlPath:String,ofType:String?)->URL{
        if let _ofType = ofType {
            self.ofType = _ofType
        }else{
            let type = urlPath.components(separatedBy: ".").last
            assert(type != nil)
            self.ofType = type!
        }
        self.urlPath = urlPath
        return localPath
    }
}

extension String{
    var md5: String {
        
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
}
