package by.tms.DNweb.repository;

import by.tms.DNweb.entity.Card;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CardRepository extends CrudRepository<Card,Long> {

    List<Card> findCardsByUserId(int userId);

    Card findCardByCardNumber(String cardNumber);

}
