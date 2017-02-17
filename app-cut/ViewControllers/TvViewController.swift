//
//  TvViewController.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 17/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit
import SWRevealViewController

class TvViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let link: String = "http://tv.cut.org.co/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Remove the uppon bar inside the WebView
        self.automaticallyAdjustsScrollViewInsets = false
        
        loadWeb(link: self.link)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWeb(link:String){
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        lblLoading.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
