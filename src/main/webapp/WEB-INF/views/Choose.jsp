<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/4/30 0030
  Time: 21:03
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
        .model{
            font-size: 30px;
            width: 200px;
            height: 200px;
            background-color: rgba(255,255,255,0.4);
            line-height: 200px;
            margin: 30px 30px;
            float: left;
            text-align: center;
            display: block;
            cursor: pointer;
        }
        .model:hover{
            background-color: rgba(255,255,255,0.8);
            color: blue;
        }
        .msg{
            color: white;
            float: right;
            margin-right: 75px;
            font-size: 18px;
            margin-top: 15px;
        }
        .choose{
            width: 80%;
            height: 80%;
            position: absolute;
            top: 80px;
            left: 135px;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

    <div class="background">
        <div class="msg">管理员[ ${sessionScope.concurrentAdmin.adminName} ]已登录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/adminOut" style="text-decoration: none;font-size: 18px;color: red">登出 <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a></div>
        <div class="choose">
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>
            <div><a class="model" href="${pageContext.request.contextPath}/empList"  style="text-decoration: none">员工管理</a></div>

        </div>

    </div>

</body>
</html>
