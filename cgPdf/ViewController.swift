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
        tableView.register(UINib.init(nibName: "PdfView", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = view.bounds.height
        tableView.allowsSelection = false
        
        let documentURL = Bundle.main.url(forResource: "apple", withExtension: "pdf")!
        document = PdfDocument(fileUrl: documentURL)
        
        print(document.pageCount)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PdfTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return document.pageCount
    }


}

