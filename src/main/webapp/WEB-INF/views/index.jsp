<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Valiutos kurso skaičiuoklė</title>
</head>
<body>
	<h1 style="text-align: center;">Valiutos pokyčio skaičiuoklė</h1>

	<ul style="margin: auto; margin-bottom: 20px; width: 80%;">
		<li>Pasirinkite datą nuo kada iki kada norite skaičiuoti valiutos
			pokytį.</li>
		<li>Pasirinkite kokią valiutą skaičiuoti.
	
		<ul>
			<li>Jei pasirinksite "Visos valiutos", programa parodys
				pasirinktų datų visų valiutų santykius ir pasikeitimą per tą
				laikotarpį.</li>
			<li>Jei pasirinksite konkrečią valiutą, programa parodys
				valiutos kurso pasikeitimą per pasirinktą laikotarpį bei visų
				dienų tame laiko intervale valiutos kursą.</li>
		</ul>
		</li>
		<li>Spauskite "Skaičiuok!".</li>
		<li>Smagaus naudojimo. :)</li>
	</ul>


	<jsp:include page="choise.jsp" />

</body>
</html>