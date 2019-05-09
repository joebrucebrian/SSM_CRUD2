<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/4/30 0030
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        *{margin: 0px ; padding: 0px}
        .background{
            width: 100%;
            height: 100%;
            background-image: url("${pageContext.request.contextPath}/static/imgs/bg.jpg");
            background-size: cover;
            position: absolute;
        }
        .back{
            width: 70%;
            height: 525px;
            background-color: rgba(255,255,255,0.8);
            position: absolute;
            top:40px;
            left:200px;
            float: left;
            border-radius: 20px;
        }
        .out{
            float: right;
            position: absolute;
            right: 20px;
            bottom: 20px;
        }

    </style>
    <%--不以/开始的相对路径找资源时是以当前资源的路径为基准，容易出问题
    以/开始的相对路径，找资源以服务器的路径为标准（http://localhost:3306/WebApp）--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="background">
        <div class="back">
            <div class="out">
                <button type="button" class="btn btn-default btn-lg">
                    <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> 返回
                </button>
            </div>
        </div>
        <br>
        <br>
        <div class=".container">
            <%--标题--%>
            <div class="row">
                <div class="col-md-4 col-md-offset-2">
                    <h2 style="font-family: 微软雅黑">员工列表</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2 col-md-offset-8">
                    <button class="btn btn-default btn-sm" id="emp_add_modal_button"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 新增</button>
                    <button class="btn btn-default btn-sm" id="emp_delete_all_button"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除</button>
                </div>
            </div>
            <br>
            <%--表格--%>
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <table class="table table-striped table-hover" id="emps_table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>邮箱</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
            <div style="font-size: 14px;line-height: 14px;text-align: center;color:black " id="msg">

            </div>

            <%--分页信息--%>
            <div align="center">
                <nav aria-label="Page navigation" id="nav">

                </nav>
            </div>
        </div>

        <%--*************************************************************************************************************--%>

        <!-- 员工添加的模态框 -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%--模态框头--%>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">添加员工</h4>
                    </div>

                    <%--模态框内容--%>
                    <div class="modal-body">
                        <%--表单--%>
                        <form class="form-horizontal" action="${pageContext.request.contextPath}/add" method="post">
                            <div class="form-group">
                                <label for="empName_add_input" class="col-sm-2 control-label">姓名:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="empName" class="form-control" id="empName_add_input">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">性别:</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email_add_input" class="col-sm-2 control-label">邮箱:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="email" class="form-control" id="email_add_input">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">部门:</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="dId" id="dept_add_input">

                                    </select>
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
    </div>


<%----------------------------------------------------------------------------------------------------------%>

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <%--模态框头--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >信息修改</h4>
            </div>

            <%--模态框内容--%>
            <div class="modal-body">
                <%--表单--%>
                <form class="form-horizontal" action="${pageContext.request.contextPath}/add" method="post">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名:</label>
                        <div class="col-sm-9">
                            <p class="form-control-static" id="empName_update_static">

                            </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门:</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_input">

                            </select>
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

<%--******************************************************************************************************--%>

