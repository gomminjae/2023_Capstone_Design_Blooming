package com.blooming.modelServer.login.client;

import java.net.URI;


import com.blooming.modelServer.login.config.KakaoFeignConfiguration;
import com.blooming.modelServer.login.dto.KakaoInfo;
import com.blooming.modelServer.login.dto.KakaoToken;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@FeignClient(name = "kakaoClient", configuration = KakaoFeignConfiguration.class)
public interface KakaoClient {

    @PostMapping
    KakaoInfo getInfo(URI baseUrl, @RequestHeader("Authorization") String accessToken);

    @PostMapping
    @ResponseStatus(HttpStatus.OK)
    KakaoToken getToken(URI baseUrl, @RequestParam("client_id") String restApiKey,
                                    @RequestParam("redirect_uri") String redirectUrl,
                                    @RequestParam("code") String code,
                                    @RequestParam("grant_type") String grantType);

}
