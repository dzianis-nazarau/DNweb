package by.tms.DNweb.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.logging.Logger;

@Controller
@RequestMapping("/")
public class RegistrationController {

    final static Logger logger = Logger.getLogger(RegistrationController.class.getName());

    @GetMapping(value = "/main")
    public String registerForm() {
        return "main";
    }

}
