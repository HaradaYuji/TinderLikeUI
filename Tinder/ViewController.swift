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

//        card.center = sender.location(in: self.view)

        let point = sender.translation(in: view)

        card.center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)

        if sender.state == UIGestureRecognizer.State.ended {
            // 左に大きくスワイプ
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x - 250,y: card.center.y)
                })
                return
            // 右に大きくスワイプ
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x - 250,y: card.center.y)
                })
                return
            }

            // 元に戻る処理
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.centerOfCard
            })
            card.center = centerOfCard
        }

    }

}

