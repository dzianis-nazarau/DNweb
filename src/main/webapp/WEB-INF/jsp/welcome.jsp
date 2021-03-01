<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<head>
    <style>
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
    <title>Sugar Dog</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script>
        function magicButtonClick(baseCurrency){
            $.ajax({
                url:"/api/v1/currency?baseCurrency=" + baseCurrency,
                success: function(data){
                    let trHTML = '<table id="currencies_table" style="width:100%">\n' +
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

                    $('#table').html(trHTML);
                },
                error: function() {
                    alert("Sorry, something went wrong with currencies api!");
                }
            })
        }

        $( window ).on("load", magicButtonClick(933))
    </script>
</head>
<body>
<h1><spring:message code="welcome.text"/></h1>

<p><a href="?lang=ru"><spring:message code="language.ru.text"/></a></p>
<p><a href="?lang=en"><spring:message code="language.en.text"/></a></p>

<div id="currencies">
    <select id="selected_currency">
        <option selected="selected">933</option>
        <option>840</option>
        <option>978</option>
    </select>
    <input type="button" value="show currencies" onclick="magicButtonClick(document.getElementById('selected_currency').value)"/>
    <div id="table"></div>
</div>

</body>
