package org.company.payment.config;

import com.mysql.cj.x.protobuf.MysqlxCursor;
import org.company.payment.entity.User;
import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.Optional;

@Component
public class AuditorAwareImpl implements AuditorAware<User> {

    @Override
    public Optional<User> getCurrentAuditor()
    {
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();

        if(attributes == null)
        {
            return Optional.empty();
        }

        User loggedInUser = (User) attributes.getAttribute("loggedInUser", RequestAttributes.SCOPE_SESSION);
        return Optional.ofNullable(loggedInUser);
    }
}