<script>
    var totalRecord,currentPage;
    <%--1.页面加载完成后，直接去发送一个ajax请求，要到分页数据--%>
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${pageContext.request.contextPath}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function (result) {
                // 1.解析并显示员工数据
                build_emps_table(result);
                // 2.解析并显示分页信息
                build_page_info(result);
                // 3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        var i;
        $.each(emps,function (index, item) {
            i = index + 1;
            var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'/>").attr("delete_id",item.empId).attr("delete_name",item.empName));
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var empEmailTd = $("<td></td>").append(item.email);
            var empDeptNameTd = $("<td></td>").append(item.department.deptName);
            // var editBtn = $("<button class=\"btn btn-default btn-sm\"><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span> 编辑</button>");
            var editBtn = $("<button></button>").addClass("btn btn-default btn-sm edit_btn").attr("edit_id",item.empId).append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
            // var delBtn = $("<button class=\"btn btn-default btn-sm\"><span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span> 删除</button>");
            var delBtn = $("<button></button>").addClass("btn btn-default btn-sm delete_btn").attr("delete_id",item.empId).attr("delete_name",item.empName).append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");
            var btnTd = $("<td></td>").append(editBtn).append("  ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd).append(empIdTd)
                .append(empNameTd).append(empGenderTd)
                .append(empEmailTd).append(empDeptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
        for (var x=0; x < (result.extend.pageInfo.navigatePages)-i;x++){
            $("<tr></tr>").append($("<td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td>")).appendTo("#emps_table tbody");
        }


    }
    function build_page_info(result) {
        $("#msg").empty();
        var pageNum = result.extend.pageInfo.pageNum;
        var pages = result.extend.pageInfo.pages;
        var total = result.extend.pageInfo.total;
        totalRecord = total;
        currentPage = pageNum;
        $("<span></span>").append("当前第 ").append(pageNum).append(" 页，总 ").append(pages).append(" 页，共 ").append(total).append(" 条记录").appendTo("#msg");
    }
    function build_page_nav(result) {
        $("#nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if(item == result.extend.pageInfo.pageNum){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi).appendTo("#nav");
    }


    // *******************************************************************************************************



    //    添加用户模态框
    $("#emp_add_modal_button").click(function () {
        //清除表单数据
        $("#empAddModal form")[0].reset();
        //清空显示状态
        $("#empName_add_input").parent().removeClass("has-success has-error");
        $("#empName_add_input").next("span").text("");
        $("#email_add_input").parent().removeClass("has-success has-error");
        $("#email_add_input").next("span").text("");
        //查询所有部门信息
        getDepts("#dept_add_input");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });

    });
    //查询所有部门信息并填入模态框
    function getDepts(ele) {
        //清空之前下拉列表里的值
        $(ele).empty();
        $.ajax({
            url:"${pageContext.request.contextPath}/depts",
            type:"GET",
            success:function (result) {
                $("#dept_add_input").empty();
                var depts = result.extend.deptList;
                $.each(depts,function (index,item) {
                    $("<option></option>").append(item.deptName).attr("value",item.deptId).appendTo(ele);
                });
            }
        });
    }




    //将模态框填写的信息交给服务器进行保存
    //保存员工方法
    $("#emp_save_btn").click(function () {
        //1.检查信息不能为空
        var name = $("#empName_add_input").val();
        var email = $("#email_add_input").val();
        if( name == "" || email == ""){
            alert("信息不能为空");
            return false;
        }
        //2.检查姓名
        if( !emp_name_ok ){
            alert("用户名不可用");
            return false;
        };
        //3.检查邮箱
        if( !email_ok ){
            alert("邮箱不可用");
            return false;
        };


        //发送ajax请求进行保存
        $.ajax({
            url:"${pageContext.request.contextPath}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //后端校验成功
                if(result.code == 100){
                    $('#empAddModal').modal('hide');
                    alert(result.msg);
                    to_page(totalRecord);
                }
                //后端校验不成功
                else {
                    //显示错误信息
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        })
    });

    //设置用户名正确标志，正确为true，不正确为false
    var emp_name_ok = false;

    //当用户名填写完成进行校验
    $("#empName_add_input").change(function () {
        var empName = this.value;
        //1.检查格式
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF0-9]{2,5}$)/;
        //使用正则表达式校验
        if( !regName.test(empName)){
            show_validate_msg("#empName_add_input","error","用户名必须是2-5位中文和数字的组合或者6-16位英文和数字的组合");
            emp_name_ok = false;
        }
        //验证格式没问题了之后
        else {
            //2.检查重复
            $.ajax({
                url:"${pageContext.request.contextPath}/checkuser",
                data:"empName=" + empName,
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        emp_name_ok = true;
                    }else {
                        show_validate_msg("#empName_add_input","error","用户已存在");
                        emp_name_ok = false;
                    }
                }
            })
        };

    });

    //设置email正确标志，正确为true，不正确为false
    var email_ok = false;

    //当email填写完成之后进行校验
    $("#email_add_input").change(function () {
        var email = this.value;
        //检查格式
        var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if( !regEmail.test(email) ){
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            email_ok = false;
        }else {
            show_validate_msg("#email_add_input","success","该邮箱可用");
            email_ok = true;
        }

    });


    //显示提示信息校验结果
    function show_validate_msg(ele,status,msg) {
        //清除当前元素校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        //显示提示信息
        if(status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status == "error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }


    //*******************************************************************************************


    // 修改用户模态框
    $(document).on("click",".edit_btn",function () {
        $("#email_update_input").parent().removeClass("has-success has-error");
        $("#email_update_input").next("span").text("");
        //查询所有部门信息
        getDepts("#dept_update_input");
        //查出员工信息并显示
        getEmp($(this).attr("edit_id"));
        //把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    //查询要修改的员工信息
    function getEmp(id) {
        $.ajax({
            url:"${pageContext.request.contextPath}/emp/" + id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal select").val([empData.dId]);
                //把用户名传给更新按钮
                $("#emp_update_btn").attr("edit_name",empData.empName);
            }
        });

    }

    $("#emp_update_btn").click(function () {
        //1.检查信息不能为空
        var email = $("#email_update_input").val();
        if( email == ""){
            alert("信息不能为空");
            return false;
        }
        //2.检查邮箱
        if( !email_update_ok ){
            alert("邮箱不可用");
            return false;
        };


        //3.发送ajax请求进行更新
        $.ajax({
            url:"${pageContext.request.contextPath}/emp/" + $(this).attr("edit_id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize()+"&empName="+$(this).attr("edit_name"),
            success:function (result){
                //后端校验成功
                if(result.code == 100){
                    $('#empUpdateModal').modal('hide');
                    alert(result.msg);
                    to_page(currentPage);
                }
                //后端校验不成功
                else {
                    //显示错误信息
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_update_input","error",result.extend.errorFields.email);
                    }
                }
            }
        });




    });

    //设置email正确标志，正确为true，不正确为false
    var email_update_ok = true;

    //当email填写完成之后进行校验
    $("#email_update_input").change(function () {
        var email = this.value;
        //检查格式
        var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if( !regEmail.test(email) ){
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            email_update_ok = false;
        }else {
            show_validate_msg("#email_update_input","success","该邮箱可用");
            email_update_ok = true;
        }

    });

    //*********************************************************************************************

    //删除员工
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否确认对话框
        // $(this).parents("tr").find("td:eq(1)").text();
        var empname = $(this).attr("delete_name");
        var empid = $(this).attr("delete_id");
        if(confirm("确认删除【"+empname+"】吗？")){
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/" + empid,
                type:"DELETE",
                success:function (result) {
                    if(result.code == 100){
                        alert("删除成功");
                    }else {
                        alert("删除失败");
                    }
                    to_page(currentPage);

                }
            });
        }

    });

    //全选或者全不选
    $("#check_all").click(function () {
        //attr获取自定义属性值，prop获取原生属性值
        //checked选中返回true，未选中返回false
        //让所有check_item的checked属性和全选按钮一样
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //底下全添加了，上面也要全选
    $(document).on("click",".check_item",function () {
        //判断当前选中的个数是否是所有check_item的个数
        var allinflug = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",allinflug);
    });

    //批量删除
    $("#emp_delete_all_button").click(function () {
        if($(".check_item:checked").length >0){
            var empNames = "";
            var empIds = "";
            $.each($(".check_item:checked"),function (index,item) {
                empNames += $(this).attr("delete_name") + (index+1 == $(".check_item:checked").length ? "":",");
                empIds += $(this).attr("delete_id") + (index+1 == $(".check_item:checked").length ? "":",");
            })
            if(confirm("确认删除【"+ empNames +"】吗？")){
                //发送ajax删除
                $.ajax({
                    url:"${pageContext.request.contextPath}/emp/" + empIds,
                    type:"DELETE",
                    success:function (result) {
                        if(result.code == 100){
                            alert("删除成功");
                        }else {
                            alert("删除失败");
                        }
                        to_page(currentPage);
                    }
                });
            }
        }else {
            alert("请选择要删除的员工");
        }

    });

    $(".out").click(function () {
        window.location.href="${pageContext.request.contextPath}/choose";
    });

</script>
</body>
</html>