package by.tms.DNweb.controllers;

import by.tms.DNweb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserIndoController {

    @Autowired
    private UserRepository repository;

    @GetMapping("/useruserInfo")
    public String welcome() {
        return "userPage";
    }

}
