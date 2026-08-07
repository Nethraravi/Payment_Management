package org.company.payment.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages = {
        "org.company.payment.service",
        "org.company.payment.repository",
        "org.company.payment.config",
        "org.company.payment.persistence",
        "org.company.payment.exception"})
public class RootConfig {
}
