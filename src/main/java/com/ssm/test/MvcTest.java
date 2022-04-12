package com.ssm.test;


import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

//添加springmvc到spring容器
@WebAppConfiguration
//如果您想在测试中使用Spring测试框架功能（例如）@MockBean，则必须使用@ExtendWith(SpringExtension.class)。它取代了不推荐使用的JUnit4@RunWith(SpringJUnit4ClassRunner.class)
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {

    //传入springmvc的IOC，需要加注解
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取请求结果
    MockMvc mockMvc;

    //每次使用都初始化
    //junit4使用@Before，junit5使用@BeforeEach，在@Test方法之前运行
    @BeforeEach()
    public void initMockMvc() {
        //创建MockMVC，模拟mvc请求
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟发送请求拿到返回值，get，参数第八页，返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "8")).andReturn();

        //请求成功后，请求域中会有pageInfo，取出 验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.println("在页面连续显示页码");

        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.print(i + " ");
        }

        System.out.println();
        //员工数据也封装在pageinfo中
        List<Employee> list = pageInfo.getList();
        for(Employee e : list) {
            System.out.println( e.getEmpId() + "--" +e.getEmpName() + "--" + e.getEmail());
        }
    }
}
