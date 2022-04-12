package com.ssm.service;

import com.ssm.bean.Department;
import com.ssm.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 部门信息
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    /**
     * 查询所有部门
     */
    public List<Department> getDepts(){
        //方法本身可以添加查询条件，如果为null代表查所有
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
