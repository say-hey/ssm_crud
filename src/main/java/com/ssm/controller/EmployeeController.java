package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;
import com.ssm.bean.Msg;
import com.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工增删改查请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 删除
     *
     * 单个，批量删除二合一
     * 单个：id=1
     * 批量：id=1-2-3
     * 判断是否带有"-"
     *
     * 需要用string获取参数
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable String ids) {

        if(ids.contains("-")) {
            //批量

            //分割
            String[] split = ids.split("-");
            //用一个接受list集合的删除方法，需要String转List
            //也可以 String[]-->Integer[]-->List<Integer> 不过没想出来
            List<Integer> idList = new ArrayList<Integer>();
            for (String strId : split) {
                idList.add(Integer.parseInt(strId));
            }
            employeeService.deleteBatch(idList);
            System.out.println("批量删了吗？");
        }else {
            //单个
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
            System.out.println("单个删了吗？");
        }
        return Msg.success();
    }

    /**
     * 更新操作
     * PUT
     * 注意添加过滤器；FormContentFilter
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee) {
        System.out.println("待更新对象："+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 查询用户，用于修改模态框回显
     * REST风格
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id")Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * 用户名查重
     * 前端校验，在失去焦点，保存之前都校验
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkname")
    public Msg checkEmpName(@RequestParam("empName")String empName) {

        //用户名格式校验
        String regx = "(^[a-zA-Z0-9_-]{2,8}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("msg", "用户名可以是2-5位中文或者2-8位英文和数字的组合");
        }
        //返回查询统计结果，true说明没有重名
        boolean b = employeeService.checkEmpName(empName);
        if(b) {
            return Msg.success();
        }else {
            return Msg.fail().add("msg", "用户名已存在");
        }
    }

    /**
     * 新增，保存用户,并验证
     *
     * 添加JSR303校验
     * @Valid表示校验下一个对象
     * BindingResult紧跟被校验对象，接收结果
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/saveemp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {

        if(result.hasErrors()) {
            //格式校验失败，返回信息
            Map<String ,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError error : fieldErrors) {
                System.out.println("错误的字段名:" + error.getField());
                System.out.println("错误信息:" + error.getDefaultMessage());
                //将错误信息放到map中
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);

        }else if(!employeeService.checkEmpName(employee.getEmpName())){
            //后端在保存的时候再次验证是否存在用户名---有点 重复的感觉？？？
            //因为是在一起接收所以错误信息一定要一样，empName手动写上
            return Msg.fail().add("empName", "用户名已存在");
        }else {

            employeeService.saveEmp(employee);
            //不用这种：获取总页数，用在新增完之后跳转到最后一页，不过这样就会多查一次数据库
            //PageInfo<Employee> pageInfo = employeeService.getPage(null);
            //return Msg.success().add("pageInfo", pageInfo);
            return Msg.success();
        }
    }

    /**
     * 查询，返回json数据
     * {"pageNum":1,"pageSize":5,"size":5,"startRow":1,"endRow":5,"total":1001,"pages":201,"list":[{"empId":1,"empName":"Tom","gender":"M","email":"Tom@123.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}}
     * 但是返回PageInfo对象，通用性不高，新建一个通用返回类com.ssm.bean.Msg
     * 可以返回Msg对象
     *
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn) {

        PageInfo pageInfo = employeeService.getPage(pn);
        System.out.println("查询/emps");
        System.out.println(pageInfo);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 测试
     * 查询所有员工数据
     * 访问index.jsp首页查询所有数据并分页，将数据返回并跳转到list.jsp页面展示
     * @param pn 页码，默认第一页
     * @param model 传递出去的数据
     * @return
     */
    //@RequestMapping("/emps")
    public String testGetEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model){
        //使用分页插件
        //在使用之前只需要调用，传入页码，每页大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，包括查询出来的数据，员工列表
        //封装员工，设置连续显示页码
        PageInfo<Employee> info = new PageInfo<>(emps, 5);
        //只需要将pageinfo交给页面，里面封装了详细分页信息
        model.addAttribute("pageInfo", info);
        return "list";
    }
}
