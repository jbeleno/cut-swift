//
//  ConsultarViewController.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 8/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit
import SWRevealViewController
import SwiftyJSON
import Alamofire

class ConsultarViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tvConsulta: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblMsg: UILabel!
    
    let linkConsulta = "https://cut.curubagram.com/cut/consultas/nueva"
    let paramOK = "OK"
    let paramStatus = "status"
    let paramCorreo = "correo"
    let paramMensaje = "mensaje"
    let errorMessage = "Error: Por favor, verifica tu conexión a internet e intenta de nuevo."
    let successMessage = "Consulta enviada con éxito, por favor aguarda por una respuesta"
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let color = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        self.tfEmail.layer.borderColor = color.cgColor
        self.tfEmail.layer.borderWidth = 1.0
        self.tfEmail.layer.cornerRadius = 2.0
        
        self.tvConsulta.layer.borderColor = color.cgColor
        self.tvConsulta.layer.borderWidth = 1.0
        self.tvConsulta.layer.cornerRadius = 2.0
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enviar(_ sender: Any) {
        
        if(self.flag){
            let params = [
                paramCorreo: self.tfEmail.text! as String,
                paramMensaje: self.tvConsulta.text! as String
            ]
        
            Alamofire.request(linkConsulta, method: .post, parameters: params).responseJSON{
                response in
                switch response.result {
                case .success(let JSON):
                
                    let response = JSON as! NSDictionary
                
                    if let status = response.object(forKey: self.paramStatus) as? String{
                        if status == self.paramOK {
                        
                            self.lblMsg.text = self.successMessage
                            self.tvConsulta.text = ""
                            self.tfEmail.text = ""
                        
                            self.flag = true
                        
                        }else {
                            self.lblMsg.text = self.errorMessage
                            self.flag = true
                        }
                    }else {
                        self.lblMsg.text = self.errorMessage
                        self.flag = true
                    }
                case .failure:
                    self.lblMsg.text = self.errorMessage
                    self.flag = true
                }
            };
        }
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
