//
//  API.Call.swift
//  SnowSensei
//
//

import Foundation

extension API
{
    public static func callApiPOST(strUrl: String, parameter: NSDictionary, success: ((NSDictionary) -> Void)?, error: ((NSError) -> Void)?)
    {
//        let custObj: customClassViewController = customClassViewController()
//        if custObj.checkInternet() == false
//        {
//            
//        }
        manager?.post(strUrl, parameters: parameter,
                      success: { (op, response) -> Void in
                        
//                        let datastring = String.init(data: response as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//                        
//                        print(datastring)
                        let dict: NSDictionary!
                        dict = response as! NSDictionary
                        success? (dict)
        },failure: { (op, fault) -> Void in
            print(fault ?? 0)
            error?(fault! as NSError)
            SVProgressHUD.dismiss()
        })
    }
    
    
    public static func callApiPostWithImage(strUrl: String, parameter: NSDictionary, imageData : NSData , success: ((NSDictionary) -> Void)?, error: ((NSError) -> Void)?)
    {
//        //let custObj: customClassViewController = customClassViewController()
//        if custObj.checkInternet() == false
//        {
//            
//        }
        
        manager?.post(strUrl, parameters: parameter, constructingBodyWith: {(formData: AFMultipartFormData?) -> Void in
            formData?.appendPart(withFileData: imageData as Data!, name: "fileupload", fileName: "fileupload.png", mimeType: "image/png")
        }, success: { (op, response) -> Void in
            
            let dict: NSDictionary!
            dict = response as! NSDictionary
            success? (dict)
        },failure: { (op, fault) -> Void in
            print(fault ?? 0)
            SVProgressHUD.dismiss()
        })
        
    }
    
    
    public static func callApiGET(strUrl: String, parameter: NSDictionary, success: ((NSDictionary) -> Void)?, error: ((NSError) -> Void)?)
    {
//        let custObj: customClassViewController = customClassViewController()
//        if custObj.checkInternet() == false
//        {
//            
//        }
        manager?.get(strUrl, parameters: parameter,
                      success: { (op, response) -> Void in
                        
                        let dict: NSDictionary!
                        dict = response as! NSDictionary
                        success? (dict)
        },failure: { (op, fault) -> Void in
            print(fault ?? 0)
            error?(fault! as NSError)
            SVProgressHUD.dismiss()
        })
    }
    
}
