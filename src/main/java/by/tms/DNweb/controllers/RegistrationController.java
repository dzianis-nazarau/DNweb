package by.tms.DNweb.controllers;

import by.tms.DNweb.entity.User;
import by.tms.DNweb.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
