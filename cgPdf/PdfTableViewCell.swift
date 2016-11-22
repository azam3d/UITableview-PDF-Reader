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
    var row: Int?
    private var document: PdfDocument!
    
    var scrollView: PdfScrollView? {
        didSet {
            subviews.forEach{ $0.removeFromSuperview() }
            if let scrollView = scrollView {
                addSubview(scrollView)
            }
        }
    }

    init(style: UITableViewCellStyle, reuseIdentifier: String?, row: Int, frame: CGRect) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.row = row
        self.frame = frame
        
        setupPdf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPdf() {
        let documentURL = Bundle.main.url(forResource: "mongodb", withExtension: "pdf")!
        document = PdfDocument(fileUrl: documentURL)
        
        guard let pageNumber = row else {
            return
        }
        guard let pageRef = document.coreDocument.page(at: pageNumber + 1) else { fatalError() }
        let pdfPage = pageRef
        
        var pageRect = pdfPage.getBoxRect(.mediaBox)
        let scale = min(frame.size.width/pageRect.size.width, frame.size.height/pageRect.size.height)
        pageRect.size = CGSize(width: pageRect.size.width * scale, height: pageRect.size.height * scale)
        
        guard !pageRect.isEmpty else { fatalError() }
        
        print("scale: \(scale)")
        print("pageRect width: \(pageRect.width)")
        print("pageRect height: \(pageRect.height)")
        
        scrollView = PdfScrollView(frame: pageRect, document: document, pageNumber: pageNumber)
    }
}
