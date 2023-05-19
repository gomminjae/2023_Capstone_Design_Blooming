package com.blooming.modelServer.login.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@Getter
@NoArgsConstructor
public class KakaoToken {
    private String tokenType;
    private String accessToken;
    private String refreshToken;

    public static KakaoToken fail() {
        return new KakaoToken(null, null);
    }

    private KakaoToken(final String accessToken, final String refreshToken) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}
