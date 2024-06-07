package com.bbosil.util.OAth;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

public class OAuth2Service {
    private OAuth20Service oauthService;
    private String clientId = "_HNO952K_iSyuw1B_RfA"; // 여기에 클라이언트 ID 입력
    private String clientSecret = "NZJy_LkRGL"; // 여기에 클라이언트 Secret 입력
    private String callbackUrl = "http://localhost/call/callback"; // 콜백 URL

    public OAuth2Service() {
        this.oauthService = new ServiceBuilder(clientId)
                                .apiSecret(clientSecret)
                                .callback(callbackUrl)
                                .build(NaverLoginApi.instance());
    }

    public String getAuthorizationUrl() {
        return oauthService.getAuthorizationUrl();
    }

    public OAuth2AccessToken getAccessToken(String code) throws InterruptedException, ExecutionException, IOException {
        return oauthService.getAccessToken(code);
    }

    public String getUserProfile(OAuth2AccessToken accessToken) throws InterruptedException, ExecutionException, IOException {
        OAuthRequest request = new OAuthRequest(Verb.GET, "https://openapi.naver.com/v1/nid/me");
        oauthService.signRequest(accessToken, request);
        Response response = oauthService.execute(request);
        return response.getBody();
    }
}