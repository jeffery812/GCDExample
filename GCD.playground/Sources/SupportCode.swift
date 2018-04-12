import Foundation
import UIKit

public func example(of description: String, action: () -> Void) -> TimeInterval {
    let startTime = Date()
    
    print("\n--- Example of:", description, "---")
    action()
    
    let cost = Date().timeIntervalSince(startTime)
    print(String(format: "[ spent: %.5f ] seconds", cost))
    return cost
}

public func slowJoint(_ input: (Any, Any)) -> String {
    sleep(1)
    return "\(input.0)\(input.1)"
}




public func blurImage(image:UIImage?) -> UIImage? {
    guard let image = image else {
        print("ERROR: image is nil")
        return .none
    }
    
    let context = CIContext(options: nil)
    let inputImage = CIImage(image: image)
    let originalOrientation = image.imageOrientation
    let originalScale = image.scale
    
    let filter = CIFilter(name: "CIGaussianBlur")
    filter?.setValue(inputImage, forKey: kCIInputImageKey)
    filter?.setValue(10.0, forKey: kCIInputRadiusKey)
    let outputImage = filter?.outputImage
    
    var cgImage:CGImage?
    
    if let asd = outputImage {
        cgImage = context.createCGImage(asd, from: (inputImage?.extent)!)
    }
    
    guard let cgImageA = cgImage else {
        return .none
    }
    return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
}
