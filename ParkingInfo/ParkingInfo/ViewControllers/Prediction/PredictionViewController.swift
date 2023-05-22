//
//  PredictionViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/21.
//

import UIKit
import CoreML
import SnapKit
import RxSwift
import Vision

class PredictionViewController: BaseViewController {
    
    var model: Blooming?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputData = convertImageToMultiArray(image: UIImage(named: "test1")!)
        guard let model = try? Blooming(configuration: MLModelConfiguration()) else {
            fatalError("Loading Model Failed")
        }
        
        if let model = model as? Blooming {
           guard let input = try? BloomingInput(input_1: inputData) else {
               // 입력 데이터 생성 실패
               return
           }
           
           do {
               let output = try model.prediction(input: input)
               print((output.Identity[1]))
           } catch {
               // 예측 실패
               print("Prediction fail")
           }
        } else {
           // 모델 타입 불일치
            print("model type error")
        }
        // Do any additional setup after loading the view.
        
    }
    override func setupView() {
        view.addSubview(imageView)
        imageView.image = UIImage(named: "test3")
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
            $0.width.height.equalTo(300)
        }
    }
    

    func convertImageToMultiArray(image: UIImage) -> MLMultiArray {
        let resizedImage = resizeImage(image: image, newSize: CGSize(width: 224, height: 224))
        let pixelBuffer = resizedImage?.pixelBuffer()
        let multiArray = try? MLMultiArray(shape: [1, 224, 224, 3], dataType: .float32)
        
        
        let bufferSize = 224 * 224 * 3
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: multiArray?.dataPointer, width: 224, height: 224, bitsPerComponent: 8, bytesPerRow: 224 * 3, space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        context?.draw(pixelBuffer as! CGLayer, in: CGRect(x: 0, y: 0, width: 224, height: 224))
        
        for i in 0..<bufferSize {
            let floatPixelValue = (multiArray!.dataPointer + (i * MemoryLayout<Float32>.stride)).assumingMemoryBound(to: Float32.self)
            let normalizedPixelValue = (floatPixelValue.pointee - 127.5) / 127.5
            floatPixelValue.pointee = normalizedPixelValue
        }
        
        return multiArray!
    }

    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    //MARK: UI
    let imageView: UIImageView = UIImageView()

}

// UIImage를 CVPixelBuffer로 변환하는 함수
extension UIImage {
    func pixelBuffer() -> CVPixelBuffer? {
        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
        ]
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, attrs as CFDictionary, &pixelBuffer)
        
        guard let buffer = pixelBuffer, status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(buffer)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        
        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return buffer
    }
}
