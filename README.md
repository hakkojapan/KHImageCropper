# KHImageCropper
画像をクロップします。RSKImageViewControllerを基にしています。

## Installation

podファイルに以下を記述して下さい。

``` sh
pod 'KHImageCropper', :git => 'https://github.com/hakkojapan/KHImageCropper.git'
``` 

##Usage

please see example.
KHImageCropperを利用するファイル内でimportしてください。

``` swift
import KHImageCropper

class ViewController: UIViewController {
    @IBOutlet weak var homeImage: UIImageView!

    override func viewDidLoad() {
    super.viewDidLoad()

        let controller : RSKImageCropViewController = RSKImageCropViewController.init(image: image!, cropMode: .custom)

        controller.delegate = self
        controller.dataSource = self
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

```

## License

MIT

