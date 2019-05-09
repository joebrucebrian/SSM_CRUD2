package com.lty.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lty.bean.Employee;
import com.lty.bean.Message;
import com.lty.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/emps")
    @ResponseBody
    public Message getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //引入PageHelper分页插件
        //在查询之前调用，传入页面和条数
        PageHelper.startPage(pn, 5);
        //PageHelper后面紧跟的查询就是一个分页查询
        List<Employee> list = employeeService.getAll();
        //用PageInfo对查询结果进行包装，里面封装了详细的分页信息(navigatePage:连续显示几页)
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
    }

    //保存员工
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Message add(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            for (FieldError fieldError : result.getFieldErrors()) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误的信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Message.success();
        }

    }

    //检查用户名是否可用
    @RequestMapping(value = "/checkuser",method = RequestMethod.POST)
    @ResponseBody
    public Message checkUser(@RequestParam("empName") String empName){
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Message.success();
        }else {
            return Message.fail();
        }
    }
    //根据id查询员工
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public Message getEmp(@PathVariable("id")Integer id){
        Employee e = employeeService.getEmp(id);
        return Message.success().add("emp",e);
    }

    //更新员工信息
    //POST请求时Tomcat将请求体中的数据封装成一个map，SpringMvc封装POJO时通过getParameter从中取值
    //若ajax直接发PUT请求，Tomcat不会封装数据成一个map，只有post形式的请求才封装
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Message saveEmp(@Valid Employee e, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            for (FieldError fieldError : result.getFieldErrors()) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误的信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields",map);
        }else {
            employeeService.updateEmp(e);
            return Message.success();
        }

    }

    //删除员工，单个批量二合一
    //批量删除id用","隔开
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Message deleteEmp(@PathVariable("ids")String ids){
        //多个删除
        if(ids.contains(",")){
            List<Integer> list = new ArrayList<>();
            String[] s = ids.split(",");
            for (String id : s) {
                list.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(list);

        }
        //单个删除
        else {
            employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Message.success();
    }

    @RequestMapping("/empList")
    public String empList(){
        return "EmpList";
    }
}
