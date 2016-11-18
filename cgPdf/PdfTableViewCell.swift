//
//  PdfTableViewCell.swift
//  cgPdf
//
//  Created by Muhammad Azam Bin Baderi on 11/17/16.
//  Copyright © 2016 Muhammad Azam Bin Baderi. All rights reserved.
//

import UIKit
import QuartzCore

class PdfTableViewCell: UITableViewCell {
    var pdfView: PdfView!
    private var document: PdfDocument!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.brown
        
        print("cell")
        setupPdf()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupPdf() {
        print("setup")
        let pageNumber = 1
        let documentURL = Bundle.main.url(forResource: "apple", withExtension: "pdf")!
        document = PdfDocument(fileUrl: documentURL)
        
        guard let pageRef = document.coreDocument.page(at: pageNumber + 1) else { fatalError() }
        let pdfPage = pageRef
        
        var pageRect = pdfPage.getBoxRect(.mediaBox)
        let scale = min(frame.size.width/pageRect.size.width, frame.size.height/pageRect.size.height)
        pageRect.size = CGSize(width: pageRect.size.width * scale, height: pageRect.size.height * scale)
        
        guard !pageRect.isEmpty else { fatalError() }
        
        pageRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        pdfView = PdfView(frame: pageRect, scale: scale, newPage: pdfPage)
        pdfView.backgroundColor = UIColor.green
        addSubview(pdfView)
    }
}
