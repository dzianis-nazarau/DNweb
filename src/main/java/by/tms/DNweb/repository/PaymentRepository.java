package by.tms.DNweb.repository;

import by.tms.DNweb.entity.Payment;
import by.tms.DNweb.entity.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PaymentRepository extends CrudRepository<Payment, Long> {

    List<Payment> findPaymentsByUserOrderByDateDesc(User user);

    List<Payment> findBySourceCardNumberOrderByDateDesc(String cardNumber);

    Payment findPaymentByCode(String code);

}
