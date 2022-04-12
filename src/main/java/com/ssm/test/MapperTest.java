package com.ssm.test;

import com.ssm.bean.Employee;
import com.ssm.dao.EmployeeMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit.jupiter.web.SpringJUnitWebConfig;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层的工作
 */
/*
 * spring单元测试
 * 1.导入spring-test包
 * 2.@ContextConfiguration指定spring配置位置
 * 3.直接@Autowired组件就能用
 */

//如果您想在测试中使用Spring测试框架功能（例如）@MockBean，则必须使用@ExtendWith(SpringExtension.class)。它取代了不推荐使用的JUnit4@RunWith(SpringJUnit4ClassRunner.class)
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    EmployeeMapper employeeMapper;

    @Test
    public void test(){
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
        System.out.println(employee);
    }
}
