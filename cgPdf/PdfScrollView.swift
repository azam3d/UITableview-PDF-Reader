//
//  PdfScrollView.swift
//  cgPdf
//
//  Created by Muhammad Azam Bin Baderi on 11/21/16.
//  Copyright © 2016 Muhammad Azam Bin Baderi. All rights reserved.
//

import UIKit

class PdfScrollView: UIScrollView {
    var pdfView: PdfView?
    var pdfFrame: CGRect?
    var pageNumber: Int?
    private var document: PdfDocument!
    var scale: CGFloat?
    private let zoomLevels: CGFloat = 2
    private var zoomAmount: CGFloat?

    init(frame: CGRect, document: PdfDocument, pageNumber: Int) {
        self.pdfFrame = frame
        self.pageNumber = pageNumber
        
        super.init(frame: frame)
        
        delegate = self
        setupPdf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPdf() {
        let documentURL = Bundle.main.url(forResource: "mongodb", withExtension: "pdf")!
        document = PdfDocument(fileUrl: documentURL)
        
        guard let pageNumber = pageNumber else {
            return
        }
        guard let pageRef = document.coreDocument.page(at: pageNumber + 1) else { fatalError() }
        let pdfPage = pageRef
        
        var pageRect = pdfPage.getBoxRect(.mediaBox)
        scale = min(frame.size.width/pageRect.size.width, frame.size.height/pageRect.size.height)
        pageRect.size = CGSize(width: pageRect.size.width * scale!, height: pageRect.size.height * scale!)
        
        guard !pageRect.isEmpty else { fatalError() }
        
        pdfView = PdfView(frame: pdfFrame!, scale: scale!, newPage: pdfPage)
        addSubview(pdfView!)
        
        let targetRect = bounds.insetBy(dx: 0, dy: 0)
        var zoomScale = zoomScaleThatFits(targetRect.size, source: bounds.size)
        
        minimumZoomScale = zoomScale // Set the minimum and maximum zoom scales
        maximumZoomScale = zoomScale * (zoomLevels * zoomLevels) // Max number of zoom levels
        zoomAmount = (maximumZoomScale - minimumZoomScale) / zoomLevels
        
        scale = 1
        if zoomScale > minimumZoomScale {
            zoomScale = minimumZoomScale
        }
    }
    
    private func zoomScaleThatFits(_ target: CGSize, source: CGSize) -> CGFloat {
        let widthScale = target.width / source.width
        let heightScale = target.height / source.height
        return (widthScale < heightScale) ? widthScale : heightScale
    }
}

extension PdfScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pdfView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scale = scale
    }
}
