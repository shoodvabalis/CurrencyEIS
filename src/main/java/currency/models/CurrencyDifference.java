package currency.models;

import java.math.BigDecimal;

public class CurrencyDifference {
	private String pavadinimas;
	private String kodas;
	private BigDecimal  senasSantykis;
	private BigDecimal  naujasSantykis;
	private BigDecimal  skirtumas;
	
	public String getPavadinimas() {
		return pavadinimas;
	}
	public void setPavadinimas(String pavadinimas) {
		this.pavadinimas = pavadinimas;
	}
	public String getKodas() {
		return kodas;
	}
	public void setKodas(String kodas) {
		this.kodas = kodas;
	}
	public BigDecimal getSenasSantykis() {
		return senasSantykis;
	}
	public void setSenasSantykis(BigDecimal senasSantykis) {
		this.senasSantykis = senasSantykis;
	}
	public BigDecimal getNaujasSantykis() {
		return naujasSantykis;
	}
	public void setNaujasSantykis(BigDecimal naujasSantykis) {
		this.naujasSantykis = naujasSantykis;
	}
	public BigDecimal getSkirtumas() {
		return skirtumas;
	}
	public void setSkirtumas(BigDecimal skirtumas) {
		this.skirtumas = skirtumas;
	}


}
