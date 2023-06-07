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
import Alamofire


class PredictionViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "test4.jpg") {
            postImageToServer(image: image)
        }else {
            print("image load fail")
        }
    }
    func postImageToServer(image: UIImage) {
        let url = "http://118.67.142.142:5000/prediction"
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url).responseDecodable(of: Prediction.self) { response in
            switch response.result {
            case .success(let predictionResponse):
                // 서버로부터의 응답 처리
                let carPredictions = predictionResponse.predictions[0]
                let emptyPredictions = predictionResponse.predictions[1]
                print("Car Predictions: \(carPredictions), Empty Predictions: \(emptyPredictions)")
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    
    //MARK: UI
    let addImageButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
}


