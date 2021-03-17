package by.tms.DNweb.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PaymentController {

    @GetMapping("/payments")
    public String getPaymentPage() {
        return "payments";
    }

    @GetMapping("/transfer")
    public String getTransferPage() {
        return "transfer";
    }


}
