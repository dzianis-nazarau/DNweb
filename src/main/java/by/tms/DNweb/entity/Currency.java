package by.tms.DNweb.entity;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "currency")
public class Currency {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int baseCurrency;
    private int baseCurrencyNominal;
    private int ratedCurrency;
    private BigDecimal rate;
    private BigDecimal buyRate;
    private BigDecimal saleRate;

    public Currency(int baseCurrency, int baseCurrencyNominal, int ratedCurrency, BigDecimal rate, BigDecimal buyRate, BigDecimal saleRate) {
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

    public int getBaseCurrency() {
        return baseCurrency;
    }

    public void setBaseCurrency(int baseCurrency) {
        this.baseCurrency = baseCurrency;
    }

    public int getBaseCurrencyNominal() {
        return baseCurrencyNominal;
    }

    public void setBaseCurrencyNominal(int baseCurrencyNominal) {
        this.baseCurrencyNominal = baseCurrencyNominal;
    }

    public int getRatedCurrency() {
        return ratedCurrency;
    }

    public void setRatedCurrency(int ratedCurrency) {
        this.ratedCurrency = ratedCurrency;
    }

    public BigDecimal getRate() {
        return rate;
    }

    public void setRate(BigDecimal rate) {
        this.rate = rate;
    }

    public BigDecimal getBuyRate() {
        return buyRate;
    }

    public void setBuyRate(BigDecimal buyRate) {
        this.buyRate = buyRate;
    }

    public BigDecimal getSaleRate() {
        return saleRate;
    }

    public void setSaleRate(BigDecimal saleRate) {
        this.saleRate = saleRate;
    }
}
