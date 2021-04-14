<%--
  Created by IntelliJ IDEA.
  Servlets.User: Servlets.User
  Date: 15.11.2020
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Web-Bank</title>
</head>

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

    /* Style tab links */
    .tablink {
        background-color: #494f57;
        color: #fff;
        float: left;
        border: none;
        outline: none;
        cursor: pointer;
        padding: 14px 16px;
        font-size: 17px;
        width: 25%;
    }

    .tablink:hover {
        background-color: #777;
    }

    /* Style the tab content (and add height:100% for full page content) */
    .tabcontent {
        background: #fff;
        display: none;
        padding: 100px 20px;
        height: 100%;
    }

    #HomeLink {
        display: block;
    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    td, th {
        border: 1px solid #dddddd;
        text-align: center;
        padding: 8px;
    }

    .left_block {

        width: 70%;
        float: left;
    }
    .right_block {

        width: 30%;
        float: right;
    }

    .low_block {
        position: absolute;
        top: 430px;
        width: 70%;
    }

    #cards_table {
        width: 80%;
    }

    #credits_table {
        width: 80%;
    }

    .button {
        background-color: #ddd;
        border: none;
        color: black;
        padding: 5px 10px;
        text-align: center;
        display: inline-block;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 10px;
    }

    #vertical_Menu, #v_Menu {
        width: 200px;
    }

    #vertical_Menu a, #v_Menu a {
        background-color: #eee;
        color: black;
        display: block;
        padding: 12px;
        text-decoration: none;
    }

    #vertical_Menu a:hover, #v_Menu a:hover {
        background-color: #ccc;
    }

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

    function magicButtonClick(baseCurrency){
        $.ajax({
            url:"/api/v1/currency?baseCurrency=" + baseCurrency,
            success: function(data){
                let trHTML = '<table id="currencies_table" style="width:50%">\n' +
                    '        <tr>\n' +
                    '            <th><spring:message code="up_tb_cur_ratedCurrency"/></th>\n' +
                    '            <th><spring:message code="up_tb_cur_nominal"/></th>\n' +
                    '            <th><spring:message code="up_tb_cur_buy"/></th>\n' +
                    '            <th><spring:message code="up_tb_cur_sale"/></th>\n' +
                    '            <th><spring:message code="up_tb_cur_nationalBank"/></th>\n' +
                    '        </tr>';
                $.each(data, function (i, item) {
                    trHTML += '<tr><td>' + item.ratedCurrency + '</td><td>' + item.baseCurrencyNominal + '</td><td>' + item.buyRate + '</td><td>' + item.saleRate + '</td><td>' + item.rate + '</td></tr>';
                });
                trHTML += '</table>'

                $('#currencies_table').html(trHTML);
            },
            error: function() {
                swal("Failed", "Sorry, something went wrong with currencies api!", "error");
            }
        })
    }

    function updateUser(){
        $.ajax({
            url:"/api/v1/updateUserInfo",
            type:"POST",
            data: '{"username": "' + document.getElementById('username').value + '",' +
                '"country": "' + document.getElementById("country").value + '",' +
                '"gender": "' + document.getElementById("gender").value + '",' +
                '"userage": "' + document.getElementById("age").value + '",' +
                '"email": "' + document.getElementById("email").value + '"}',
            contentType:"application/json;",
            success: function(){
                swal("OK", "Updated", "success");
            },
            error: function(data) {
                let message = data.responseText;
                swal("Failed", message, "error");
            }
        })

    }

    function updatePassword(){
        $.ajax({
            url:"/api/v1/updatePassword",
            type:"POST",
            data: '{"oldPassword": "' + document.getElementById('oldPassword').value + '",' +
                '"newPassword": "' + document.getElementById("newPassword").value + '"}',
            contentType:"application/json;",
            success: function(){
                swal("OK", "Updated", "success");
            },
            error: function(data) {
                let message = data.responseText;
                swal("Failed", message, "error");
            }
        })

    }

    function getCards(tagId){
        $.ajax({
            url:"/api/v1/cards",
            success: function(data){
                let trHTML = '<table id="cards_table_result" width="50%">\n' +
                    '        <tr>\n' +
                    '            <th><spring:message code="up_tb_cards_card"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_cardNumber"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_rest"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_currency"/></th>\n' +
                    '        </tr>';
                $.each(data, function (i, item) {
                    trHTML += '<tr><td><img src="image/bitcoin.png" width="70"></td><td>' + item.cardNumber + '</td><td>' + item.rest + '</td><td>' + item.currency + '</td></tr>';
                });
                trHTML += '</table>'

                $(tagId).html(trHTML);
            },
            error: function() {
                alert("Sorry, something went wrong with cards information");
            }
        })
    }

    function getCardsSelect(tagId){
        $.ajax({
            url:"/api/v1/cards",
            success: function(data){
                let trHTML = '<select id=' + tagId + '_table style="width:20%">\n';
                $.each(data, function (i, item) {
                    trHTML += '<option>' + item.cardNumber + '</option>';
                });
                trHTML += '<option>all cards</option></select>'

                $(tagId).html(trHTML);
            },
            error: function() {
                alert("Sorry, something went wrong with cards information");
            }
        })
    }

    function getPayments(cardNumber){
        $.ajax({
            url:"/api/v1/paymentsHistory?card=" + cardNumber,
            success: function(data){
                let trHTML = '<table id="payments_table_result" width="50%">\n' +
                    '        <tr>\n' +
                    '            <th><spring:message code="up_tb_payments_card"/></th>\n' +
                    '            <th><spring:message code="up_tb_payments_payee"/></th>\n' +
                    '            <th><spring:message code="up_tb_payments_amount"/></th>\n' +
                    '            <th><spring:message code="up_tb_payments_date"/></th>\n' +
                    '            <th><spring:message code="up_tb_payments_desc"/></th>\n' +
                    '            <th><spring:message code="up_tb_payments_type"/></th>\n' +
                    '        </tr>';
                $.each(data, function (i, item) {
                    trHTML += '<tbody style="width:500px;overflow-y:scroll"><tr><td>' + item.sourceCardNumber + '</td>' +
                        '<td>' + item.payee + '</td>' +
                        '<td>' + item.amount + '</td>' +
                        '<td>' + item.date + '</td>' +
                        '<td>' + item.description + '</td>' +
                        '<td>' + item.type + '</td></tr></tbody>';
                });
                trHTML += '</table>'

                $('#payments_table').html(trHTML);
            },
            error: function() {
                alert("Sorry, something went wrong with cards information");
            }
        })
    }

    function getCredits(){
        $.ajax({
            url:"/api/v1/credits",
            success: function(data){
                let trHTML = '<table id="credits_table_result" width="50%">\n' +
                    '        <tr>\n' +
                    '            <th><spring:message code="up_tb_credits_credit"/></th>\n' +
                    '            <th><spring:message code="up_tb_credits_contractNumber"/></th>\n' +
                    '            <th><spring:message code="up_tb_credits_limit"/></th>\n' +
                    '            <th><spring:message code="up_tb_credits_currency"/></th>\n' +
                    '        </tr>';
                $.each(data, function (i, item) {
                    trHTML += '<tr><td><img src="image/credit.png" width="70"></td><td>' + item.creditNumber + '</td><td>' + item.creditLimit + '</td><td>' + item.currency + '</td></tr>';
                });
                trHTML += '</table>'

                $('#credits_table').html(trHTML);
            },
            error: function() {
                alert("Sorry, something went wrong with cards information");
            }
        })
    }

    function deleteCard(cardNumber){
        $.ajax({
            url:"/api/v1/deleteCard?cardNumber=" + cardNumber,
            success: function(){
                swal("OK", "Card deleted", "success");
            },
            error: function() {
                swal("Bad request", "error");
            }
        })
    }

    function cardInfo(cardNumber){
        $.ajax({
            url:"/api/v1/cardInfo?cardNumber=" + cardNumber,
            success: function(data){
                let trHTML = '<table id="card_info_result" width="50%">\n' +
                    '        <tr>\n' +
                    '            <th><spring:message code="up_tb_cards_cardNumber"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_currency"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_rest"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_status"/></th>\n' +
                    '            <th><spring:message code="up_tb_cards_type"/></th>\n' +
                    '        </tr>';
                trHTML += '<tr><td>' + data.cardNumber + '</td><td>' + data.currency + '</td><td>' + data.rest + '</td>' +
                    '<td>' + data.status + '</td><td>' + data.type + '</td></tr></table>'

                $('#card_info').html(trHTML);
            },
            error: function() {
                swal("Bad request", "error");
            }
        })
    }

    function openPage(pageName, elmnt) {
        let i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablink");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].style.backgroundColor = "";
        }
        document.getElementById(pageName).style.display = "block";
        elmnt.style.backgroundColor = "#777";
    }

    $( window ).on("load", magicButtonClick("BYN"));
    $( window ).on("load", getCards("#cards_table"));
    $( window ).on("load", getCards("#CardsLink_cards_table"));
    $( window ).on("load", getCardsSelect("#card_select"));
    $( window ).on("load", getCardsSelect("#card_select2"));
    $( window ).on("load", getCredits());

