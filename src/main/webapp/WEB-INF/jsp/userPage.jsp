<%--
  Created by IntelliJ IDEA.
  Servlets.User: Servlets.User
  Date: 15.11.2020
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Web-Bank</title>
</head>
<style>

    #sidebar {
        background-color: #dddddd;
    }

    table {
        font-family: arial, sans-serif;
        border-collapse: collapse;
        width: 100%;
    }

    td, th {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 8px;
    }

    tr:nth-child(even) {
        background-color: #dddddd;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<script>
    function magicButtonClick(baseCurrency){
        $.ajax({
            url:"/api/v1/currency?baseCurrency=" + baseCurrency,
            success: function(data){
                let trHTML = '<table id="currencies_table" style="width:50%">\n' +
                    '        <tr>\n' +
                    '            <th>Rated currency</th>\n' +
                    '            <th>Nominal</th>\n' +
                    '            <th>Buy</th>\n' +
                    '            <th>Sale</th>\n' +
                    '            <th>National Bank</th>\n' +
                    '        </tr>';
                $.each(data, function (i, item) {
                    trHTML += '<tr><td>' + item.ratedCurrency + '</td><td>' + item.baseCurrencyNominal + '</td><td>' + item.buyRate + '</td><td>' + item.saleRate + '</td><td>' + item.rate + '</td></tr>';
                });
                trHTML += '</table>'

                $('#currencies_table').html(trHTML);
            },
            error: function() {
                alert("Sorry, something went wrong with currencies api!");
            }
        })
    }

    function getCards(){
        $.ajax({
            url:"/api/v1/cards",
            success: function(data){
                let trHTML = '<table id="cards_table_result" style="width:50%">\n' +
                    '        <tr>\n' +
                    '            <th>Number</th>\n' +
                    '            <th>Rest</th>\n' +
                    '            <th>Currency</th>\n' +
                    '        </tr>';
                $.each(data, function (i, item) {
                    trHTML += '<tr><td>' + item.cardNumber + '</td><td>' + item.rest + '</td><td>' + item.currency + '</td></tr>';
                });
                trHTML += '</table>'

                $('#cards_table').html(trHTML);
            },
            error: function() {
                alert("Sorry, something went wrong with cards information");
            }
        })
    }
    $( window ).on("load", magicButtonClick(933))
    $( window ).on("load", getCards())
</script>
<body>
<div id="container">
    <div id="sidebar">
        <p><a href="/payments">Payments</a></p>
        <p><a href="/">History</a></p>
        <p><a href="/">Finance</a></p>
    </div>
    <div id="cards">
        <h1>Cards</h1>
        <input type="button" value="refresh" onclick="getCards()"/>
        <div id="cards_table"></div>
    </div>
    <div id="credits">
        <h1>Credits</h1>
        <h2>Not ready</h2>
    </div>
    <div id="userInfo">
        <h1>Welcome: <sec:authentication property="principal.username"/></h1>
        <h2><a href="/userInfo">Edit profile</a></h2>
    </div>
    <div id="currencies">
        <h1>Currencies</h1>
        <input type="button" value="refresh" onclick="magicButtonClick(933)"/>
        <div id="currencies_table"></div>
    </div>
</div>
</body>
</html>