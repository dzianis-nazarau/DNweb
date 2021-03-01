package by.tms.DNweb.controllers;

import by.tms.DNweb.entity.Currency;
import by.tms.DNweb.entity.User;
import by.tms.DNweb.repository.CurrencyRepository;
import by.tms.DNweb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1")
public class APIController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CurrencyRepository currencyRepository;

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
}
