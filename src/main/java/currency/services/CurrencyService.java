package currency.services;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import currency.models.Currency;
import currency.models.CurrencyDifference;
import currency.models.DifferenceReturn;

@Service
public class CurrencyService {

	public List<Currency> getInfoFromXml(String date) throws ParserConfigurationException, SAXException, IOException {

		URL url = new URL("https://www.lb.lt/lt/currency/daylyexport/?xml=1&class=Eu&type=day&date_day=" + date);
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(url.openStream());
		doc.getDocumentElement().normalize();
		NodeList nList = doc.getElementsByTagName("item");
		List<Currency> listas = new ArrayList<Currency>();
		for (int temp = 1; temp < nList.getLength(); temp++) {
			Currency currency = new Currency();
			Node nNode = nList.item(temp);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				currency.setData(eElement.getElementsByTagName("data").item(0).getTextContent());
				currency.setPavadinimas(eElement.getElementsByTagName("pavadinimas").item(0).getTextContent());
				currency.setKodas(eElement.getElementsByTagName("valiutos_kodas").item(0).getTextContent());
				currency.setSantykis(BigDecimal.valueOf(Double.valueOf(
						eElement.getElementsByTagName("santykis").item(0).getTextContent().replace(",", "."))));
				listas.add(currency);

			}

		}

		return listas;
	}

	public List<Currency> getCurrencChangeFromTo(String dateFrom, String dateTo, String name)
			throws ParserConfigurationException, SAXException, IOException {
		URL url = new URL("https://www.lb.lt/lt/currency/exportlist/?xml=1&currency=" + name
				+ "&ff=1&class=Eu&type=day&date_from_day=" + dateFrom + "&date_to_day=" + dateTo);
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(url.openStream());
		doc.getDocumentElement().normalize();
		NodeList nList = doc.getElementsByTagName("item");
		List<Currency> listas = new ArrayList<Currency>();
		for (int temp = 1; temp < nList.getLength(); temp++) {
			Currency currency = new Currency();
			Node nNode = nList.item(temp);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				currency.setData(eElement.getElementsByTagName("data").item(0).getTextContent());
				currency.setPavadinimas(eElement.getElementsByTagName("pavadinimas").item(0).getTextContent());
				currency.setKodas(eElement.getElementsByTagName("valiutos_kodas").item(0).getTextContent());
				currency.setSantykis(BigDecimal.valueOf(Double.valueOf(
						eElement.getElementsByTagName("santykis").item(0).getTextContent().replace(",", "."))));
				listas.add(currency);
			}

		}

		return listas;
	}
	
	
	public DifferenceReturn getAllDifference(LocalDateTime dateNuo, LocalDateTime dateIki,List<String> errorMessages) throws ParserConfigurationException, SAXException, IOException {
		DifferenceReturn returnItem = new DifferenceReturn();
		List<Currency> pirmasListas;
		List<Currency> antrasListas;
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		returnItem.setNuo(dateNuo.format(formatter));
		returnItem.setIki(dateIki.format(formatter));
		returnItem.setErrorMessages(errorMessages);
		pirmasListas = getInfoFromXml(dateNuo.format(formatter));
		for (int x = 1; pirmasListas.size() < 1; x++) {
			if(!returnItem.getErrorMessages().contains("Jūsų pasirinktą datą duomenų apie valiutos pokyčius nebuvo. "
					+ "Pateikiama informacija iš artimiausios anksčiau buvusios "
					+ "datos su informacija apie valiutos kursus.")) {
				returnItem.getErrorMessages().add("Jūsų pasirinktą datą duomenų apie valiutos pokyčius nebuvo. "
						+ "Pateikiama informacija iš artimiausios anksčiau buvusios "
						+ "datos su informacija apie valiutos kursus.");
			}
		
			pirmasListas = getInfoFromXml(dateNuo.minusDays(x).format(formatter));
			returnItem.setNuo(dateNuo.minusDays(x).format(formatter)); 
			try {
				Thread.sleep(150);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		antrasListas = getInfoFromXml(dateIki.format(formatter));
		for (int x = 1; antrasListas.size() < 1; x++) {
			if(!returnItem.getErrorMessages().contains("Jūsų pasirinktą datą duomenų apie valiutos pokyčius nebuvo. "
					+ "Pateikiama informacija iš artimiausios anksčiau buvusios "
					+ "datos su informacija apie valiutos kursus.")) {
				returnItem.getErrorMessages().add("Jūsų pasirinktą datą duomenų apie valiutos pokyčius nebuvo. "
						+ "Pateikiama informacija iš artimiausios anksčiau buvusios "
						+ "datos su informacija apie valiutos kursus.");
			}
			antrasListas = getInfoFromXml(dateIki.minusDays(x).format(formatter));
			returnItem.setIki(dateIki.minusDays(x).format(formatter));
			try {
				Thread.sleep(150);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		for (int x = 0; x < pirmasListas.size(); x++) {
			CurrencyDifference difference = new CurrencyDifference();
			String currencyCode = pirmasListas.get(x).getKodas();
			if (antrasListas.stream().anyMatch(a -> a.getKodas().equals(currencyCode))) {
				difference.setKodas(pirmasListas.get(x).getKodas());
				difference.setPavadinimas(pirmasListas.get(x).getPavadinimas());
				difference.setSenasSantykis(pirmasListas.get(x).getSantykis());
				difference.setNaujasSantykis(antrasListas.stream()
						.filter(a -> a.getKodas().equals(currencyCode)).findFirst().get().getSantykis());
				difference.setSkirtumas(pirmasListas.get(x).getSantykis().subtract(antrasListas.stream()
						.filter(a -> a.getKodas().equals(currencyCode)).findFirst().get().getSantykis()));
				returnItem.getFinalList().add(difference);
			}
		}
		return returnItem;
	}

}
