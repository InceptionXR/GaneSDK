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
    let backBtn = UIButton();

    public func playExperience ( experienceToPlay: Experience ,ganeViewDelegate: GaneViewDelegate)
    {
        self.ganeViewDelegate = ganeViewDelegate;
        self.experienceToPlay = experienceToPlay;
        NSLog("GaneViewController playExperience");
        if (isViewLoaded){
                NSLog("GaneViewController  downloadOrLoadProject");
                psManager?.downloadOrLoadProject(experienceToPlay.assetURL);
        }
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setDelegate(self); // so that OnProjectLoaded/OnSceneLoaded will be called
        self.psManager = WAPublishServerManager.instance() as! WAPublishServerManager;
        self.psManager?.setDelegate(self); // so that all download functions will be called
        
        if (experienceToPlay != nil){
            NSLog("GaneViewController loaded experienceToPlay");
            psManager?.downloadOrLoadProject(experienceToPlay!.assetURL);
        }
        NSLog("GaneViewController loaded successfully");
    }
    override public func viewDidAppear(_ animated: Bool){
        // add back button that gets removed all the time
        backBtn.frame = CGRect(x: self.view.bounds.size.width - 160, y: 10, width: 150, height: 50)
        backBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        backBtn.setTitle("Back", for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        view.addSubview(backBtn)
    }
    @objc func backBtnAction(sender: UIButton!) {
        print("Back Btn tapped")
        dismiss(animated: false, completion: nil)
        unloadCurrentProject();
    }
   public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

