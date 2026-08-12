package org.company.payment.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.company.payment.entity.Payment;
import org.company.payment.entity.User;
import org.company.payment.enums.PaymentStatus;
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

    public long countAllPayments()
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p", Long.class).getSingleResult();
    }

    public long countSuccessfulPayments()
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.status = :status", Long.class).setParameter("status", org.company.payment.enums.PaymentStatus.SUCCESS).getSingleResult();
    }

    public long countPendingPayments()
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.status= :status",Long.class).setParameter("status", org.company.payment.enums.PaymentStatus.PENDING).getSingleResult();
    }

    public long countFailedPayments()
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.status = :status", Long.class).setParameter("status", org.company.payment.enums.PaymentStatus.FAILED).getSingleResult();
    }

    public long countPaymentsByUser(User user)
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.createdBy = :user", Long.class).setParameter("user", user).getSingleResult();
    }

    public long countSuccessfulPaymentsByUser(User user)
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.createdBy = :user AND p.status = :status",Long.class).setParameter("user", user).setParameter("status",org.company.payment.enums.PaymentStatus.SUCCESS).getSingleResult();
    }

    public long countPendingPaymentsByUser(User user)
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.createdBy = :user AND p.status = :status",Long.class).setParameter("user",user).setParameter("status", PaymentStatus.PENDING).getSingleResult();
    }

    public long countFailedPaymentsByUser(User user)
    {
        return entityManager.createQuery("SELECT COUNT(p) FROM Payment p WHERE p.createdBy = :user AND p.status = :status",Long.class).setParameter("user",user).setParameter("status",PaymentStatus.FAILED).getSingleResult();
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
