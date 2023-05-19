//
//  LoginManager.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/28.
//

import Foundation


class LoginManager {
    
    let url = "https://kauth.kakao.com/oauth/token"
    let parameters = [
      "grant_type": "authorization_code",
      "client_id": "카카오_클라이언트_ID",
      "redirect_uri": "등록한_스키마://oauth",
      "code": "인증_코드"
    ]
}
