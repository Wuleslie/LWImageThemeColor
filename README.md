# LWImageThemeColor

This simple project targets at extracting the theme color of a certain image. And I saw several apps doing that, like Douban, NeteaseMusic, etc. In their detail page of an entry(a movie, a book or an album), they show the cover at the top. And they use the theme color of this cover image as headerView's background color. And I want to know what the trick is.

## Implementation

I did some searches. It turns out that this matter is not that complicated. Here I choose to use CIAreaAverage filter in CoreImage which is available on iOS 9:

```swift
extension UIImage {
    func themeColor() -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        guard let filter = CIFilter.init(name: "CIAreaAverage", withInputParameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext.init(options: [kCIContextWorkingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: kCIFormatRGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
```

Many thanks to [this link](https://stackoverflow.com/questions/26330924/get-average-color-of-uiimage-in-swift#) on Stack Overflow.

## Demo

I wrote a demo to show the visual result of the implementation method above. You can pick images from your photo library, or take pictures, to test. The followings are some samples:

![sample001](https://github.com/Wuleslie/LWImageThemeColor/raw/master/Resource/sample001.png)

![sample002](https://github.com/Wuleslie/LWImageThemeColor/raw/master/Resource/sample002.png)

![sample003](https://github.com/Wuleslie/LWImageThemeColor/raw/master/Resource/sample003.png)

![sample004](https://github.com/Wuleslie/LWImageThemeColor/raw/master/Resource/sample004.png)

Feel free to use this project~