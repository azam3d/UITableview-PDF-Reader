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
        
        super.init(frame: frame)
        
        let tiledLayer = self.layer as? CATiledLayer
        tiledLayer?.levelsOfDetail = 16
        tiledLayer?.levelsOfDetailBias = 15
        tiledLayer?.tileSize = CGSize(width: 1024, height: 1024)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CATiledLayer.self
    }
    
    override func draw(_ layer: CALayer, in con: CGContext) {
        guard let leftPdfPage = leftPdfPage else { return }
        
        con.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        con.fill(bounds)
        con.saveGState()
        con.translateBy(x: 0, y: bounds.size.height)
        con.scaleBy(x: 1, y: -1)
        con.scaleBy(x: myScale, y: myScale)
        con.drawPDFPage(leftPdfPage)
        con.restoreGState()
    }

    deinit {
        leftPdfPage = nil
        layer.contents = nil
        layer.delegate = nil
        layer.removeFromSuperlayer()
    }
}
