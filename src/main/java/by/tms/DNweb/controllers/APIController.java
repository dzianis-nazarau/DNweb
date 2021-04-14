package by.tms.DNweb.controllers;

import by.tms.DNweb.bot.TelegramBot;
import by.tms.DNweb.entity.*;
import by.tms.DNweb.repository.CardRepository;
import by.tms.DNweb.repository.CurrencyRepository;
import by.tms.DNweb.repository.PaymentRepository;
import by.tms.DNweb.repository.UserRepository;
import by.tms.DNweb.services.PaymentServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    @Autowired
    private PaymentServices paymentServices;

    @Autowired
    private TelegramBot telegramBot;

    @PostMapping(value = "/registerUser")
    public ResponseEntity<User> registerUser(@Valid @RequestBody User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return ResponseEntity.ok(user);
    }

    @PostMapping(value = "/updateUserInfo")
    public ResponseEntity<String> updateUserInfo(@Valid @RequestBody User renewableUser, BindingResult bindingResult, Principal principal) {
        if(bindingResult.hasErrors()) {
            String result = bindingResult.getAllErrors().stream().map(e -> e.getDefaultMessage()).collect(Collectors.joining("\n"));
            return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
        } else {
            User user = userRepository.findByUsername(principal.getName());
            user.setUsername(renewableUser.getUsername());
            user.setEmail(renewableUser.getEmail());
            user.setCountry(renewableUser.getCountry());
            user.setGender(renewableUser.getGender());
            user.setUserage(renewableUser.getUserage());
            userRepository.save(user);

            if(!renewableUser.getUsername().equals(user.getUsername())) {
                Collection<SimpleGrantedAuthority> nowAuthorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
                        .getContext().getAuthentication().getAuthorities();
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(renewableUser.getUsername(), user.getPassword(), nowAuthorities);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }

            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @PostMapping(value = "/updatePassword")
    public ResponseEntity<String> updatePassword(@RequestBody Map<String, String> payload, Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        String oldPassword = payload.get("oldPassword");
        String newPassword = payload.get("newPassword");
        if(passwordEncoder.matches(oldPassword, user.getPassword())) {
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            return new ResponseEntity<>(null, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Incorrect password", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/currency")
    public List<Currency> getCurrency(@RequestParam String baseCurrency) {
        List<Currency> currencies = currencyRepository.findCurrenciesByBaseCurrency(baseCurrency);
        return currencies;
    }

    @GetMapping(value = "/cards")
    public List<Card> getCardBalance(Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        List<Card> cards = user.getCards();
        return cards;
    }

    @GetMapping(value = "/credits")
    public List<Credit> getCreditInformation(Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        List<Credit> credits = user.getCredits();
        return credits;
    }

    @PostMapping(value = "/newPayment")
    public ResponseEntity<String> doNewPayment(@RequestBody Payment payment) {
        Card card = cardRepository.findCardByCardNumber(payment.getSourceCardNumber());
        if (payment.getAmount() > card.getRest()) {
            return new ResponseEntity<>("Insufficient funds", HttpStatus.BAD_REQUEST);
        } else {
            String code = paymentServices.generateConfirmKey();
            User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
            payment.setUser(user);
            payment.setCode(code);
            payment.setStatus("processing");
            telegramBot.sendMessage("Code: " + code);
            paymentRepository.save(payment);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @PostMapping(value = "/confirmPayment")
    public void confirmPayment(@RequestBody Map<String, String> body) {
        String code = body.get("code");
        try {
            Payment payment = paymentRepository.findPaymentByCode(code);
            Card card = cardRepository.findCardByCardNumber(payment.getSourceCardNumber());
            payment.setDate(LocalDateTime.now());
            paymentServices.debit(card, payment.getAmount());
            payment.setAmount(payment.getAmount() * -1);
            payment.setCode(null);
            payment.setStatus("complete");
            payment.setType("payment");
            paymentRepository.save(payment);
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    @PostMapping(value = "/confirmTransfer")
    public void confirmTransfer(@RequestBody Map<String, String> body) {
        String code = body.get("code");
        try {
            Payment payment = paymentRepository.findPaymentByCode(code);
            Card sourceCard = cardRepository.findCardByCardNumber(payment.getSourceCardNumber());
            Card receiverCard = cardRepository.findCardByCardNumber(payment.getPayee());
            payment.setDate(LocalDateTime.now());
            paymentServices.debit(sourceCard, payment.getAmount());
            payment.setAmount(payment.getAmount() * -1);
            payment.setCode(null);
            payment.setStatus("complete");
            payment.setType("transfer");
            paymentRepository.save(payment);

            Payment newPayment = new Payment();
            double amount;
            if(!receiverCard.getCurrency().equals(sourceCard.getCurrency())) {
                amount = paymentServices.convert(payment.getAmount(), sourceCard.getCurrency(), receiverCard.getCurrency());
                System.out.println(amount);
            } else {
                amount = payment.getAmount();
            }

            paymentServices.credit(receiverCard, amount * -1);
            newPayment.setUser(payment.getUser());
            newPayment.setSourceCardNumber(payment.getPayee());
            newPayment.setPayee(payment.getSourceCardNumber());
            newPayment.setAmount(amount * -1);
            newPayment.setDescription(payment.getDescription());
            newPayment.setDate(payment.getDate());
            newPayment.setStatus("complete");
            newPayment.setType("transfer");
            paymentRepository.save(newPayment);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @GetMapping(value = "/paymentsHistory")
    public List<Payment> getPayments( @RequestParam String card, Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        List<Payment> payments;
        if(card.equals("all cards")) {
            payments = paymentRepository.findPaymentsByUserOrderByDateDesc(user);
        } else {
            payments = paymentRepository.findBySourceCardNumberOrderByDateDesc(card);
        }
        return payments;
    }

    @GetMapping(value = "/createCard")
    public ResponseEntity<String> createCard(@RequestParam String currency, Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        Card card = new Card();
        card.setCardNumber(paymentServices.generateCardNumber());
        card.setCurrency(currency);
        card.setType("debit");
        card.setStatus("active");
        card.setRest(0);
        card.setUser(user);
        cardRepository.save(card);
        return new ResponseEntity<>("null", HttpStatus.OK);
    }

    @GetMapping(value = "/deleteCard")
    public ResponseEntity<String> deleteCard(@RequestParam String cardNumber) {
        try {
            Card card = cardRepository.findCardByCardNumber(cardNumber);
            cardRepository.delete(card);
            return new ResponseEntity<>("Card deleted", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("something went wrong", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/cardInfo")
    public ResponseEntity<?> getCardInfo(@RequestParam String cardNumber) {
        try {
            Card card = cardRepository.findCardByCardNumber(cardNumber);
            return new ResponseEntity<>(card, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("something went wrong", HttpStatus.BAD_REQUEST);
        }
    }

}

