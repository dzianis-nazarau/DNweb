package by.tms.DNweb.repository;

import by.tms.DNweb.entity.Currency;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CurrencyRepository extends CrudRepository<Currency, Integer> {

    List<Currency> findCurrenciesByBaseCurrency(String baseCurrency);

    List<Currency> findAllByBaseCurrency(String baseCurrency);

    Currency findCurrencyByBaseCurrencyAndAndRatedCurrency(String base, String rated);

}
