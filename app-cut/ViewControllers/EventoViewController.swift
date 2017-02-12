//
//  EventoViewController.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 11/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class EventoViewController: UIViewController {
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let linkEvento = "http://52.27.16.14/cut/eventos/detalle"
    var eventIdentifier: String = ""
    let paramOK = "OK"
    let paramStatus = "status"
    let paramIdEvento = "idEvento"
    let paramEvento = "evento"
    let errorMessage = "Por favor, verifica tu conexión a internet."

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarNoticia()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargarNoticia() {
        
        let params = [
             paramIdEvento: self.eventIdentifier
        ]
        
        Alamofire.request(linkEvento, method: .post, parameters: params).responseJSON{
            response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                if let status = response.object(forKey: self.paramStatus) as? String{
                    if status == self.paramOK {
                        
                        let evento = response.object(forKey: self.paramEvento) as! NSDictionary
                        
                        self.lblTitle.text = evento.object(forKey: "titulo") as! String?
                        self.lblTitle.sizeToFit()
                        self.lblDescription.text = evento.object(forKey: "descripcion") as! String?
                        self.lblDescription.sizeToFit()
                        
                        let url_img = URL(string: (evento.object(forKey: "imagen") as! String?)!)
                        let placeholderImage = UIImage(named: "img_placeholder")!
                        if(url_img != nil){
                            self.imgThumbnail.af_setImage(withURL: url_img!, placeholderImage: placeholderImage)
                        }
                        
                        let  htmlTextAgenda = evento.object(forKey: "agenda") as! String?
                        let htmlStyle = "<style>html, body{font-family: Helvetica, Verdana, Arial;color: #555555; font-size:14px;margin:0; padding:0;}</style>"
                        let htmlText = "<html> \(htmlStyle) <body> \(htmlTextAgenda) </body></html>"
                        
                        if let htmlData = htmlText.data(using: String.Encoding.unicode) {
                            do {
                                let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                                self.lblSchedule.attributedText = attributedText
                                self.lblSchedule.sizeToFit()
                            } catch let e as NSError {
                                print("Couldn't translate \(htmlText): \(e.localizedDescription) ")
                            }
                        }
                        
                        
                        // Hack from http://stackoverflow.com/a/38408928
                        /*var contentRect = CGRect.zero
                        for view in self.scrollView.subviews {
                            contentRect = contentRect.union(view.frame)
                            print(contentRect.size.height)
                        }*/
                        
                        // Custom Hack: Machete: Gambiarra
                        var contentRect = CGRect.zero
                        contentRect.size.width = self.view.frame.size.width
                        contentRect.size.height += self.imgThumbnail.frame.size.height
                        contentRect.size.height += self.lblTitle.frame.size.height
                        contentRect.size.height += self.lblDescription.frame.size.height
                        contentRect.size.height += self.lblSchedule.frame.size.height
                        contentRect.size.height += 16 + 8 + 8 + 8 + 8 + 21
                        
                        self.scrollView.contentSize = contentRect.size
                        
                    }else {
                        self.lblTitle.text = self.errorMessage
                    }
                }else {
                    self.lblTitle.text = self.errorMessage
                }
            case .failure:
                self.lblTitle.text = self.errorMessage
            }
        };
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
