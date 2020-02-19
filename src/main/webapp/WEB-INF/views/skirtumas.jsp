<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.List"%>





<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Valiutu kurso skirtumai</title>
</head>

<body>
<h1 style="text-align:center;">Visų valiutų pokytis</h1>
<c:forEach items="${errors}" var="klaida">
<p style="text-align:center; color:#625a5a; background-color:#ededee; padding: 5px; margin: auto; width: 80%;">${klaida}</p>
</c:forEach>
<jsp:include page="choise.jsp" />
    <table border="1">
    	<thead>
        <tr>
            <th>Pavadinimas</th>
            <th>Kodas</th>
            <th>Santykis ${ nuo }</th>
             <th>Santykis ${ iki }</th>
               <th>Skirtumas</th>
                  <th>Pokytis %</th>
 </tr>
 	</thead>
 		<tbody>
<c:forEach items="${finalList}" var="list">
    <tr>      
        <td>${list.pavadinimas}</td>
        <td>${list.kodas}</td>
        <td>${list.senasSantykis}</td>
        <td>${list.naujasSantykis}</td>
        <td style="<c:if test="${list.skirtumas< 0}"> color:red; </c:if><c:if test="${list.skirtumas > 0}"> color:green; </c:if>">${list.skirtumas}</td> 
         <td>${100*(list.senasSantykis - list.naujasSantykis) / list.naujasSantykis}%</td>  
    </tr>
</c:forEach>
</tbody>
    </table> 
</body>
<style>

table {
  border-collapse: collapse;
  width: 80%;
  margin: auto;
}
th, td {
  text-align: left;
  padding: 8px;
}
tr:nth-child(even) {background-color: #f2f2f2;}

@media 
only screen and (max-width: 760px),
(min-device-width: 300px) and (max-device-width: 1024px)  {


	table, thead, tbody, th, td, tr { 
		display: block; 
		width:100%;
	}
	
	/* Hide table headers (but not display: none;, for accessibility) */
	thead tr { 
		position: absolute;
		top: -9999px;
		left: -9999px;
	}
	
	tr { border: 1px solid #ccc; }
	
	td { 
		border: none;
		border-bottom: 1px solid #eee; 
		position: relative;
		padding-left: 50%; 
	}
	
	td:before { 
		position: absolute;
		/* Top/left values mimic padding */
		top: 6px;
		left: 6px;
		width: 45%; 
		padding-right: 10px; 
		white-space: nowrap;
	}
	td:nth-of-type(1):before { content: "Pavadinimas"; }
	td:nth-of-type(2):before { content: "Kodas"; }
	td:nth-of-type(3):before { content: "Santykis ${nuo}"; }
	td:nth-of-type(4):before { content: "Santykis ${iki}"; }
	td:nth-of-type(5):before { content: "Skirtumas"; }
	td:nth-of-type(6):before { content: "Pokytis %"; }

	}
</style>
</html>