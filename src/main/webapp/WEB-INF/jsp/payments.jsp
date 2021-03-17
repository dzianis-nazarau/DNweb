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

        function doNewPayment(){
            $.ajax({
                url:"/api/v1/newPayment",
                type:"POST",
                data: '{"sourceCardNumber": "' + document.getElementById('card').value + '",' +
                    '"payee": "' + document.getElementById("account").value + '",' +
                    '"amount": "' + document.getElementById("amount").value + '",' +
                    '"description": "' + document.getElementById("description").value + '"}',
                contentType:"application/json;",
                success: function(){
                    PopUpShow();
                },
                error: function(data) {
                    let message = data.responseText;
                    swal("Failed", message, "error");
                }
            })

        }

        function confirmPayment(){
            PopUpHide();
            $.ajax({
                url:"/api/v1/confirmPayment",
                type:"POST",
                data: '{"code": "' + document.getElementById('code').value + '"}',
                contentType:"application/json;",
                success: function(){
                    swal("OK", "Payment accepted", "success");
                },
                error: function() {
                    swal("Bad request", "error");
                }
            })

        }

        function getCards(){
            $.ajax({
                url:"/api/v1/cards",
                success: function(data){
                    let trHTML = '<select id="card" style="width:20%">\n';
                    $.each(data, function (i, item) {
                        trHTML += '<option>' + item.cardNumber + '</option>';
                    });
                    trHTML += '</select>'

                    $('#card_select').html(trHTML);
                },
                error: function() {
                    swal("Sorry, something went wrong with cards information", "error");
                }
            })
        }

        $( window ).on("load", getCards())

        $(document).ready(function(){
            PopUpHide();
        });

        function PopUpShow(){
            $("#popup1").show();
        }

        function PopUpHide(){
            $("#popup1").hide();
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

        .b-popup{
            width:100%;
            min-height:100%;
            background-color: rgba(0,0,0,0.5);
            overflow:hidden;
            position:fixed;
            top:0px;
        }
        .b-popup .b-popup-content{
            text-align:center;
            margin:40px auto 0px auto;
            width:230px;
            height: 80px;
            padding:10px;
            background-color: #c5c5c5;
            border-radius:5px;
        }

        .input_code{
            text-align:center;
        }
    </style>

</head>
<body>
<jsp:include page="common.jsp" />
<div id="languages" style="float: right">
    <a href="/logout"><img src="image/exit.png" alt="Exit" style="width:40px;height:40px;margin-right:10px"></a>
</div>
<h1><spring:message code="payment_head"/></h1>
<div id="payment">
    <h2><spring:message code="payment_select_card"/></h2>
    <div id="card_select"></div><br/>
    <label for="account"><spring:message code="payment_account"/>: </label>
    <input type="text" id="account"/><br/>

    <label for="amount"><spring:message code="transfer_amount"/>: </label>
    <input type="text" id="amount"/><br/>
    <label for="description"><spring:message code="transfer_description"/>: </label>
    <input type="text" id="description"/><br/>
    <button onclick="goBack()"><spring:message code="btn_back"/></button>
    <input type="button" value=<spring:message code="btn_pay"/> onclick="doNewPayment()"/>
</div>


<div class="b-popup" id="popup1">
    <div class="b-popup-content">
        <spring:message code="secure_code_head"/>
        <input type="text" id="code" class="input_code" size="4"/><br/>
        <input type="button" value=<spring:message code="btn_confirm"/> onclick="confirmPayment()"/>
        <input type="button" value=<spring:message code="btn_close"/> onclick="PopUpHide()"/>
    </div>
</div>

</body>
</html>

