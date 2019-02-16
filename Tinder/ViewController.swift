//
//  ViewController.swift
//  Tinder
//
//  Created by 原田悠嗣 on 2019/02/15.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var basicCard: UIView!

    var centerOfCard:CGPoint!




    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
    }

  
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {

        let card = sender.view!

        let point = sender.translation(in: view)

        card.center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
    }
}

