//
//  Gane.swift
//  EnexApp
//
//  Created by John MAClovich on 07/04/2019.
//  Copyright © 2019 Inception. All rights reserved.
//

import UIKit
import Foundation
import WA3DLib


public protocol GaneDelegate : class {
    func onError(_ text: String)
    func onDownloadProgress(_ progress: Float)
    func onViewReady(_ view: GaneViewController)
    //   var view : UIViewController { get set } ;
}



public class Gane  : NSObject , GaneViewDelegate {
    
    weak public var ganeDelegate: GaneDelegate?

    public func onViewReady(_ view: GaneViewController) {
        DispatchQueue.main.async {
            
            self.ganeDelegate?.onViewReady(view);
            
        }
        
    }
    
    public func onError(_ text: String) {
        
    }
    
    public func onDownloadProgress(_ progress: Float) {
        
    }
    

    
    var arContoller : GaneViewController? = nil
    
    let token: String ;
    let serverURL = "https://osiris.stage.bookful.inceptionxr.com/v1/sdk/experiences/all";
    
   var experiences:[Experience]?;

    public init(token: String , ganeDelegate: GaneDelegate) {
        self.ganeDelegate = ganeDelegate;
        self.token = token;
        super.init()
        }
    
    public func getExperiences(completionHandler: @escaping (_ experiences: UserResponce?, _ error: Error?) -> Void ) {
    
    let url = URL(string: serverURL)!
    var request = URLRequest(url:  url)
    request.setValue(token, forHTTPHeaderField: "access_token" )
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if error != nil
        {
            print(error!)
        } else {
            do {
                let userResponce = try JSONDecoder().decode(UserResponce.self, from:data!)
                self.experiences = userResponce
                
                DispatchQueue.main.async {
                    completionHandler(self.experiences, nil)
                }

            } catch let error as NSError {
                print(error)
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
        }.resume()
    
        }
    
    public func showExperience(experience: Experience , delegate: GaneDelegate){
        
        
        NSLog("Gane showExperience ");

        if (self.arContoller != nil){
            
            self.arContoller?.dismiss(animated:false, completion: {() -> Void in
                
                self.afterViewIsDead(experience:experience)
            }
            )
            self.arContoller?.view.removeFromSuperview()

        }else{
        afterViewIsDead(experience: experience) ;
        }
        
       
    }
    
    
    
    func afterViewIsDead(experience: Experience ) {
        let window = UIApplication.shared.keyWindow!

        self.arContoller = GaneViewController();
        self.arContoller!.playExperience( experienceToPlay: experience ,ganeViewDelegate: self)
        // self.arContoller!.loadViewIfNeeded();
        //  let v = UIView(frame: window.bounds)
        window.addSubview(self.arContoller!.view);
        self.arContoller?.view.frame = window.bounds
        self.arContoller?.view.alpha = 0
        self.arContoller?.view.isHidden = true
    }
    
}


