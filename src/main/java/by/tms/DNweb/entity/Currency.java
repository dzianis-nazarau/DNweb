package by.tms.DNweb.entity;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "currency")
public class Currency {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String baseCurrency;
    private int baseCurrencyNominal;
    private String ratedCurrency;
    private double rate;
    private double buyRate;
    private double saleRate;

    public Currency(String baseCurrency, int baseCurrencyNominal, String ratedCurrency, double rate, double buyRate, double saleRate) {
        this.baseCurrency = baseCurrency;
        this.baseCurrencyNominal = baseCurrencyNominal;
        this.ratedCurrency = ratedCurrency;
        this.rate = rate;
        this.buyRate = buyRate;
        this.saleRate = saleRate;
    }

    public Currency() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBaseCurrency() {
        return baseCurrency;
    }

    public void setBaseCurrency(String baseCurrency) {
        this.baseCurrency = baseCurrency;
    }

    public int getBaseCurrencyNominal() {
        return baseCurrencyNominal;
    }

    public void setBaseCurrencyNominal(int baseCurrencyNominal) {
        this.baseCurrencyNominal = baseCurrencyNominal;
    }

    public String getRatedCurrency() {
        return ratedCurrency;
    }

    public void setRatedCurrency(String ratedCurrency) {
        this.ratedCurrency = ratedCurrency;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public double getBuyRate() {
        return buyRate;
    }

    public void setBuyRate(double buyRate) {
        this.buyRate = buyRate;
    }

    public double getSaleRate() {
        return saleRate;
    }

    public void setSaleRate(double saleRate) {
        this.saleRate = saleRate;
    }
}
