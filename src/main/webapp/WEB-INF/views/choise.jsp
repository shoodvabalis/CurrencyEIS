<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>

<section>

				<fieldset style="width:80%; margin: auto;">

					<legend>Įveskite datą nuo kada iki kada skaičiuoti valiutos pokytį</legend>

	<div class="inputfield">
		<div class="popup">
			<input class="dateinput" type='date' id="nuo"
				onclick="slepkBalionaNuo();"> <span class="popuptext"
				id="nuoPopup" onclick="slepkBalionaNuo();">Įveskite datą</span>
		</div>
		<div class="popup">
			<input class="dateinput" type='date' id="iki"
				onclick="slepkBalionaIki();"> <span class="popuptext"
				id="ikiPopup" onclick="slepkBalionaIki();">Įveskite datą</span>
		</div>

		<div>
			<select class="dateinput selectpicker" id="valiuta">
				<option value='visos'>Visos valiutos</option>
				<c:forEach items="${currencyCode}" var="code">
					<option value='${code.kodas}'>
				
					${code.pavadinimas}</option>
				</c:forEach>

			</select>
		</div>
		<div>
			<button class="skaiciuok" id="skaiciuok"
				onclick="skaiciuokValiutas();">Skaičiuok!</button>
		</div>
	
	</div>
	</fieldset>
</section>

<script>
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();
	if (dd < 10) {
		dd = '0' + dd
	}
	if (mm < 10) {
		mm = '0' + mm
	}

	today = yyyy + '-' + mm + '-' + dd;
	document.getElementById("iki").setAttribute("max", today)
	document.getElementById("nuo").setAttribute("max", today)

	function skaiciuokValiutas() {
		if ((document.getElementById('nuo').value !== "")
				&& (document.getElementById('iki').value !== "")) {
			window.location = "../skirtumas?nuo="
					+ document.getElementById('nuo').value + "&iki="
					+ document.getElementById('iki').value + "&valiuta="
					+ document.getElementById('valiuta').value;

		}
		if (document.getElementById('nuo').value === "") {
			document.getElementById("nuoPopup").classList.toggle("show");

		}
		if (document.getElementById('iki').value === "") {
			document.getElementById("ikiPopup").classList.toggle("show");

		}

	}
	function slepkBalionaIki() {

		if (document.getElementById("ikiPopup").classList.contains("show")) {
			document.getElementById("ikiPopup").classList.toggle("show");
		}
	}
	function slepkBalionaNuo() {
		if (document.getElementById("nuoPopup").classList.contains("show")) {
			document.getElementById("nuoPopup").classList.toggle("show");
		}
	}
</script>
 <script src="bootstrap-select.js"></script> 
<style>
.inputfield {
margin-top: 15px;
margin-bottom: 20px;
display: flex;
flex-direction: column;
justify-content: space-around;
align-items: center;
line-height: 30px;
}
.dateinput {
	border: 1px solid #c4c4c4;
	border-radius: 5px;
	background-color: #fff;
	padding: 3px 5px;
	box-shadow: inset 0 3px 6px rgba(0, 0, 0, 0.1);
	width: 190px;

}

.skaiciuok {
	background-color: #8E8E8E;
	border: none;
	color: white;
	padding: 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 12px;
}

.skaiciuok:hover {
	background-color: #403E3E;
}

/* Popup container - can be anything you want */
.popup {
	position: relative;
	display: inline-block;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

/* The actual popup */
.popup .popuptext {
	visibility: hidden;
	width: 160px;
	background-color: #555;
	color: #fff;
	text-align: center;
	border-radius: 6px;
	padding: 8px 0;
	position: absolute;
	z-index: 1;
	bottom: 125%;
	left: 50%;
	margin-left: -80px;
}

/* Popup arrow */
.popup .popuptext::after {
	content: "";
	position: absolute;
	top: 100%;
	left: 50%;
	margin-left: -5px;
	border-width: 5px;
	border-style: solid;
	border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
	visibility: visible;
	-webkit-animation: fadeIn 1s;
	animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
from { opacity:0; }
to { opacity: 1; }
}
@keyframes fadeIn {
from { opacity:0; }
to { opacity: 1; }
}
@media 
only screen and (max-width: 760px),
(min-device-width: 300px) and (max-device-width: 1024px)  {
.dateinput {
	height: 40px;
	width: 300px;
	margin: 5px;
	font-size: 20px;
}
.skaiciuok {
margin-top: 30px;
    padding-left: 90px;
    padding-right: 90px;
    padding-top: 25px;
    padding-bottom: 25px;
    font-size: 30px;
}
 

}
</style>