</script>

<body>

<button class="tablink" onclick="openPage('HomeLink', this)" id="defaultOpen"><spring:message code="up_upbar_home"/></button>
<button class="tablink" onclick="openPage('PaymentsLink', this)"><spring:message code="up_upbar_payments"/></button>
<button class="tablink" onclick="openPage('CardsLink', this)"><spring:message code="up_upbar_cards"/></button>
<button class="tablink" onclick="openPage('UserLink', this)"><spring:message code="up_upbar_user"/></button>

<jsp:include page="common.jsp" />
<div id="languages" style="float: right">
    <a href="/logout"><img src="image/exit.png" alt="Exit" style="width:40px;height:40px;margin-right:10px"></a>
</div>
<div id="HomeLink" class="tabcontent">
        <div id="cards" class="left_block">
            <h1><spring:message code="up_upbar_cards"/> <a href="/createCard"><img src="image/add.png" alt="+" style="width:25px;height:25px;"></a></h1></br>
            <div id="cards_table"></div>
            <input type="button" class="button" value=<spring:message code="up_btn_refresh"/> onclick="getCards()"/>
            <br/>
            <h1><spring:message code="up_credits"/> <a href=""><img src="image/add.png" alt="+" style="width:25px;height:25px;"></a></h1></br>
            <div id="credits_table"></div>
            <input type="button" class="button" value=<spring:message code="up_btn_refresh"/> onclick="getCredits()"/>
        </div>
        <div id="currencies" class="right_block">
            <h1><spring:message code="up_currencies"/></h1></br>
            <div id="currencies_table"></div>
            <input type="button" class="button" value=<spring:message code="up_btn_refresh"/> onclick="magicButtonClick(933)"/>
        </div>
