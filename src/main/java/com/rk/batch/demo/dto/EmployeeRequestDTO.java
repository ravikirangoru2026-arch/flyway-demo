package com.rk.batch.demo.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Schema(description = "Employee create/update request payload")
public class EmployeeRequestDTO {

    @Schema(description = "Unique internal payroll code", example = "EMP-001")
    @NotBlank(message = "Employee code is required")
    @Size(max = 20, message = "Employee code must not exceed 20 characters")
    private String employeeCode;

    @Schema(description = "Full name", example = "John Doe")
    @NotBlank(message = "Name is required")
    @Size(max = 255)
    private String name;

    @Schema(description = "Work email", example = "john.doe@company.com")
    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    @Size(max = 255)
    private String email;

    @Schema(description = "Phone number", example = "+1-555-0100")
    @Size(max = 20)
    private String phoneNo;

    @Schema(description = "Address line 1", example = "123 Main St")
    @Size(max = 255)
    private String addressLine1;

    @Schema(description = "Address line 2", example = "Suite 100")
    @Size(max = 255)
    private String addressLine2;

    @Schema(example = "New York")
    @Size(max = 100)
    private String city;

    @Schema(example = "NY")
    @Size(max = 100)
    private String state;

    @Schema(example = "10001")
    @Size(max = 20)
    private String postalCode;

    @Schema(description = "ISO 3166-1 alpha-2 country code", example = "US")
    @Size(min = 2, max = 2, message = "Country code must be ISO 3166-1 alpha-2 (2 chars)")
    private String countryCode;
}