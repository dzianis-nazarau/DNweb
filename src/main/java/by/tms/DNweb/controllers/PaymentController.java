package by.tms.DNweb.controllers;

import by.tms.DNweb.entity.Card;
import by.tms.DNweb.entity.User;
import by.tms.DNweb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.List;

@Controller
public class PaymentController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/payments")
    public String getPaymentPage() {
        return "payments";
    }

}
