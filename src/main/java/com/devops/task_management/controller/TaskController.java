package com.devops.task_management.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class TaskController {
    @GetMapping("/hello")
    public String hello(){
        return "Hello From DevOps Task Management Platform!";
    }
}
