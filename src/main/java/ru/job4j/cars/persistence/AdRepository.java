package ru.job4j.cars.persistence;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;
import ru.job4j.cars.model.Post;

import java.util.List;
import java.util.function.Function;

@Repository
public class AdRepository {
    private final SessionFactory sf;

    public AdRepository(SessionFactory sf) {
        this.sf = sf;
    }

    private <T> T tx(final Function<Session, T> command) {
        final Session session = sf.openSession();
        final Transaction tx = session.beginTransaction();
        try {
            T rsl = command.apply(session);
            tx.commit();
            return rsl;
        } catch (final Exception e) {
            session.getTransaction().rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public List<Post> findPostsLastDay() {
        return tx(session -> session.createQuery(
                        "select distinct p from Post p "
                                + "join fetch p.user u "
                                + "join fetch p.car c "
                                + "join fetch c.model m "
                                + "join fetch c.body b "
                                + "join fetch c.engine e "
                                + "join fetch c.users us "
                                + "where p.created = current_date", Post.class)
                .list()
        );
    }

    public List<Post> findWithPhoto() {
        return tx(session -> session.createQuery(
                        "select distinct p from Post p "
                                + "join fetch p.user u "
                                + "join fetch p.car c "
                                + "join fetch c.model m "
                                + "join fetch c.body b "
                                + "join fetch c.engine e "
                                + "join fetch c.users us "
                                + "where p.photo > 0", Post.class)
                .list()
        );
    }

    public List<Post> findByBrand(String brand) {
        return tx(session -> session.createQuery(
                        "select distinct p from Post p "
                                + "join fetch p.user u "
                                + "join fetch p.car c "
                                + "join fetch c.model m "
                                + "join fetch c.body b "
                                + "join fetch c.engine e "
                                + "join fetch c.users us "
                                + "where c.brand = :cBrand", Post.class)
                .setParameter("cBrand", brand)
                .list()
        );
    }
}
