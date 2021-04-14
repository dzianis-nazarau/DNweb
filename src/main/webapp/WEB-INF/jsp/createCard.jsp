<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 05.02.2021
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
<head>
    <title>Web-Bank</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>

        function createCard(){
            let checkBox = document.getElementById("terms");
            if(checkBox.checked) {
                $.ajax({
                    url:"/api/v1/createCard?currency=" + document.getElementById("currency").value,
                    success: function(){
                        swal("OK")
                    },
                    error: function(data) {
                        let message = data.responseText;
                        swal("Failed", message, "error");
                    }
                })
            } else {
                swal("Warning", "Please, agree terms" , "warning")
            }

        }

        function goBack() {
            window.history.back();
        }

    </script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Raleway:wght@300&display=swap');
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            outline: none;
            text-decoration: none;
            list-style: none;
            font-family: 'Nunito', sans-serif;
        }
    </style>
</head>
<body>
<jsp:include page="common.jsp" />
<div id="languages" style="float: right">
    <a href="/logout"><img src="image/exit.png" alt="Exit" style="width:40px;height:40px;margin-right:10px"></a>
</div>
<h1><spring:message code="card_create_head"/></h1>

<div id="card">
    <h2><spring:message code="card_create_agreement"/></h2>
        <input type="checkbox" id="terms" required><p>I agree to the <a href="ds">Bank Agreement</a></p>
        <br/>
        <label for="currency"><spring:message code="card_create_currency"/> </label>
        <select  id="currency">
            <option value="BYN">BYN</option>
            <option value="USD">USD</option>
        </select>
        <button onclick="goBack()"><spring:message code="btn_back"/></button>
        <button onclick="createCard()"><spring:message code="btn_create"/></button>
</div>

</body>
</html>