<%--        <div id="credits" class="low_block">--%>
<%--        </div>--%>
</div>

<div id="PaymentsLink" class="tabcontent">
    <div class="left_block">
        <h1><spring:message code="up_payments_history"/></h1></br>
        <h2><spring:message code="up_payments_select_card"/></h2>
        <div id="card_select"></div>
        <input type="button" class="button" value=<spring:message code="up_btn_show"/> onclick="getPayments(document.getElementById('#card_select_table').value)"/>
        <div id="payments">
            <div id="payments_table"></div>
        </div>
    </div>
    <div class="right_block" id="vertical_Menu">
        <h1 style="text-align: center"><spring:message code="up_payment_operations"/></h1>
        <a href="/payments"><spring:message code="up_payment_new"/></a>
        <a href="/transfer"><spring:message code="up_payment_transfer"/></a>
    </div>


</div>

<div id="CardsLink" class="tabcontent">

    <div class="left_block">
        <h1><spring:message code="up_cards_management"/></h1></br>
        <h2><spring:message code="up_payments_select_card"/></h2>
        <div>
            <div id="card_select2"></div>
            <div id="card_info"></div>
        </div>

        <input type="button" class="button" value=<spring:message code="btn_info"/> onclick="cardInfo(document.getElementById('#card_select2_table').value)"/>
        <input type="button" class="button" value=<spring:message code="btn_block"/> onclick="deleteCard(document.getElementById('#card_select2_table').value)"/>
        <input type="button" class="button" value=<spring:message code="btn_delete"/> onclick="deleteCard(document.getElementById('#card_select2_table').value)"/>
    </div>
    <div class="right_block" id="v_Menu">
        <h1 style="text-align: center"><spring:message code="up_payment_operations"/></h1>
        <a href="/payments"><spring:message code="up_cards_new"/></a>
    </div>

</div>

<div id="UserLink" class="tabcontent">
    <h1><spring:message code="up_user_head"/></h1><br/><br/>
        <div>
            <div>
                <h2><spring:message code="up_user_info"/></h2><br/>
                <label for="username"><i class="fa fa-user"></i> <spring:message code="up_user_username"/>:</label>
                <input type="text" id="username" name="username" value=${user.username}>
                <label for="email"><i class="fa fa-email"></i> <spring:message code="up_user_email"/>:</label>
                <input type="text" id="email" name="email" value=${user.email}>
                <label for="country"><i class="fa fa-country"></i> <spring:message code="up_user_country"/>:</label>
                <input type="text" id="country" name="country" value=${user.country}>
                <label for="gender"><i class="fa fa-gender"></i> <spring:message code="up_user_gender"/>:</label>
                <input type="text" id="gender" name="gender" value=${user.gender}>
                <label for="age"><i class="fa fa-age"></i> <spring:message code="up_user_age"/>:</label>
                <input type="text" id="age" name="age" value=${user.userage}>
            </div>
        </div>
        <input type="button" value=<spring:message code="up_btn_update"/> onclick="updateUser()" class="btn">
    <div><br/>
        <div>
            <h3><spring:message code="up_user_changePass"/></h3>
            <label for="oldPassword"><i class="fa fa-user"></i> <spring:message code="up_user_oldPass"/>:</label>
            <input type="password" id="oldPassword" name="oldPassword">
            <label for="newPassword"><i class="fa fa-email"></i> <spring:message code="up_user_newPass"/>:</label>
            <input type="password" id="newPassword" name="newPassword" >
        </div>

    </div>
    <input type="button" value=<spring:message code="up_btn_changePassword"/> onclick="updatePassword()" class="btn">
</div>

</body>
</html>