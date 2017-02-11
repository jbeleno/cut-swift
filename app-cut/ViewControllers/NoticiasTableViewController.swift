//
//  NoticiasTableViewController.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 7/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit
import SWRevealViewController
import SwiftyJSON
import Alamofire
import AlamofireImage

class NoticiasTableViewController: UITableViewController {

    // Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var lblMsg: UILabel!
    
    var model = NoticiasModel()
    let cellIdentifier = "NoticiaCell"
    let segueIdentifier = "NoticiaSegue"
    var link: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Desliza hacia abajo para actualizar")
        self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
        self.lblMsg = UILabel( frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        lblMsg.textAlignment    = NSTextAlignment.center;
        
        // Load data for first time
        model.populateWithDataSource(table: self.tableView, lblMessage: lblMsg)
        
        // Row sizes in the tableView
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh(sender:AnyObject)
    {
        model.clearDataSource(table: self.tableView)
        model.populateWithDataSource(table: self.tableView, lblMessage: self.lblMsg)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.model.datasource.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (model.datasource.count - 1){
            model.populateWithDataSource(table: self.tableView, lblMessage: self.lblMsg)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoticiaTableViewCell
        
    
        let NoticiaItem = self.model.datasource.object(at: indexPath.row)
        print(NoticiaItem)
        let Noticia = NoticiaListItem(json: JSON(NoticiaItem))
        
        cell.lblTitle.text = Noticia!.titulo
        cell.lblTitle.sizeToFit()
        cell.lblTime.text = Noticia!.tiempo
        
        print(Noticia!.imagen)
        let url_img = URL(string: Noticia!.imagen)
        let placeholderImage = UIImage(named: "img_background")!
        if(url_img != nil){
            cell.imgThumbnail.af_setImage(withURL: url_img!, placeholderImage: placeholderImage)
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
