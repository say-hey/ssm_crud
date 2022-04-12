<%-- 解决乱码 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- 是否忽略EL表达式，默认true，导致不能访问jsp域，PATH不生效--%>
<%@ page isELIgnored="false" %>
<html>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<head>

    <%
        /* 设置路径 以“/”开始的相对路径是从服务下开始查找http://localhost:8080 */
        pageContext.setAttribute("PATH", request.getContextPath());
    %>
    <script src="${PATH}/static/jquery-1.12.4.js"></script>
    <script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
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


    <!-- 为修改 按钮 增加模态框 ，利用按钮的on方法事件绑定-->
    <!-- Modal -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">员工更新</h4>
                </div>
                <div class="modal-body">
                    <!-- 添加表单 -->
                    <form class="form-horizontal">
                        <!-- 姓名 -->
                        <div class="form-group">
                            <label for="empName_update_input" class="col-sm-2 control-label">EmpName</label>
                            <div class="col-sm-10">
                                <!-- 输入框改为静态控件，只读-->
                                <p class="form-control-static" id="empName_update_input"></p>
                                <!-- 用来显示错误提示 -->
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <!-- 邮箱 -->
                        <div class="form-group">
                            <label for="email_update_input" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="email_update_input"
                                       placeholder="empName@123.com">
                                <!-- 用来显示错误提示 -->
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <!-- 性别 -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Gender</label>
                            <div class="col-sm-10">
                                <!-- 单选 -->
                                <label for="gender1_update_input"> <input type="radio"
                                                                          name="gender" id="gender1_update_input" name="gender" value="M" checked>
                                    男
                                </label>
                                <label for="gender2_update_input"> <input type="radio"
                                                                          name="gender" id="gender2_update_input" name="gender" value="F">
                                    女
                                </label>
                            </div>
                        </div>
                        <!-- 部门下拉框 -->
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">DeptName</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="dId" id="deptName_update_select"></select>
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>


    <!-- 为新增按钮增加模态框 ，利用按钮绑定单击事件-->
    <!-- Modal -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <!-- 添加表单 -->
                    <form class="form-horizontal" id="model-form">
                        <!-- 姓名 -->
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input"
                                       placeholder="empName">
                                <!-- 用来显示错误提示 -->
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <!-- 邮箱 -->
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="email_add_input"
                                       placeholder="empName@123.com">
                                <!-- 用来显示错误提示 -->
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <!-- 性别 -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Gender</label>
                            <div class="col-sm-10">
                                <!-- 单选 -->
                                <label for="gender1_add_input"> <input type="radio"
                                                                       name="gender" id="gender1_add_input"
                                                                       name="gender" value="M" checked>
                                    男
                                </label>
                                <label for="gender2_add_input"> <input type="radio"
                                                                       name="gender" id="gender2_add_input"
                                                                       name="gender" value="F">
                                    女
                                </label>
                            </div>
                        </div>
                        <!-- 部门下拉框 -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">DeptName</label>
                            <div class="col-sm-10">
                                <!-- 部门下拉列表使用ajax查询出来的动态拼接，值为部门id -->
                                <select class="form-control" name="dId" id="deptName_add_select"></select>
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
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

                </tbody>
            </table>
        </div>

    </div>
    <!-- 分页数据 暂时占据位置，之后需要拼接-->
    <div class="row">

        <div class="col-md-4" id="page_info_area">

        </div>
        <div class="col-md-6 col-md-offset-7" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    //全局参数，totalRecord总数据数，用来跳到最后一页,formXxxSubmit用来判断是否能提交，currentPage当前页
    var totalRecord, formNameSubmit, formEmailSubmit, currentPage;
    //1.页面加载完成后，直接发送ajax请求，要到分页数据
    $(function () {
        //页面加载后去首页
        to_page(1);
    });

    //2.查询指定页数据
    function to_page(pn) {
        //翻页时取消全选状态，防止全选后没删除就翻页
        $("#check_all").prop("checked",false);
        $.ajax({
            url: "${PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result)
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页栏
                build_page_nav(result);
            }
        });
    }

    //构建员工表
    function build_emps_table(result) {
        //每次构建之前要清空
        $("#emps_table tbody").empty();

        //获取到员工列表
        var emps = result.extend.pageInfo.list;
        //利用jQuery的each遍历,index:索引 item：当前对象
        $.each(emps, function (index, item) {
            //alert(item.empName);
            //创建出要展示的<td>标签
            var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(
                item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>")
                .append(item.department.deptName);

            //1. 在修改删除按钮上统一添加 类标识 edit_btn  delete_btn
            var editBtn = $("<button></button>").addClass(
                "btn btn-primary btn-sm edit_btn").append("<span></span>")
                .addClass("glyphicon glyphicon-pencil").append("编辑");
            editBtn.attr("edit-id", item.empId);

            //2. 在 编辑/删除 按钮上添加当前所选对象id.或者从这个的父层查找第一个tr第一个td的值
            var delBtn = $("<button></button>").addClass(
                "btn btn-danger btn-sm delete_btn").append("<span></span>")
                .addClass("glyphicon glyphicon-trash").append("删除");
            delBtn.attr("del-id", item.empId);

            //将俩个按钮放到td中去
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(
                delBtn);
            //append方法执行完之后还返回原来的元素，就是tr，可以继续添加
            $("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd).append(
                genderTd).append(emailTd).append(deptNameTd).append(
                btnTd)
                //添加到
                .appendTo("#emps_table tbody")
        });
    }


    //解析构建分页信息
    function build_page_info(result) {
        //每次构建之前要清空
        $("#page_info_area").empty();

        $("#page_info_area").append(
            "当前第" + result.extend.pageInfo.pageNum + "页，总"
            + result.extend.pageInfo.pages + "页，总"
            + result.extend.pageInfo.total + "条数据");
        //全局参数，获取总记录数，用来跳到最后一页
        totalRecord = result.extend.pageInfo.total;
        //currentPage当前页
        currentPage = result.extend.pageInfo.pageNum;
    }

    //构建分页栏
    function build_page_nav(result) {
        //每次构建之前要清空
        $("#page_nav_area").empty();

        var nav = $("<nav></nav>");
        var ul = $("<ul></ul>").addClass("pagination");
        //首页，尾页，上一页，下一页
        var firstPageLi = $("<li></li>").append(
            $("<a></a>").append("首页").attr("href", "#"));
        var lastPageLi = $("<li></li>").append(
            $("<a></a>").append("尾页").attr("href", "#"));
        var prePageLi = $("<li></li>").append(
            $("<a></a>").append($("<span></span>").append("&laquo;")));
        var nextPageLi = $("<li></li>").append(
            $("<a></a>").append($("<span></span>").append("&raquo;")));
        //var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));

        //判断是否有前一页,如果没有则禁用，否则才添加点击事件
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为首页上一页添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        //判断是否有后一页，如果没有则禁用，否则才添加点击事件
        if (result.extend.pageInfo.hasNextPage == false) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        } else {
            //为下一页尾页添加点击事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            })
        }

        //1.添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);
        //连续显示的页
        $.each(result.extend.pageInfo.navigatepageNums, function (index,
                                                                  item) {
            //2.添加连续的页
            var numLi = $("<li></li>").append(
                $("<a></a>").append(item).attr("href", "#"));
            //设置当前页激活状态，如果当前页就是被遍历的页，添加激活样式
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            //添加点击事件，这个li被点击就跳转 新请求会将数据再次渲染，页面就乱了，需清空
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //3.添加下一页和尾页
        ul.append(nextPageLi).append(lastPageLi);
        //4.将整个分页栏添加到合适位置
        $("#page_nav_area").append(ul);

    }



    //新增模态框--点击
    $("#emp_add_modal_btn").click(function () {
        //添加模态栏之前将所表单信息清空，包括两项验证的css样式，显示模态栏之后就是空的
        //reset()方法是dom下的，使用[0]
        $("#empAddModal form")[0].reset();
        //清空输入格式、重名校验的css样式
        reset_form("#empAddModal form");
        //获取所有部门信息
        getDepts("#deptName_add_select");
        //添加模态框，在模态框中需要所有部门，所以需要查询所有部门信息
        $("#empAddModal").modal({
            //模态框参数，点击背景不关闭
            backdrop: "static"
        });
    });

    //新增模态框--清除表单数据，样式
    function reset_form(ele) {
        $(ele)[0].reset();
        //该元素下所有css清除
        $(ele).find("*").removeClass("has-error has-success");
        //显示警告信息部分清空
        $(ele).find(".help-block").text("");
    }

    //新增模态框--请求所有部门信息
    function getDepts(ele) {

        //---注意这里要清空---
        $(ele).empty();
        $.ajax({
            url: "${PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                $.each(result.extend.depts, function (index, item) {
                    //创建出option并添加到select中
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //=========================增删改查都使用REST风格=========================

    //----------------添加------------------
    //1.（内部Java格式验证）+ ajax用户名验证
    //新增保存信息--ajax用户名校验
    //由于在java内又做了一次格式验证，所以这个方法相当于即验证了格式，又验证了重名
    $("#empName_add_input").blur(function () {
        //不要用方法二！！
        //方法二：在用户名校验之前进行格式校验，如果没通过格式校验就不会进行用户名，
        // if(!form_checkname("#empName_add_input")&&!form_checkname("#email_add_input")){
        //     return false;
        // }
        // form_checkname("#empName_add_input");
        // form_checkemail("#email_add_input");
        // if((formNameSubmit!=true) && (formEmailSubmit!=true)){
        //     return false;
        // }

        //发送ajax请求，验证用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${PATH}/checkname",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                console.log(result);
                //获取到返回值，Msg中的状态码
                if (result.code == 2333) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    //因为使用了两种方式验证，格式和重名，会有css样式冲突覆盖，所以再加一次验证
                    //自定义属性，或全局变量
                    //方法一：给添加按钮添加自定义属性，在提交时判断是否通过两项验证。
                    $("#emp_save_btn").attr("ajax-vl", "success");
                    //方法二：设置全局变量
                    //全局变量判断能否提交
                    //formNameEmail = true;

                } else if (result.code == 5555) {
                    show_validate_msg("#empName_add_input", "error", result.extend.msg);
                    //方法一：
                    $("#emp_save_btn").attr("ajax-vl", "error");
                    //方法二：设置全局变量
                    //全局变量判断能否提交
                    //formNameEmail = true;
                }
            }
        });
    });

    //2. 邮箱独立验证
    //新增保存信息--独立邮箱格式验证
    $("#email_add_input").blur(function () {
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            //return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        //最后方法通过
        //return true;
    })

    //3. 格式+用户名验证+提交保存请求，一共有两种验证方式 1.输入框焦点单独验证 2.提交按钮总验证，
    //为了不两种方式的css样式相互覆盖，每种方式都验两遍，格式在前，用户名在后
    //新增保存信息--请求
    $("#emp_save_btn").click(function () {
        //点击就发送请求，保存使用POST请求

        //方法二忽略，不成功，没有使用
        //方法二总验证,如果直接提交，就会提交空的，这里还是在验证一下，有点麻烦，因为用户名验证只对
        //用户名输入框有效，对邮箱输入框没效，所以在用户名验证之前还要验证输入格式
        // form_checkname("#empName_add_input");
        // form_checkemail("#email_add_input");
        // if((formNameSubmit!=true) && (formEmailSubmit!=true)){
        //    return false;
        // }

        //1.先验证ajax重名校验，防止用户输入重复用户名之后，直接输入正确的邮箱，点击提交，重名的验证提示会被覆盖
        if ($(this).attr("ajax-vl") == "error") {
            return false;
        }
        //2.点击保存按钮请求之前完整验证一遍输入格式
        console.log("JQuery格式总验证")
        //方法一：JQuery格式总验证
        if (!validate_add_form()) {
            return false;
        }
        //3.重名验证
        console.log("ajax重名校验")
        //ajax重名校验
        if ($(this).attr("ajax-vl") == "error") {
            return false;
        }
        //1、模态框中填写的表单数据提交给服务器进行保存
        //2、发送ajax请求保存员工
        $.ajax({
            url: "${PATH}/saveemp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            //.serialize()方法能将表单中数据序列化，直接发送给controll封装成Bean
            //console.log($("#empAddModal form").serialize());
            //empName=Tom&email=Tom%40123.com&gender=M&dId=1
            success: function (result) {

                //清除模态框和提示信息
                $("#empAddModal form").find("*").removeClass("has-error has-success");
                $("#empAddModal form").find(".help-block").text("");

                //在这里判断后端JSR303校验结果，最后一次！！！！！！！！！
                //前后端验证可以独立运行，注释前端后端也能实现一样效果
                if(result.code == 2333){

                    //alert(result.msg);
                    //1.添加成功，关闭模态框
                    $("#empAddModal").modal("hide");
                    //2.来到最后一页，显示插入的数据，可以直接跳到一个很大的页数，因为
                    //合理性，所以不会超出，这里使用全局参数，数据总条数+1保证不出现极端情况
                    to_page(totalRecord + 1);
                }else{
                    //失败，显示信息，有几个就显示几个
                    //undefined 就是没找到这个错误，说明正确，可用alert(result.extend.errorFields.empName)验证
                    //用户名格式
                    //alert(result.extend.errorFields.empName)

                    //用户名格式和查重，因为查重的属性格式和格式验证不同，所以不能分开
                    //result.extend.errorFields.empName 格式验证
                    //result.extend.empName 查重验证
                    if(undefined != result.extend.errorFields ){
                        //格式错误
                        if(undefined != result.extend.errorFields.empName){
                            show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                        }
                    }else{
                        if(undefined != result.extend.empName){
                            //查重错误
                            show_validate_msg("#empName_add_input","error",result.extend.empName);
                        }
                    }
                    //邮箱格式判断
                    if(undefined != result.extend.errorFields){
                        if(undefined != result.extend.errorFields.email){
                            show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                        }
                    }
                }
            }
        });
    });

    //新增保存信息--请求按钮JQuery格式总校验方法
    function validate_add_form() {
        console.log("validate_add_form()")
        //1.拿到校验的数据，使用正则表达式
        //根据bootstrap提供的组件
        //校验用户名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{2,8}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者2-8位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者2-8位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        //2、校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        //最后方法通过
        return true;
    }

    //新增保存信息--添加css样式
    //show_validate_msg显示校验状态，通过添加样式，ele表示被选择元素，status状态
    //用来判断是用什么样式，绿色、红色，msg提示信息
    function show_validate_msg(ele, status, msg) {
        //判断之前先清空之前样式
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg)
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg)
        }
    }

    //下面两方法没用，忽略
    //格式校验方法二：利用全局变量分开表示用户名和邮箱，只有两个全局变量都为true，才能
    //新增保存信息--方法二：用户名格式校验
    function form_checkname(ele) {
        var empName = $(ele).val();
        var regName = /(^[a-zA-Z0-9_-]{2,8}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者2-8位英文和数字的组合");
            show_validate_msg(ele, "error", "用户名可以是2-5位中文或者2-8位英文和数字的组合");
            //全局变量判断能否提交
            formNameSubmit = false;
            return false;
        } else {
            show_validate_msg(ele, "success", "");
            //全局变量判断能否提交
            formNameSubmit = true;
        }
        return true;
    }
    //新增保存信息--方法二：邮箱格式校验
    function form_checkemail(ele) {
        var email = $(ele).val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg(ele, "error", "邮箱格式不正确");
            //方法一：
            $("#emp_save_btn").attr("ajax-vl", "error");
            //方法二：设置全局变量
            //全局变量判断能否提交
            formNameEmail = false;
            return false;
        } else {
            show_validate_msg(ele, "success", "");
            //方法一：
            $("#emp_save_btn").attr("ajax-vl", "success");
            //方法二：设置全局变量
            //全局变量判断能否提交
            formNameEmail = true;
        }
        return true;
    }

    //----------------------修改------------------------
    //利用on()方法来绑定事件，用参数指定被添加子元素，因为事件在在页面加载时就绑定了，而按钮是在页面加载之后ajax
    //请求发送之后创建，使所以不能用click事件，而document是一开始就存在的
    $(document).on("click",".edit_btn",function(){

        //一定要注意的顺序，要查出部门之后再回显！！！！！！！！！！！！！！！！

        //2.查出部门信息
        getDepts("#empUpdateModal select");
        //1.查出员工信息
        getEmp($(this).attr("edit-id"));
        // //3.保存id更新用
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //显示模态栏
        $("#empUpdateModal").modal({
            backdrop : "static"
        });
    })

    //ajax查询员工信息  REST风格编程 GET path/emp/1
    function getEmp(id){
        $.ajax({
            url:"${PATH}/emp/"+id,
            type:"GET",
            success:function(result){
                console.log(result)
                $("#empName_update_input").text(result.extend.emp.empName);
                $("#email_update_input").val(result.extend.emp.email);
                $("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);
                $("#deptName_update_select").val([result.extend.emp.dId]);
                //回显注意顺序，先查出部门，再回显
                //alert(result.extend.emp.dId)
                //$("#empUpdateModal select").attr("value",result.extend.emp.dId);
            }
        });
    }

    //给更新模态框表单验证邮箱
    $("#email_update_input").change(function(){
        form_checkemail("#email_update_input");
    })

    //给更新按钮添加更新 REST风格编程 PUT path/emp/1
    //方法一：普通请求 type=POST;data:xxx&_method=PUT，就是添加一个_method=PUT，在表单中使用时一般设为hidden
    //hiddenHttpMethodFilter过滤器会把普通请求转成PUT，DELETE
    /*$("#emp_update_btn").click(function(){
        $.ajax({
            url:"${PATH}/emp/"+$(this).attr("edit-id"),
				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				success:function(result){
					console.log(result)
				}
			});
		});*/
    //方法二：添加过滤器FormContentFilter,不要添加HttpPutFormContentFilter，他过时了
    $("#emp_update_btn").click(function(){
        $.ajax({
            url:"${PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function(result){
                console.log(result)
                //成功之后
                //1.关闭模态框
                $("#empUpdateModal").modal("hide");
                //2.回到本页面，全局参数，在分页数据部分记录的
                to_page(currentPage);
            }
        });
    });

    //删除 单个
    $(document).on("click",".delete_btn",function(){
        //弹出删除框，使用按钮父元素tr的第二个td，找到名字
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        //找到被点击的id
        var delId = $(this).attr("del-id");
        //confirm确认框
        if(confirm("确认删除【"+empName+"】？")){
            //可以删除
            $.ajax({
                url:"${PATH}/emp/"+delId,
                type:"DELETE",
                success:function(result){
                    console.log(result);
                    //删除之后，回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //全选/全不选
    $("#check_all").click(function(){
        //attr不能获取状态undefined
        //dom原生属性：attr获取自定义属性值
        //prop修改读取原生属性值，官方的建议：具有 true 和 false 两个属性的属性，
        //如 checked, selected 或者 disabled 使用prop()，其他的使用 attr()
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //单选5个(当页所有)则全选
    $(document).on("click",".check_item",function(){
        //如果多选框选中个数等于当页所有，意味全部选中，修改全选状态
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    //删除多选
    $(document).on("click","#emp_del_modal_btn",function(){
        //需要获取 名字，id 才能删
        var empNames = "";
        var empIds = "";
        $.each($(".check_item:checked"),function(index,item){
            //item是这个checkbox，找到父元素tr，找到第三个td 就是name
            //"," 拼接姓名
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //"-" 拼接id,用于发送后台批量删除
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除多余拼接","
        empNames = empNames.substring(0,empNames.length-1);
        //去除多余拼接"-"
        empIds = empIds.substring(0,empIds.length-1);
        if(empIds!=""){
            //确认删除
            if(confirm("确认删除【" + empNames + "】？")){
                //发送ajax批量删除，REST风格 DELETE 单个，批量删除二合一
                $.ajax({
                    url:"${PATH}/emp/"+empIds,
                    type:"DELETE",
                    success:function(result){
                        console.log(result);
                        to_page(currentPage);
                    }
                });
            }

        }
    });
</script>
</body>
</html>
