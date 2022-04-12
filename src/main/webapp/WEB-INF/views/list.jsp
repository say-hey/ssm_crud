<%--
  Created by IntelliJ IDEA.
  User: wkl
  Date: 2022/4/6
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- 是否忽略EL表达式，默认true，导致不能访问jsp域，PATH不生效--%>
<%@ page isELIgnored="false" %>
<%-- 添加JSTL表达式 --%>
<%--报错的可以把jstl引入改成：<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
    <title>员工列表</title>
    <%
        /* 设置路径 以“/”开始的相对路径是从服务下开始查找http://localhost:8080 */
        pageContext.setAttribute("PATH", request.getContextPath());
    %>
    <script src="${PATH}/static/jquery-1.12.4.js"></script>
    <script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

<%--    <script src="/static/jquery-1.12.4.js"></script>--%>
<%--    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>--%>
<%--    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">--%>
</head>
<body>
<!-- row行必须包含在container中 -->
<div class="container">
    <!-- 定义row行 -->
    <!-- 标题 -->
    <div class="row">
        <!-- 定义col列 -->
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-2 col-md-offset-9">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_modal_btn">删除</button>
        </div>
    </div>

    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-12">

            <table class="table table-hover" id="emps_table">
                <!-- table table-striped-->

                <!-- 对表格分组 table-thead-tbody-tfoot -->
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>EmpName</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>DeptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                    <%-- 手动添加数据测试 --%>
                    <%--                    <tr>
                            <td></td>
                            <td style="width: 80px">1</td>
                            <td>Tom</td>
                            <td>M</td>
                            <td style="width: 300px">Tom@123.com</td>
                            <td>研发部</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    新增
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>--%>

                    <!-- jstl表达式，取出后台发送数据 -->
                    <c:forEach items="${pageInfo.list}" var="p">
                        <tr>
                            <td style="width: 80px">${p.empId}</td>
                            <td>${p.empName}</td>
                            <td>${p.gender=="M"?"男":"女"}</td>
                            <td style="width: 300px">${p.email}</td>
                            <td>${p.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    新增
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
    <!-- 分页数据 暂时占据位置，之后需要拼接-->
    <div class="row">

        <div class="col-md-4" id="page_info_area">
            当前第xx页，总xx，
            总xx条数据
        </div>
        <div class="col-md-6 col-md-offset-7" id="page_nav_area">
            首页 << 1 2 3 4 5 >> 尾页
        </div>
    </div>
</div>
</body>
</html>
