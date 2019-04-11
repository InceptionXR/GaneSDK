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
    func onViewReady(_ view: UIViewController)
    //   var view : UIViewController { get set } ;
}



public class Gane  : NSObject , GaneViewDelegate {
    
    weak public var ganeDelegate: GaneDelegate?

    public func onViewReady(_ view: GaneViewController) {
        ganeDelegate?.onViewReady(view as UIViewController);
    }
    
    public func onError(_ text: String) {
        
    }
    
    public func onDownloadProgress(_ progress: Float) {
        
    }
    

    
    var arContoller : GaneViewController? = nil
    
    let token: String ;
    let serverURL = "https://osiris.stage.bookful.inceptionxr.com/v1/experiences/my?";
    
   var experiences:[Experience]?;

    public init(token: String , ganeDelegate: GaneDelegate) {
        self.ganeDelegate = ganeDelegate;
        self.token = token;
        super.init()
        }
    
    public func getExperiences(completionHandler: @escaping (_ experiences: [Experience]?, _ error: Error?) -> Void ) {
    
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
                self.experiences = userResponce.experiences;
                
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
        self.arContoller = GaneViewController();
        self.arContoller!.playExperience( experienceToPlay: experience ,ganeViewDelegate: self)
        self.arContoller!.loadViewIfNeeded();

    }
    
}


