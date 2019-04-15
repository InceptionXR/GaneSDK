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

let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoic2RrX3Rva2VuIiwidXNlcl9pZCI6Il9qVHFST3E2QiIsImNyZWF0ZWQiOjE1NTQ5OTgyODY5NjEsImp0aSI6IjdzaUd2LTBVYyIsImlhdCI6MTU1NDk5ODI4NiwiZXhwIjo3ODY2NTE4Mjg2LCJpc3MiOiJPc2lyaXMifQ.7sISp6H9zDRz2cZSerpL126f_hSRBKQS8UuK1fPitys"

class ExperiencesTableViewController: UITableViewController , GaneDelegate {
    
    var experiences: [Experience] = [Experience] ();
    var gane: Gane?;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.gane = Gane(token: userToken , ganeDelegate: self);
        self.gane?.getExperiences() { experiences, error in
            self.experiences = experiences!
            self.tableView.delegate = self;
            self.tableView.reloadData();
        }
    }
    
    func onDownloadProgress(_ progress: Float) {
        print ("Downloading " , progress);
    }
    
    func onError(_ text: String) {
        print("onError " , text);
    }
    
    func onViewReady(_ ganeController: GaneViewController) {
        ganeController.view.alpha = 1
        ganeController.view.isHidden = false
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
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.gane?.showExperience (experience: self.experiences[indexPath.row] ,delegate : self)
        NSLog("clicked on \(self.experiences[indexPath.row].name)");
        return indexPath;
    }
}
