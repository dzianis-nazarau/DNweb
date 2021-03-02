package by.tms.DNweb.repository;

import by.tms.DNweb.entity.Payment;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PaymentRepository extends CrudRepository<Payment, Long> {

    List<Payment> findPaymentsBySourceCardNumber(String cardNumber);

}
