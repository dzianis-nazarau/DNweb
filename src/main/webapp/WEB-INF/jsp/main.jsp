<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 05.02.2021
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Web-Bank</title>
    <link rel="stylesheet" href="css/login.css">
    <link rel="import" href="common.html">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script>
        function registerUser(){
            $.ajax({
                url:"/api/v1/registerUser",
                type:"POST",
                data: '{"username": "' + document.getElementById('username').value + '",' +
                    '"password": "' + document.getElementById("password").value + '",' +
                    '"email": "' + document.getElementById("email").value + '"}',
                contentType:"application/json;",
                dataType:"json",
                success: function(data){
                    $(".login_li").click();
                    alert("OK")

                },
                error: function(data) {
                    alert("fail");

                }
            })

        }
    </script>

    <script>
        $(document).ready(function(){
            $(".register").hide();
            $(".login_li").addClass("active");

            $(".register_li").click(function(){
                $(this).addClass("active");
                $(".login_li").removeClass("active");
                $(".register").show();
                $(".login").hide();
            })

            $(".login_li").click(function(){
                $(this).addClass("active");
                $(".register_li").removeClass("active");
                $(".login").show();
                $(".register").hide();
            })
        });
    </script>

</head>
<body>
<jsp:include page="common.jsp" />
<div class="wrapper">
    <div class="left">
        <h3>Web Bank</h3>
        <img src="image/bank.png" alt="Bank image">
    </div>
    <div class="right">
        <div class="tabs">
            <ul>
                <li class="register_li"><spring:message code="main_registration"/></li>
                <li class="login_li"><spring:message code="main_login"/></li>
            </ul>
        </div>

        <div class="register">
            <div class="input_field">
                <input type="text" placeholder=<spring:message code="main_username_placeholder"/> class="input" id="username">
            </div>
            <div class="input_field">
                <input type="text" placeholder=<spring:message code="main_email_placeholder"/> class="input" id="email">
            </div>
            <div class="input_field">
                <input type="password" placeholder=<spring:message code="main_password_placeholder"/> class="input" id="password">
            </div>
            <input type="button" value=<spring:message code="main_registration"/> onclick="registerUser()"/>
        </div>

        <div class="login">
            <form method="POST" action="/main">
                <div class="input_field">
                    <input type="text" placeholder=<spring:message code="main_username_placeholder"/> class="input" name="user">
                </div>
                <div class="input_field">
                    <input type="password" placeholder=<spring:message code="main_password_placeholder"/> class="input" name="pwd">
                </div>
                <input type="submit" value=<spring:message code="main_login"/>>
            </form>
        </div>

    </div>
</div>
</body>
</html>
