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

    @IBOutlet weak var likeImageView: UIImageView!



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

        // 元々の位置とい移動先との差（角度を変える）
        let xfromCenter = card.center.x - view.center.x
        // 0.785は45度のラジアン
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)

        if xfromCenter > 0 {
            likeImageView.image = #imageLiteral(resourceName: "good")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        } else if xfromCenter < 0 {
            likeImageView.image = #imageLiteral(resourceName: "bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }

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
                card.transform = .identity
            })
            likeImageView.alpha = 0
        }

    }

}

