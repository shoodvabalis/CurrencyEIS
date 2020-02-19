package currency.models;

import java.util.ArrayList;
import java.util.List;

public class DifferenceReturn {
	private List<String> errorMessages = new ArrayList<>();
	private String nuo;
	private String iki;
	private List<CurrencyDifference> finalList = new ArrayList<CurrencyDifference>();
	public List<String> getErrorMessages() {
		return errorMessages;
	}
	public void setErrorMessages(List<String> errorMessages) {
		this.errorMessages = errorMessages;
	}
	public String getNuo() {
		return nuo;
	}
	public void setNuo(String nuo) {
		this.nuo = nuo;
	}
	public String getIki() {
		return iki;
	}
	public void setIki(String iki) {
		this.iki = iki;
	}
	public List<CurrencyDifference> getFinalList() {
		return finalList;
	}
	public void setFinalList(List<CurrencyDifference> finalList) {
		this.finalList = finalList;
	}
}
