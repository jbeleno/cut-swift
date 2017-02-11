//
//  NoticiaViewController.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 11/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit

class NoticiaViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var lblLoading: UILabel!
    
    var link: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the uppon bar inside the WebView
        self.automaticallyAdjustsScrollViewInsets = false

        loadWeb(link: self.link)
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
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
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
