//
//  ViewController.swift
//  Example
//
//  Created by hakozaki on 2017/04/20.
//  Copyright © 2017年 hakozaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var homeImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedImage(_ sender: Any) {
        
        let image = UIImage(named : "photo")
        let controller : RSKImageCropViewController = RSKImageCropViewController.init(image: image!, cropMode: .custom)
        
        controller.originalImage = image!
        controller.cropMode = .custom
        
        controller.delegate = self
        controller.dataSource = self
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController : RSKImageCropViewControllerDelegate{
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        self.homeImage.image = croppedImage
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController : RSKImageCropViewControllerDataSource{
    
    func imageCropViewControllerCustomMaskRect(_ controller: RSKImageCropViewController) -> CGRect {
        
        let width : CGFloat = self.view.frame.width
        let height : CGFloat = (width * 2)/3
        
        let viewHeight : CGFloat = controller.view.frame.height
        
        let maskRect = CGRectMake( 0 , viewHeight * 0.2 , width, height)
        return maskRect
    }
    
    func imageCropViewControllerCustomMaskPath(_ controller: RSKImageCropViewController) -> UIBezierPath {
        let rect = controller.maskRect
        
        let point1 = CGPoint(x: rect.minX, y: rect.maxY)
        let point2 = CGPoint(x: rect.maxX, y: rect.maxY)
        let point3 = CGPoint(x: rect.maxX, y: rect.minY)
        let point4 = CGPoint(x: rect.minX, y: rect.minY)
        
        let square = UIBezierPath()
        square.move(to: point1)
        square.addLine(to: point2)
        square.addLine(to: point3)
        square.addLine(to: point4)
        square.close()
        
        return square
    }
    
    func imageCropViewControllerCustomMovementRect(_ controller: RSKImageCropViewController) -> CGRect {
        return controller.maskRect
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}



