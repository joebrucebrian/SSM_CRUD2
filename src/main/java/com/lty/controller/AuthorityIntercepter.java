package com.lty.controller;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthorityIntercepter implements HandlerInterceptor {
    /**
     * 该方法在目标方法之前被调用，若返回true则继续调用其他拦截器和目标方法，若有一个拦截器返回false，后面的拦截器和目标方法都不再调用
     * 可以用来做权限，日志，事务
     */
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object o) throws Exception {
        Cookie[] cookies = req.getCookies();
        String state = null;
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("login")){
                state = cookie.getValue();
            }
        }
        if(state == null){
            resp.sendRedirect("index.jsp");
            return false;
        }
        return true;
    }

    /**
     * 在目标方法之后，渲染视图之前被调用
     * 可以修改请求域里的属性或者修改视图
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        System.out.println(this.getClass().getSimpleName() + "+ postHandle");

    }

    //渲染视图之后被调用
    //释放资源
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println(this.getClass().getSimpleName() + "+ afterCompletion");

    }
}
