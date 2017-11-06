//
//  ViewController.swift
//  Statful
//
//  Created by Rattee Wariyawutthiwat on 11/6/2560 BE.
//  Copyright © 2560 Rattee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Stateful {

    var currentStatus: StatefulStatus = .content
    
    var loadingView: UIView?
    
    var emptyView: UIView?
    
    var errorView: UIView?
    
    @IBOutlet weak var contentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialStatefulView()
    }
    
    func initialStatefulView() {
        loadingView = UINib(nibName: "LoadingTest", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        emptyView = UINib(nibName: "EmptyTest", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        errorView = UINib(nibName: "ErrorTest", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        show(state: .loading)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loading() {
        show(state: .loading)
    }
    
    @IBAction func empty() {
        show(state: .empty)
    }
    
    @IBAction func content() {
        show(state: .content)
    }
    
    @IBAction func error() {
        show(state: .error)
    }
}

