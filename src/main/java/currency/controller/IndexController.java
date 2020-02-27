package currency.controller;

import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import javax.xml.parsers.ParserConfigurationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.xml.sax.SAXException;
import currency.models.Currency;
import currency.models.DifferenceReturn;
import currency.services.CurrencyService;

@Controller
public class IndexController {

	@Autowired
	CurrencyService currency;

	@RequestMapping()
	public String indexList(Model model) throws ParserConfigurationException, SAXException, IOException {
		model.addAttribute("currencyCode", currency.getInfoFromXml("2020-01-03"));
		return "index";
	}

	@RequestMapping(value = "/skirtumas")

	public String getCurrencyResults(@RequestParam(value = "nuo", defaultValue = "erro") String nuo,
			@RequestParam(value = "iki", defaultValue = "error") String iki,
			@RequestParam(value = "valiuta", defaultValue = "error") String valiuta, Model model)
			throws ParserConfigurationException, SAXException, IOException, ParseException
	{
		List<Currency> currencyCodes = currency.getInfoFromXml("2020-02-03");
		model.addAttribute("currencyCode", currencyCodes);
		LocalDateTime dateNuo;
		LocalDateTime dateIki;
		List<String> errorMessages = new ArrayList<>();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		if (nuo.matches("([0-9]{4})-([0-9]{2})-([0-9]{2})") && iki.matches("([0-9]{4})-([0-9]{2})-([0-9]{2})")) {
			dateNuo = LocalDate.parse(nuo, formatter).atStartOfDay();
			dateIki = LocalDate.parse(iki, formatter).atStartOfDay();
			if (dateIki.isAfter(LocalDateTime.now())) {
				dateIki = LocalDateTime.now();
				errorMessages.add("Deja, ateities valiutos kursų pokyčių nenumatome. Data pakeista į šiandienos.");
				iki = dateIki.format(formatter);
			}
		} else {
			model.addAttribute("error", "Neteisingai įvestas datos formatas.");
			return "error";
		}
		if (dateNuo.isBefore(LocalDate.parse("2014-09-30", formatter).atStartOfDay())) { 
			dateNuo = LocalDate.parse("2014-09-30", formatter).atStartOfDay();
			errorMessages.add("Anksčiausia informacija LB duomenų bazėje apie valiutos pokyčius yra nuo 2014 m. rugsėjo 30-os dienos.");
			nuo = dateNuo.format(formatter);
		}
		if (dateNuo.compareTo(dateIki) < 1) {
			if (valiuta.equals("visos")) {
				DifferenceReturn returnValues = currency.getAllDifference(dateNuo, dateIki, errorMessages);
				model.addAttribute("errors", returnValues.getErrorMessages());
				model.addAttribute("finalList", returnValues.getFinalList());
				model.addAttribute("nuo", returnValues.getNuo());
				model.addAttribute("iki", returnValues.getIki());
				return "skirtumas";
			} else if (currencyCodes.stream().anyMatch(a -> a.getKodas().equals(valiuta))) {
				List<Currency> vienosValiutosListas = new ArrayList<>();
				vienosValiutosListas = currency.getCurrencChangeFromTo(nuo, iki, valiuta).stream()
						.sorted(Comparator.comparing(Currency::getData)).collect(Collectors.toList());
				model.addAttribute("valiuta", vienosValiutosListas);
				model.addAttribute("errors", errorMessages);
				
				if (vienosValiutosListas.size() > 1) {
				return "pokytis";
				}
				else {
					model.addAttribute("error", "Šiame periode informacijos apie valiutos pokytį nėra.");
					return "error";
				}
			} else {
				model.addAttribute("error", "Tokia valiuta nerasta.");
				return "error";

			}
		} 
		else {
			model.addAttribute("error", "Periodo pabaiga yra ankstesnė už pradžią.");
			return "error";

		}

	}

}
