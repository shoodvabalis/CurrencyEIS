<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List"%>





<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${valiuta.get(0).pavadinimas} kurso pokytis</title>
</head>

<body>
	<h1 style="text-align: center;">${valiuta.get(0).pavadinimas}
		kurso pokytis</h1>
	<c:forEach items="${errors}" var="klaida">
		<p
			style="text-align: center; color: #625a5a; background-color: #ededee; padding: 5px; margin: auto; width: 80%;">${klaida}</p>
	</c:forEach>
	<jsp:include page="choise.jsp" />
	<div style="width: 100%; height: 500px; margin: auto;" id="chart_div"></div>

	<table class="shortTable" id="shortTable">
		<tr class="shortTable">
			<th class="shortTable">Valiutos kursas ${valiuta.get(0).data}:</th>
			<th class="shortTable">Valiutos kursas ${valiuta.get(fn:length(valiuta) - 1).data}:
			</th>
			<th class="shortTable">Valiutos kurso pasikeitimas:</th>
			<th class="shortTable">Valiutos kurso pasikeitimas %</th>
		</tr>
		<tr class="shortTable">
			<td class="shortTable">${valiuta.get(0).santykis}</td>
			<td class="shortTable">${valiuta.get(fn:length(valiuta) - 1).santykis}</td>
			<td class="shortTable">${valiuta.get(0).santykis - valiuta.get(fn:length(valiuta) - 1).santykis }
			</td>
			<td class="shortTable" id="procentai"></td>
	</table>
	<table border="1">
		<thead>
			<tr>
				<th>Pavadinimas:</th>
				<th>Kodas:</th>
				<th>Data:</th>
				<th>Santykis ${ iki }:</th>

			</tr>
		<thead>
			<tbody>
			<c:forEach items="${valiuta}" var="list">
				<tr>
					<td>${list.pavadinimas}</td>
					<td>${list.kodas}</td>
					<td>${list.data}</td>
					<td>${list.santykis}</td>

				</tr>
			</c:forEach>
		</tbody>
		</table> 
	

</body>
<style>
.shortTable {
border: 0px;
margin-bottom: 30px;
}
table {
	border-collapse: collapse;
	width: 80%;
	margin: auto;
}

th, td {
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

@media only screen and (max-width: 760px) , ( min-device-width : 300px)
	and (max-device-width: 1024px) {
	table:not(.shortTable), thead:not(.shortTable) , tbody:not(.shortTable) , th:not(.shortTable) , td:not(.shortTable) , tr:not(.shortTable)  {
		display: block;
		width:100%;
	}

	/* Hide table headers (but not display: none;, for accessibility) */
	thead:not(.shortTable)  tr:not(.shortTable)  {
		position: absolute;
		top: -9999px;
		left: -9999px;
	}
	tr:not(.shortTable)  {
		border: 1px solid #ccc;
	}
	td:not(.shortTable)  {
		border: none;
		border-bottom: 1px solid #eee;
		position: relative;
		padding-left: 50%;
	}
	 td:not(.shortTable):before {
		position: absolute;
		/* Top/left values mimic padding */
		top: 6px;
		left: 6px;
		width: 45%;
		padding-right: 10px;
		white-space: nowrap;
	}
	td:not(.shortTable):nth-of-type(1):before  {
		content: "Pavadinimas";
	}
	td:not(.shortTable):nth-of-type(2):before  {
		content: "Kodas";
	}
	td:not(.shortTable):nth-of-type(3):before  {
		content: "Data";
	}
	td:not(.shortTable):nth-of-type(4):before  {
		content: "Santykis";
	}


}
</style>
  <script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);

document.getElementById("procentai").innerHTML = ${100*(valiuta.get(0).santykis - valiuta.get(fn:length(valiuta) - 1).santykis) / valiuta.get(fn:length(valiuta)-1).santykis} + "%"


function drawBasic() {

      var data = new google.visualization.DataTable();
      data.addColumn('string', 'X');
      data.addColumn('number', '${valiuta.get(1).pavadinimas}');
      data.addRows([
    	  <c:forEach items="${valiuta}" var="list">
    	['${list.data}',${list.santykis}], 
    	</c:forEach>

      ]);

      var options = {
        hAxis: {
          title: 'Laikas'
        },
        vAxis: {
          title: 'Kursas'
        },
        legend: {position: 'none'}

      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

      chart.draw(data, options);
    }

</script>
</html>