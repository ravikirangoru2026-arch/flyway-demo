package com.rk.batch.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // 1. Disable CSRF for development/stateless APIs
            .csrf(csrf -> csrf.disable())
            
            // 2. Configure Authorization
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/swagger-ui.html",
                    "/swagger-ui/**",
                    "/v3/api-docs/**",
                    "/h2-console/**" // Allow if you use H2 for local testing
                ).permitAll()
                .anyRequest().authenticated()
            )
            
            // 3. Enable Basic Authentication (for testing in Swagger/Postman)
            .httpBasic(Customizer.withDefaults());

        return http.build();
    }
}