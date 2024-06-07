package com.bbosil.util.OAth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.apis.NaverApi;

@Controller
@RequestMapping("/call")
public class AuthController {

    private final String CLIENT_ID = "_HNO952K_iSyuw1B_RfA";
    private final String CLIENT_SECRET = "NZJy_LkRGL";
    private final String CALLBACK_URL = "http://localhost/call/callback";
    private final OAuth20Service oauthService;
    
    public AuthController() {
        this.oauthService = new ServiceBuilder(CLIENT_ID)
                                .apiSecret(CLIENT_SECRET)
                                .callback(CALLBACK_URL)
                                .build(NaverApi.instance());
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        String authorizationUrl = oauthService.getAuthorizationUrl();
        return "redirect:" + authorizationUrl;
    }

    @GetMapping("/callback")
    public String handleCallbackAndShowRegistrationForm(String code, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
            UserProfile userProfile = fetchUserProfile(accessToken);
            
            //model.addAttribute("userProfile", userProfile);
            
            // 세션을 사용하여 데이터를 전달
            session.setAttribute("userProfile", userProfile);
            
            return "redirect:/member/write.do";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    private UserProfile fetchUserProfile(OAuth2AccessToken accessToken) throws Exception {
        OAuthRequest request = new OAuthRequest(Verb.GET, "https://openapi.naver.com/v1/nid/me");
        oauthService.signRequest(accessToken, request);
        try (Response response = oauthService.execute(request)) {
            String responseBody = response.getBody();
            JSONObject jsonResponse = new JSONObject(responseBody);
            JSONObject responseInfo = jsonResponse.getJSONObject("response");

            String id = responseInfo.optString("id", ""); // 기본값으로 빈 문자열을 사용
            String name = responseInfo.optString("name", "");
            String email = responseInfo.optString("email", "");
            String phoneNumber = responseInfo.optString("mobile", ""); // 'mobile' 키는 네이버 API 응답에 따라 달라질 수 있음

            return new UserProfile(id, name, email, phoneNumber);
        }
    }
}
