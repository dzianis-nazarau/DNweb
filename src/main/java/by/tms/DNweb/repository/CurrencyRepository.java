package by.tms.DNweb.repository;

import by.tms.DNweb.entity.Currency;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CurrencyRepository extends CrudRepository<Currency, Integer> {

    List<Currency> findCurrenciesByBaseCurrency(int baseCurrency);

    List<Currency> findAllByBaseCurrency(int baseCurrency);

}
