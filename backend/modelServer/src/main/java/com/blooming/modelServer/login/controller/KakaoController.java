package com.blooming.modelServer.login.controller;

import com.blooming.modelServer.login.dto.KakaoToken;
import com.blooming.modelServer.login.service.KakaoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
public class KakaoController {

    private final KakaoService kakaoService;
    //카카오 인증서버에서 accessToken/refreshToken 받아옴.
    @GetMapping("/callback")
    public KakaoToken getKakaoAccount(@RequestParam("code") String code) {
        log.debug("code = {}", code);
        return kakaoService.getToken(code);
    }
}