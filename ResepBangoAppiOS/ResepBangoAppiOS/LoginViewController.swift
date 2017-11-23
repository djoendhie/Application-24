//
//  LoginViewController.swift
//  ResepBangoAppiOS
//
//  Created by SMK IDN MI on 11/17/17.
//  Copyright © 2017 Djoendhie. All rights reserved.
//

import UIKit
//import library
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    var arrkategori = [[String:String]]()
    
    @IBOutlet weak var etUserName: UITextField!
    @IBOutlet weak var etPassWord: UITextField!
    
    //deklarasi userDefauld  untuk menampung data agar ttp login
    var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
userDefaults = UserDefaults.standard
    }
    @IBAction func btnLogin(_ sender: Any) {
        let nilaiUser = etUserName.text!
        let nilaiPass = etPassWord.text!
        
        if ((nilaiUser.isEmpty) || (nilaiPass.isEmpty)) {
            
            //muncul apakah dialog
            let alertWarning = UIAlertController(title: "Warning", message: "this is require", preferredStyle: .alert)
            let aksi = UIAlertAction(title: "ok", style: .default, handler: nil)
            alertWarning.addAction(aksi)
            present(alertWarning, animated: true, completion: nil)
        }else{
            let params = ["email" : nilaiUser, "password" : nilaiPass]
            
            let url = "http://localhost/Bango/index.php/api/getlogin"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseServer) in
                
                print(responseServer.result.isSuccess)
                
                if responseServer.result.isSuccess{
                    let json = JSON(responseServer.result.value as Any)
                    
                    print(json)
                    let data = json["data"].dictionaryValue
                    let nUsername = data["username"]?.stringValue
                    let nEmail = data["email"]?.stringValue
                    
                    //menyimpan k sesi local
                    
                    self.userDefaults.setValue(nUsername, forKey: "USERNAME")
                    self.userDefaults.setValue(nEmail, forKey: "PASSWORD")
                    //untuk sinkronisasi data
                    self.userDefaults.synchronize()
                    
                    // pindah k layout welcome
                    let story = UIStoryboard.init(name: "Main" , bundle: Bundle.main)
                    let id = story.instantiateViewController(withIdentifier: "Welcome")
                    self.show(id, sender: self)
                    
                }
            })
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                        
                        let idStoryBoard = storyboard?.instantiateViewController(withIdentifier:"passKantau") as! ResepTableViewController
                        
                        let id_nama = arrkategori[indexPath.row] ["id_nama"]
                        // variable menampilkan nampung idkategori lempar
                        idStoryBoard.nampungId = id_nama
                        
                        show(idStoryBoard, sender: self)
                        
                    }
                    
             
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
