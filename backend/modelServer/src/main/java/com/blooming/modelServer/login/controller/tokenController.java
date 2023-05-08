package com.blooming.modelServer.login.controller;

import com.blooming.modelServer.login.dto.KakaoAccount;
import com.blooming.modelServer.login.dto.KakaoToken;
import com.blooming.modelServer.login.service.KakaoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@Slf4j
@RequiredArgsConstructor
public class tokenController {
    private final KakaoService kakaoService;
    @PostMapping(value = "/login", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getToken(@RequestBody Map<String, String> kakaoToken) {
        log.debug("TOKEN: " + kakaoToken.get("accessToken") );
        log.debug("RefreshToken :"+  kakaoToken.get("refreshToken"));
        KakaoAccount test = kakaoService.getInfo(kakaoToken.get("accessToken"), kakaoToken.get("tokenType")).getKakaoAccount();

        return test.getProfile().getNickname();
    }
//    @PostMapping("/login")
//    public String getToken(@RequestParam("accessToken") String access_token, @RequestParam("refreshToken") String refresh_token, @RequestParam("tokenType") String token_type) {
//
//        KakaoAccount test = kakaoService.getInfo(access_token, token_type).getKakaoAccount();
//
//        return test.getProfile().getNickname();
//    }


}
