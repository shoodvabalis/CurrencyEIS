package currency.models;

import java.math.BigDecimal;

public class Currency {
private String pavadinimas;
private String kodas;
private BigDecimal  santykis;
private String data;
public String getData() {
	return data;
}
public void setData(String data) {
	this.data = data;
}
public String getPavadinimas() {
	return pavadinimas;
}
public BigDecimal getSantykis() {
	return santykis;
}
public void setSantykis(BigDecimal santykis) {
	this.santykis = santykis;
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

}
