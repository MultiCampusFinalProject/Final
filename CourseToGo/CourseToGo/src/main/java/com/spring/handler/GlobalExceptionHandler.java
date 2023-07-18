package com.spring.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex) {
        // 예외 처리 로직을 구현합니다.
        return "redirect:/error"; // 에러 페이지로 리다이렉트합니다.
    }
}