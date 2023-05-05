package com.example.slsjavaspringbootniwaecr.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExampleController {

    @GetMapping("hello")
    public String get() {
        return "Serverless Java17 Spring Boot Native Image Web Adapter Container Example";
    }

}
