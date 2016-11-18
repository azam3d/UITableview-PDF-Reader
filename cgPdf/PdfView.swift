//
//  PdfView.swift
//  cgPdf
//
//  Created by Muhammad Azam Bin Baderi on 11/18/16.
//  Copyright © 2016 Muhammad Azam Bin Baderi. All rights reserved.
//

import UIKit

class PdfView: UIView {
    private var leftPdfPage: CGPDFPage?
    private var myScale: CGFloat

    init(frame: CGRect, scale: CGFloat, newPage: CGPDFPage) {
        myScale = scale
        leftPdfPage = newPage
        print("init pdfview")
        
        super.init(frame: frame)
        backgroundColor = UIColor.cyan
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ layer: CALayer, in con: CGContext) {
        print("draw")
        guard let leftPdfPage = leftPdfPage else { return }
        
        // Fill the background with white.
        con.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        con.fill(bounds)
        
        con.saveGState()
        // Flip the context so that the PDF page is rendered right side up.
        con.translateBy(x: 0, y: bounds.size.height)
        con.scaleBy(x: 1, y: -1)
        
        // Scale the context so that the PDF page is rendered at the correct size for the zoom level.
        con.scaleBy(x: myScale, y: myScale)
        con.drawPDFPage(leftPdfPage)
        con.restoreGState()
    }

}
