//
//  TambahViewController.swift
//  ResepBangoAppiOS
//
//  Created by SMK IDN MI on 11/17/17.
//  Copyright © 2017 Djoendhie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TambahViewController: UIViewController {
    @IBOutlet weak var etResep: UITextField!
    @IBOutlet weak var etWaktu: UITextField!
    @IBOutlet weak var etOrang: UITextField!
    @IBOutlet weak var etHarga: UITextField!
    @IBOutlet weak var etBahan: UITextField!
    @IBOutlet weak var etCara: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    @IBAction func btnDaftar(_ sender: Any) {
        let nilaiResep = etResep.text
        let nilaiWaktu = etWaktu.text
        let nilaiOrang = etOrang.text
        let nilaiHarga = etHarga.text
        let nilaiBahan = etBahan.text
        let nilaiCara = etCara.text
        
        //cek widget kosong
        if ((nilaiResep?.isEmpty)! || (nilaiWaktu?.isEmpty)! || (nilaiOrang?.isEmpty)! || (nilaiHarga?.isEmpty)! || (nilaiBahan?.isEmpty)! || (nilaiCara?.isEmpty)!){
            
            //muncul apakah dialog
            let alertWarning = UIAlertController(title: "Warning", message: "this is require", preferredStyle: .alert)
            let aksi = UIAlertAction(title: "ok", style: .default, handler: nil)
            alertWarning.addAction(aksi)
            present(alertWarning, animated: true, completion: nil)
        }else{
            //apabila widget tdk kosong
            // membuat parameter intuk d simpan ke data base
            let params = ["nama" : nilaiResep!, "waktu" : nilaiWaktu!, "Orang" : nilaiOrang!, "harga" : nilaiHarga!, "bahan" : nilaiBahan!, "cara" : nilaiCara]
            // mencetak nilai params yg d kirim
            print(params)
            
            let url = "http://localhost/Bango/index.php/api/getTambah"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseServer) in
                
                print(responseServer.result.isSuccess)
                
                if responseServer.result.isSuccess{
                    let json = JSON(responseServer.result.value as Any)
                    
                    //muncul alert dialog
                    let alertWarning = UIAlertController(title: "congrats", message: "data tersimpan", preferredStyle: .alert)
                    let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertWarning.addAction(aksi)
                    self.present(alertWarning, animated: true, completion: nil)
                    
                    
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
