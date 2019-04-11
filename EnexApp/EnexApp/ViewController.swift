//
//  ViewController.swift
//  EnexApp
//
//  Created by John MAClovich on 08/04/2019.
//  Copyright © 2019 Inception. All rights reserved.
//

import UIKit
import GaneFramework
import WA3DLib


let oldUserToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoiYWRtaW4iLCJ1c2VyX2lkIjoiR3RFSE1telhaIiwiY3JlYXRlZCI6MTU1NDczNTQxMjY0NSwianRpIjoicGs5WFdpZTMwIiwiaWF0IjoxNTU0NzM1NDEyLCJleHAiOjE1NTczMjc0MTIsImlzcyI6Ik9zaXJpcyJ9.aS6QP5MN_vwydgLfv5tJCLhor3QBuXs0WCg31iR4JCw";

let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoic2RrX3Rva2VuIiwidXNlcl9pZCI6Ikd0RUhNbXpYWiIsImNyZWF0ZWQiOjE1NTQ4ODk5MzA0OTMsImp0aSI6InZ4XzN6UVJsUSIsImlhdCI6MTU1NDg4OTkzMCwiZXhwIjo3ODY2NDA5OTMwLCJpc3MiOiJPc2lyaXMifQ.2GXMdPFO0ZAZ2ds3imfGOitxvnjZxYKo5-yfGqNDgrs" ;



class ViewController: UITableViewController , GaneDelegate {
    
    var experiences: [Experience] = [Experience] ();
    var gane: Gane? = nil;

    func onDownloadProgress(_ progress: Float) {
        print ("Downloading " , progress);

    }
    
    
    func onError(_ text: String) {
        print("onError " , text);
    }
    
    
    func onViewReady(_ view: UIViewController) {
        
        NSLog("onViewReady");
        
       // let controller = storyboard!.instantiateViewController(withIdentifier: NSStringFromClass(view))
        addChild(view);
        self.view.addSubview(view.view);
        view.didMove(toParent: self)
        
        self.view.insertSubview(view.view, at: 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.gane = Gane(token: oldUserToken , ganeDelegate: self);
    
        self.gane?.getExperiences() { experiences, error in // this shit is async
            
            for ex in experiences!
            {
                print(ex.name);
            }
            
            self.experiences = experiences!
            self.tableView.delegate = self;
            self.tableView.reloadData();
          //  self.gane?.showExperience (experience: self.experiences[0] ,delegate : self)
            
        //    let psManager = WAPublishServerManager.instance() as! WAPublishServerManager;
         //   psManager.setDelegate(self); // so that all download functions will be called
         //   psManager.downloadOrLoadProject(experiences![0].assetURL);
        }
    }
    
    func switchToExperience() {
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.experiences.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let exp = self.experiences[indexPath.row]
        cell.textLabel?.text = exp.name;
        cell.detailTextLabel?.text = exp.assetURL;
      //  cell.imageView?.image = UIImage(named: headline.image)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
          self.gane?.showExperience (experience: self.experiences[indexPath.row] ,delegate : self)
        NSLog("clicked on \(self.experiences[indexPath.row].name)");
        return indexPath;

    }
    
    
   
}
