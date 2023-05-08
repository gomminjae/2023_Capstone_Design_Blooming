package com.blooming.modelServer.login.service;


import com.blooming.modelServer.login.client.KakaoClient;
import com.blooming.modelServer.login.dto.KakaoInfo;
import com.blooming.modelServer.login.dto.KakaoToken;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

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

    public KakaoInfo getInfo(final String code) {
        final KakaoToken token = getToken(code);
        log.debug("token = {}", token);
        try {
            log.debug(client.getInfo(new URI(kakaoUserApiUrl), token.getTokenType() + " " + token.getAccessToken()).toString());
            return client.getInfo(new URI(kakaoUserApiUrl), token.getTokenType() + " " + token.getAccessToken());
        } catch (Exception e) {
            log.error("something error..", e);
            return KakaoInfo.fail();
        }
    }

    public KakaoInfo getInfo(final String access_token, final String token_type) {
        log.debug("token = {}", access_token);
        try {
            log.debug(client.getInfo(new URI(kakaoUserApiUrl), token_type + " " + access_token).toString());
            return client.getInfo(new URI(kakaoUserApiUrl), token_type + " " + access_token);
        } catch (Exception e) {
            log.error("something error..", e);
            return KakaoInfo.fail();
    // custom
        }
    }
    public KakaoToken getToken(final String code) {
        try {
            return client.getToken(new URI(kakaoAuthUrl), restapiKey, redirectUrl, code, "authorization_code");
        } catch (Exception e) {
            log.error("Something error..", e);
            return KakaoToken.fail();
        }
    }
}
