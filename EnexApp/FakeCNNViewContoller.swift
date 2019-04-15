

//
//  FakeCNN.swift
//  GaneExample
//
//  Created by John MAClovich on 15/04/2019.
//  Copyright © 2019 Inception. All rights reserved.
import Foundation
import UIKit
import GaneFramework
import WA3DLib


class FakeCNNViewContoller: UIViewController , GaneDelegate {
    
    var experiences: [Experience] = [Experience] ();
    var gane: Gane?;
   // var arController: GaneViewController?;
   // var arView: UIView?;

    func ShowExperienceAtIndex (id: Int){
        print ("ShowExperienceAtIndex ");
        self.gane?.showExperience (experience: self.experiences[id] ,delegate : self)
        showLoadingUI(active: true);

    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.gane = Gane(token: userToken , ganeDelegate: self);
        self.gane?.getExperiences() { experiences, error in
            self.experiences = experiences!
        }
    }
    override open var shouldAutorotate: Bool {
        return false;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    override public func viewDidAppear(_ animated: Bool){
       // arController = nil;
       // arView = nil;
    }
    func onDownloadProgress(_ progress: Float) {
        print ("Downloading " , progress);
    }
    
    func onError(_ text: String) {
        print("onError " , text);
        showLoadingUI(active: false);
    }
    
    func onViewReady(_ view: GaneViewController) {
        print("onViewReady ");
       // arController = view;
      //  arView = arController!.view;
        self.present(view, animated: false, completion: nil)
        showLoadingUI(active: false);
    }
    @IBAction func btnTopTapped(_ sender: UIButton) {
        print ("btnTopTapped ");
        if (experiences.count > 0 ){
            ShowExperienceAtIndex(id: 0);
        }
    }
    @IBAction func btnBottomTapped(_ sender: UIButton) {
        NSLog ("btnBottomTapped ");
        if (experiences.count > 0 ){
            ShowExperienceAtIndex(id: 1);
        }
    }
    
    
    var strLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView()
    func showLoadingUI(active: Bool){
        if (active){
             activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            //activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
            activityIndicator.frame = self.view.frame;
            activityIndicator.center =  self.view.center;
            activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
            activityIndicator.startAnimating()
            
            view.addSubview(activityIndicator);
            
             strLabel = UILabel(frame: CGRect(x: 0, y: 0, width:  self.view.frame.maxX, height:  self.view.frame.maxY - 100 ))
            strLabel.textAlignment = .center
            strLabel.text = "Loading"
            strLabel.font = .systemFont(ofSize: 40, weight: UIFont.Weight.medium)
            strLabel.textColor = UIColor(white: 0.7, alpha: 1)
            view.addSubview(strLabel);
        }else{
            activityIndicator.removeFromSuperview();
            strLabel.removeFromSuperview();
        }
    }
}

