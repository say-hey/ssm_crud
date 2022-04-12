package com.ssm.controller;

import com.ssm.bean.Department;
import com.ssm.bean.Msg;
import com.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 部门信息
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 获取所有部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts() {
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }
}
