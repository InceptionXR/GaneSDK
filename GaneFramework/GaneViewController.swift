//
//  GaneViewController.swift
//  GaneFramework
//
//  Created by John MAClovich on 11/04/2019.
//  Copyright © 2019 Inception. All rights reserved.
//

import Foundation
import UIKit
import WA3DLib

public protocol GaneViewDelegate : class {
    func onViewReady(_ view: GaneViewController)
    func onError(_ text: String)
    func onDownloadProgress(_ progress: Float)
    //   var view : UIViewController { get set } ;
}

public class GaneViewController: ARViewController, WADownloadDelegate, WAEngineDelegate {
   
    weak public var ganeViewDelegate: GaneViewDelegate?
    var psManager : WAPublishServerManager? = nil;
    var experienceToPlay: Experience?;
    
    public func playExperience ( experienceToPlay: Experience ,ganeViewDelegate: GaneViewDelegate)
    {
        self.ganeViewDelegate = ganeViewDelegate;

        self.experienceToPlay = experienceToPlay;
        
        NSLog("GaneViewController playExperience");

    }
    
    
  public  func downloadStarted(_ url: String!) {
        NSLog("Download Started");
    }
    
  public  func downloadProgress(_ url: String!, _ progress: Float) {
        ganeViewDelegate?.onDownloadProgress(progress);
        NSLog("Download Progress: %f", progress);
    }
    
  public  func downloadComplete(_ url: String!, _ localPath: String!, _ fromCache: Bool) {
        NSLog("Download Completed");
        loadProject(localPath);
    }
    
public func downloadError(_ url: String!, _ errorMessage: String!) {
        NSLog("Error for url: %@ message: %@", url, errorMessage);
    }
    
  public  func searchComplete(_ results: [Any]!) {
        
    }
    
    //Happens once a project is loaded
    public func onProjectLoaded(_ loadSuccessful: Bool, _ projectName: String!, _ projectFilepath: String!, _ trackType: String!) {
        if(loadSuccessful) {
            NSLog("Project %@ loaded successfully", projectName);
        }
    }
    
   public  func onSceneLoaded(_ loadSuccessful: Bool,_ targetImageBytes: Data!) {
        if(loadSuccessful) {
            NSLog("Scene loaded successfully");
            self.ganeViewDelegate?.onViewReady(self);
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setDelegate(self); // so that OnProjectLoaded/OnSceneLoaded will be called
        self.psManager = WAPublishServerManager.instance() as! WAPublishServerManager;
        self.psManager?.setDelegate(self); // so that all download functions will be called
        
        if (experienceToPlay != nil){
            psManager?.downloadOrLoadProject(experienceToPlay!.assetURL);
        }
        NSLog("GaneViewController loaded successfully");

 
    }
    
   public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    
}

