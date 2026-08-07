package org.company.payment.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.company.payment.dto.UserRequestDTO;
import org.company.payment.dto.UserResponseDTO;
import org.company.payment.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public User findByUsername(String username) {

        try {
            return entityManager.createQuery("FROM User WHERE username = :username", User.class).setParameter("username", username).getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            return null;
        }
    }

    public List<User> findAll()
    {
        return entityManager.createQuery("FROM User", User.class).getResultList();
    }

    public void save(User user) {
        entityManager.persist(user);
    }

    public User findById(Long id)
    {
        return entityManager.find(User.class, id);
    }

}
