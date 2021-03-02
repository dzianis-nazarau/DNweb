package by.tms.DNweb.controllers;

import by.tms.DNweb.entity.Card;
import by.tms.DNweb.entity.Currency;
import by.tms.DNweb.entity.Payment;
import by.tms.DNweb.entity.User;
import by.tms.DNweb.repository.CardRepository;
import by.tms.DNweb.repository.CurrencyRepository;
import by.tms.DNweb.repository.PaymentRepository;
import by.tms.DNweb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/v1")
public class APIController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CurrencyRepository currencyRepository;

    @Autowired
    private CardRepository cardRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping(value = "/registerUser")
    public ResponseEntity<User> registerUser(@Valid @RequestBody User user) {

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return ResponseEntity.ok(user);
    }

    @GetMapping(value = "/currency")
    public List<Currency> getCurrency(@RequestParam int baseCurrency) {
        List<Currency> currencies = currencyRepository.findCurrenciesByBaseCurrency(baseCurrency);
        return currencies;
    }

    @GetMapping(value = "/cards")
    public List<Card> getCardBalance(Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        List<Card> cards = user.getCards();
        return cards;
    }

    @PostMapping(value = "/newPayment")
    public ResponseEntity<String> doNewPayment(@RequestBody Payment payment) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Card card = cardRepository.findCardByCardNumber(payment.getSourceCardNumber());

        card.setRest(card.getRest() - payment.getAmount());
        payment.setDate(LocalDateTime.now());
        payment.setUser(user);

        paymentRepository.save(payment);
        cardRepository.save(card);
        return ResponseEntity.ok("Payment accepted");
    }
}

