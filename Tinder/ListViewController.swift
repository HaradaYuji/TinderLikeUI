//
//  ListViewController.swift
//  Tinder
//
//  Created by 原田悠嗣 on 2019/02/23.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!




    var likedName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        print(likedName)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = likedName[indexPath.row]// likedNameのindexpath.row番目を表示
        return cell
    }


}
