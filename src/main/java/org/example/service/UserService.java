package org.example.service;

import org.example.entities.User;
import org.example.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.Optional;

@ApplicationScoped
public class UserService {

    @Inject
    UserRepository repository;

    public User authenticate(String email, String rawPassword) {
        User u = repository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Identifiants incorrects"));
        if (!rawPassword.equals(u.getPassword())) {
            throw new RuntimeException("Identifiants incorrects");
        }
        if (!u.getActif()) {
            throw new RuntimeException("Compte désactivé");
        }
        return u;
    }

    public Optional<User> findById(Long id) {
        return repository.findById(id);
    }

    public User create(User u) {
        repository.create(u);
        return u;
    }

    public User update(User u) {
        return repository.update(u);
    }
}