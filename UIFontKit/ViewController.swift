//
//  ViewController.swift
//  UIFontKit
//
//  Created by Quinn on 2019/3/5.
//  Copyright © 2019 Quinn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabel2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //AppDelegate中启动UIFontKitManager.shared.register() 则会从本地缓存文件中注册地址,无需重新下载
        self.textLabel.font = UIFont.init(name: "DFFunnyEnglish", size: 18)
        self.textLabel2.font = UIFont.init(name: "LcdD", size: 18)

        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ///download font  下载字体
        
        let dic = ["https://github.com/quinn0809/QuinnDemo/raw/master/zzztest.ttf"  :"DFFunnyEnglish",
                   "https://github.com/quinn0809/QuinnDemo/raw/master/lccd.TTF"     :"LcdD"]
        
        let url1:String = "https://github.com/quinn0809/QuinnDemo/raw/master/zzztest.ttf"
        let url2:String = "https://github.com/quinn0809/QuinnDemo/raw/master/lccd.TTF"

        let path = [url1,url2]
        
        UIFontKitManager.shared.register(paths: path) { (error, local, url) in
            if let name = dic[url],url == url1{
                DispatchQueue.main.async {
                    self.textLabel.font = UIFont.init(name: name, size: 18)
                }
            }
            if let name = dic[url2],url == url2{
                DispatchQueue.main.async {
                    self.textLabel2.font = UIFont.init(name: name, size: 18)
                }
            }
        }
        
    }


}

