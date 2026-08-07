package org.company.payment.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.company.payment.entity.Payment;
import org.company.payment.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PaymentRepository{

    @PersistenceContext
    private EntityManager entityManager;

    public Payment savePayment(Payment payment)
    {
        System.out.println("PaymentRepository.savePayment() EXECUTED");
        //Payment payment = new Payment(new BigDecimal("5000.0"),"UPI","SUCCESS", LocalDateTime.now());
        entityManager.persist(payment);
        return payment;
    }

    public List<Payment> findAllPayments()
    {
        return entityManager.createQuery("SELECT p FROM Payment p LEFT JOIN FETCH p.createdBy", Payment.class).getResultList();
    }

    public Payment findPaymentById(Long id)
    {
        return entityManager.createQuery("SELECT p FROM Payment p LEFT JOIN FETCH p.createdBy WHERE p.id = :id",Payment.class).setParameter("id",id).getSingleResult();
    }

    public void deletePayment(Payment payment)
    {
        entityManager.remove(payment);
    }

    public List<Payment> findPaymentsByUser(User user)
    {
        return entityManager.createQuery("SELECT p FROM Payment p LEFT JOIN FETCH p.createdBy WHERE p.createdBy = :user",Payment.class).setParameter("user",user).getResultList();
    }
}
