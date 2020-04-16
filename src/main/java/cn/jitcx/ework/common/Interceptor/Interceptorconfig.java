package cn.jitcx.ework.common.Interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

//配置拦截器
@Configuration
public class Interceptorconfig extends WebMvcConfigurerAdapter{
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	 registry.addInterceptor(new recordInterceptor()).addPathPatterns("/**")
                 .excludePathPatterns("/logins")
                 .excludePathPatterns("/captcha")
                 .excludePathPatterns("/faceAjax")
                 .excludePathPatterns("/faceLogin")
                 .excludePathPatterns("/faceRecognitionLogin")
                 .excludePathPatterns("/accountLogin");
    }
}