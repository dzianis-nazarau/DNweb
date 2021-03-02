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
    <title>Web-Bank</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
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
                success: function(data){
                    alert(data);
                },
                error: function(data) {
                    alert("Sorry, something went wrong with your payment");
                }
            })

        }

        function getCards(){
            $.ajax({
                url:"/api/v1/cards",
                success: function(data){
                    let trHTML = '<select id="card" style="width:10%">\n';
                    $.each(data, function (i, item) {
                        trHTML += '<option>' + item.cardNumber + '</option>';
                    });
                    trHTML += '</select>'

                    $('#card_select').html(trHTML);
                },
                error: function() {
                    alert("Sorry, something went wrong with cards information");
                }
            })
        }

        $( window ).on("load", getCards())
    </script>

</head>
<body>

<h1>Please, fill in payment details</h1>


<div id="payment">
    <h2>Select card</h2>
    <div id="card_select"></div><br/>
        <label for="account">account: </label>
        <input type="text" id="account"/><br/>

        <label for="amount">amount: </label>
        <input type="text" id="amount"/><br/>
        <label for="description">description: </label>
        <input type="text" id="description"/><br/>
    <input type="button" value="Pay" onclick="doNewPayment()"/>
</div>
</body>
</html>
