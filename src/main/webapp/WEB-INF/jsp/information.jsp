<%--
  Created by IntelliJ IDEA.
  Servlets.User: Servlets.User
  Date: 15.11.2020
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>MyWebApp</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script>
        function magicButtonClick(){
            /*let xhttp = new XMLHttpRequest();
            xhttp.open("POST", "/api/v1/registerUser", true);
            xhttp.setRequestHeader("Content-type", "application/json");
            xhttp.send('{ "username":"' + document.getElementById('username').value + '" }');*/
            $.ajax({
                url:"/api/v1/currency?baseCurrency=933",
                success: function(){
                    alert("OK")
                },
                error: function() {
                    alert("fail");

                }
            })

        }
    </script>
</head>
<body>
<input type="button" value="Currencies" onclick="magicButtonClick()"/>

<%--    <p><a href="http://localhost:8080/myWeb_war/userPage">Back</a></p>--%>

</body>
</html>
