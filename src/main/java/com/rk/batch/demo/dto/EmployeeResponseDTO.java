package com.rk.batch.demo.dto;

import lombok.*;

import java.time.Instant;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmployeeResponseDTO {
    private Long id;
    private String employeeCode;
    private String name;
    private String email;
    private String phoneNo;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String postalCode;
    private String countryCode;
    private Instant createdAt;
    private Instant updatedAt;
}