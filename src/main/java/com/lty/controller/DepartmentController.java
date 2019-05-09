package com.lty.controller;

import com.lty.bean.Department;
import com.lty.bean.Message;
import com.lty.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Message getDeptsWithJson(){
        List<Department> list = departmentService.getAll();
        return Message.success().add("deptList",list);
    }
}
