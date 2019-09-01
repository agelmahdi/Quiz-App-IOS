//
//  ResultViewController.swift
//  Quiz App IOS
//
//  Created by Ahmed El-Mahdi on 8/28/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import UIKit

protocol ResultViewControllerProtocol {
    func resultViewedismissed()
}
class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedBackLabel: UILabel!
    
    @IBOutlet weak var dissmissBtn: UIButton!
    
    @IBOutlet weak var dialogeView: UIView!
    var delegate : ResultViewControllerProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dialogeView.layer.cornerRadius = 10
    }
    func displayPopup(withTitle: String, withMassage: String , withAction: String ){
        resultLabel.text = withTitle
        feedBackLabel.text = withMassage
        dissmissBtn.setTitle(withAction, for: .normal)
        
    }
    @IBAction func dismissTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: {
            self.resultLabel.text = ""
                    self.feedBackLabel.text = ""
        })
        delegate?.resultViewedismissed()
    }
    
    
    
}
