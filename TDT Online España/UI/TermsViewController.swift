//
//  TermsViewController.swift
//  TDT Online España
//
//  Created by Álvaro López Carrillo on 27/03/2020.
//  Copyright © 2020 Iberian Apps. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var btnEnter: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "TERMS_ACCEPTED")
    }
    
    @IBAction func onClickEnter(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}
