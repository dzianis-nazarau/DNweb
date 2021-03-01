<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script>
        function magicButtonClick(){
            /*let xhttp = new XMLHttpRequest();
            xhttp.open("POST", "/api/v1/registerUser", true);
            xhttp.setRequestHeader("Content-type", "application/json");
            xhttp.send('{ "username":"' + document.getElementById('username').value + '" }');*/
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
<div class="wrapper">
    <div class="left">
        <h3>Web Bank</h3>
<%--        <img src="https://i.imgur.com/eN4AKys.png" alt="Rocket_image">--%>
    </div>
    <div class="right">
        <div class="tabs">
            <ul>
                <li class="register_li">Register</li>
                <li class="login_li">Login</li>
            </ul>
        </div>

        <div class="register">
            <div class="input_field">
                <input type="text" placeholder="Username" class="input" id="username">
            </div>
            <div class="input_field">
                <input type="text" placeholder="E-mail" class="input" id="email">
            </div>
            <div class="input_field">
                <input type="password" placeholder="Password" class="input" id="password">
            </div>
            <input type="button" value="Register" onclick="magicButtonClick()"/>
        </div>

        <div class="login">
            <form method="POST" action="/main">
                <div class="input_field">
                    <input type="text" placeholder="Username" class="input" name="user">
                </div>
                <div class="input_field">
                    <input type="password" placeholder="Password" class="input" name="pwd">
                </div>
                <input type="submit" value="Login">
            </form>
        </div>

    </div>
</div>
</body>
</html>
