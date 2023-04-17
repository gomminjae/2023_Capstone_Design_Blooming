package com.blooming.modelServer.login.service;


import com.blooming.modelServer.login.client.KakaoClient;
import com.blooming.modelServer.login.dto.KakaoToken;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;

@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoService {

    private final KakaoClient client;

    @Value("${kakao.auth-url}")
    private String kakaoAuthUrl;

    @Value("${kakao.user-api-url}")
    private String kakaoUserApiUrl;

    @Value("${kakao.restapi-key}")
    private String restapiKey;

    @Value("${kakao.redirect-url}")
    private String redirectUrl;

//    public KakaoInfo getInfo(final String code) {
//        final KakaoToken token = getToken(code);
//        log.debug("token = {}", token);
//        try {
//            KakaoInfo result = client.getInfo(new URI(kakaoUserApiUrl), token.getTokenType() + " " + token.getAccessToken());
//            return result;
//        } catch (Exception e) {
//            log.error("something error..", e);
//            return KakaoInfo.fail();
//        }
//    }

    public KakaoToken getToken(final String code) {
        try {
            return client.getToken(new URI(kakaoAuthUrl), restapiKey, redirectUrl, code, "authorization_code");
        } catch (Exception e) {
            log.error("Something error..", e);
            return KakaoToken.fail();
        }
    }
}
