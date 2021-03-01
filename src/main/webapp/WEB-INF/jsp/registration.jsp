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
                data: JSON.stringify({ username: "John", password: "ololo", email: "testemail" }),
                contentType:"application/json;",
                dataType:"json",
                success: function(data){
                    $('body').append('<label style="color: darkcyan">data</label>');
                },
                error: function (data){
                    alert( "Fail: " + data);
                }
            })

        }
    </script>
</head>
<body>
<h1>Registration</h1>
<form method="POST" id="registerForm" >
    <label for="username">Username: </label>
    <input type="text" id="username"/><br/>
    <label for="password">Password: </label>
    <input type="password" id="password"/><br/>
    <label for="confirm">Confirm password: </label>
    <input type="password" id="confirm"/><br/>
    <label for="fullname">Full name: </label>
    <input type="text" id="fullname"/><br/>
    <label for="street">Street: </label>
    <input type="text" id="street"/><br/>
    <label for="city">City: </label>
    <input type="text" id="city"/><br/>
    <label for="state">State: </label>
    <input type="text" id="state"/><br/>
    <label for="email">Email: </label>
    <input type="text" id="email"/><br/>
    <label for="phone">Phone: </label>
    <input type="text" id="phone"/><br/>

    <input type="button" value="Magic Button" onclick="magicButtonClick()"/>
    <input type="button" value="Magic Button" onclick="magicButtonClick()"/>
</form>
</body>
</html>
