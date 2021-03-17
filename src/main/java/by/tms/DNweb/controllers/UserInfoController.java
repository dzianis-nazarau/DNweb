package by.tms.DNweb.controllers;

import by.tms.DNweb.entity.User;
import by.tms.DNweb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class UserInfoController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping(value = "/userInfo")
    public String welcome(Model model, Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        model.addAttribute(user);
        return "userPage";
    }

}
