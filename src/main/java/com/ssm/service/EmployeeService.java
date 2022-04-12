package com.ssm.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;
import com.ssm.bean.EmployeeExample;
import com.ssm.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 批量删除
     *
     * 添加复杂条件，使用List集合
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //example是添加复杂条件，所以andDIdIn
        //相当于delete from xxx where emp_id in (1,2,3);
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
        System.out.println("批量sql执行了吗？");
    }

    /**
     * 根据 id 删除
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 根据id更新用户
     * updateByPrimaryKeySelective(employee)根据id有选择的更新
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 根据id查用户
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 查询用户是否存在
     * 使用Example复杂查询
     *
     * @param name
     * @return
     */
    public boolean checkEmpName(String name) {
        //Example用法
        EmployeeExample example = new EmployeeExample();
        //创建查询条件
        EmployeeExample.Criteria criteria = example.createCriteria();
        //我的理解：这一句相当于添加了一个条件 where empName=name
        criteria.andEmpNameEqualTo(name);
        //统计查询结构
        long count = employeeMapper.countByExample(example);
        //返回true(0)说明没有重复用户名
        return count == 0;
    }

    /**
     * 保存emp员工，insert
     * @param employee
     */
    public void saveEmp(Employee employee) {
        //这个是有选择插入，insert()全插入，包括id
        employeeMapper.insertSelective(employee);
    }

    /**
     * 获取封装分页数据，包括查询的员工信息
     * 在controller中有详解
     *         //使用分页插件
     *         //在使用之前只需要调用，传入页码，每页大小
     *         PageHelper.startPage(pn, 5);
     *         //startPage后面紧跟的就是一个分页查询
     *         List<Employee> emps = employeeService.getAll();
     *         //使用pageInfo包装查询后的结果，包括查询出来的数据，员工列表
     *         //封装员工，设置连续显示页码
     *         PageInfo<Employee> info = new PageInfo<>(emps, 5);
     *         //只需要将pageinfo交给页面，里面封装了详细分页信息
     *         return Msg.success().add("PageInfo", info);
     * @param pn
     * @return
     */
    public PageInfo getPage(Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = getAll();
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        return pageInfo;
    }

    /**
     * 查询所有员工数据
     * @return
     */
    public List<Employee> getAll() {
        //查询所有
        return employeeMapper.selectByExampleWithDept(null);
    }
}
