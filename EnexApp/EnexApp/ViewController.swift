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

let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoic2RrX3Rva2VuIiwidXNlcl9pZCI6Ikd0RUhNbXpYWiIsImNyZWF0ZWQiOjE1NTQ4ODk5MzA0OTMsImp0aSI6InZ4XzN6UVJsUSIsImlhdCI6MTU1NDg4OTkzMCwiZXhwIjo3ODY2NDA5OTMwLCJpc3MiOiJPc2lyaXMifQ.2GXMdPFO0ZAZ2ds3imfGOitxvnjZxYKo5-yfGqNDgrs"

class ViewController: UITableViewController , GaneDelegate {
    
    var experiences: [Experience] = [Experience] ();
    var gane: Gane? = nil;

    func onDownloadProgress(_ progress: Float) {
        print ("Downloading " , progress);
    }
    
    func onError(_ text: String) {
        print("onError " , text);
    }
    
    func onViewReady(_ view: GaneViewController) {
        view.view.alpha = 1
        view.view.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.gane = Gane(token: userToken , ganeDelegate: self);
        self.gane?.getExperiences() { experiences, error in // this shit is async
            
            for ex in experiences!
            {
                print(ex.name);
            }
            
            self.experiences = experiences!
            self.tableView.delegate = self;
            self.tableView.reloadData();
        }
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
