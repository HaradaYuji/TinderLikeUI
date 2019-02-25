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

    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!

    var centerOfCard:CGPoint!
    var people = [UIView]()
    var selectedCardCount:Int = 0

    let name = ["ほのか","あかね","ちあき","カルロス"]
    var likedName = [String]()
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
    }
*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        centerOfCard = basicCard.center

        // 各配列情報を初期化
        people.removeAll()
        likedName.removeAll()// リストを初期化しない場合はこの処理は不要
        // カウントもゼロに戻す
        selectedCardCount = 0

        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)

        resetPeople()
    }

    func resetCard() {
        basicCard.center = self.centerOfCard
        basicCard.transform = .identity
    }

    func resetPeople() {
        // ４人の飛んで行ったビューを元の位置に戻す
        for i in 0..<4 {
            people[i].center = self.centerOfCard
            people[i].transform = .identity
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushList" {
            let vc = segue.destination as! ListViewController
            vc.likedName = likedName// ListViewControllerのlikedNameにViewCountrollewのLikedNameを代入
        }
    }


    @IBAction func likebuttonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x:self.people[self.selectedCardCount].center.x + 400, y:self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        likedName.append(name[selectedCardCount])
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
        }
        return
    }

    @IBAction func dislikebuttonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x:self.people[self.selectedCardCount].center.x - 400, y:self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
        }
        return

    }

    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {

        let card = sender.view!
        let point = sender.translation(in: view)

        card.center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)

        // 元々の位置とい移動先との差（角度を変える）
        let xfromCenter = card.center.x - view.center.x

        // 0.785は45度のラジアン
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)

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
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x:self.people[self.selectedCardCount].center.x - 400, y:self.people[self.selectedCardCount].center.y)
                })
                likeImageView.alpha = 0
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
            // 右に大きくスワイプ
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x:self.people[self.selectedCardCount].center.x + 400, y:self.people[self.selectedCardCount].center.y)
                    //card.center = CGPoint(x: card.center.x - 250,y: card.center.y)
                })
                likeImageView.alpha = 0
                likedName.append(name[selectedCardCount])
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
            }

            // 元に戻る処理
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                self.people[self.selectedCardCount].center = self.centerOfCard
                self.people[self.selectedCardCount].transform = .identity
            })
            likeImageView.alpha = 0
        }

    }

}

