//
//  ViewController.swift
//  cgPdf
//
//  Created by Muhammad Azam Bin Baderi on 11/16/16.
//  Copyright © 2016 Muhammad Azam Bin Baderi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var document: PdfDocument!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(UIApplication.shared.statusBarFrame.size.height, 0.0, 0.0, 0.0)
        tableView.register(PdfTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
        
//        tableView.estimatedRowHeight = 485
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 485
        
        let documentURL = Bundle.main.url(forResource: "mongodb", withExtension: "pdf")!
        document = PdfDocument(fileUrl: documentURL)        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PdfTableViewCell(style: .default, reuseIdentifier: "cell", row: indexPath.row, frame: tableView.frame)
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return document.pageCount
    }
}

