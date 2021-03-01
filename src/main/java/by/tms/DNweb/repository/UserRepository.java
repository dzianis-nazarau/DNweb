package by.tms.DNweb.repository;

import by.tms.DNweb.entity.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {

    User findByUsername(String username);

}

