<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Valiutos kurso skaičiuoklė. Klaida!</title>
</head>
<body>
<h1 style="text-align:center; color:red;">Klaida!</h1>
<p style="text-align:center; color:#625a5a; background-color:#ededee; padding: 5px; margin: auto; width: 80%;">${error}</p>
<p style="text-align:center;">Atsiprašome įvyko klaida. Bandykite skaičiuoti valiutos kurso pokytį dar kartą.</p>
<jsp:include page="choise.jsp" />
</body>
</html>