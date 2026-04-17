package com.rk.batch.demo.mapper;

import com.rk.batch.demo.dto.EmployeeRequestDTO;
import com.rk.batch.demo.dto.EmployeeResponseDTO;
import com.rk.batch.demo.entity.Employee;
import org.springframework.stereotype.Component;

@Component
public class EmployeeMapper {

    public Employee toEntity(EmployeeRequestDTO dto) {
        return Employee.builder()
                .employeeCode(dto.getEmployeeCode())
                .name(dto.getName())
                .email(dto.getEmail())
                .phoneNo(dto.getPhoneNo())
                .addressLine1(dto.getAddressLine1())
                .addressLine2(dto.getAddressLine2())
                .city(dto.getCity())
                .state(dto.getState())
                .postalCode(dto.getPostalCode())
                .countryCode(dto.getCountryCode() != null ? dto.getCountryCode() : "US")
                .build();
    }

    public EmployeeResponseDTO toResponseDTO(Employee employee) {
        return EmployeeResponseDTO.builder()
                .id(employee.getId())
                .employeeCode(employee.getEmployeeCode())
                .name(employee.getName())
                .email(employee.getEmail())
                .phoneNo(employee.getPhoneNo())
                .addressLine1(employee.getAddressLine1())
                .addressLine2(employee.getAddressLine2())
                .city(employee.getCity())
                .state(employee.getState())
                .postalCode(employee.getPostalCode())
                .countryCode(employee.getCountryCode())
                .createdAt(employee.getCreatedAt())
                .updatedAt(employee.getUpdatedAt())
                .build();
    }

    public void updateEntityFromDTO(EmployeeRequestDTO dto, Employee employee) {
        employee.setName(dto.getName());
        employee.setEmail(dto.getEmail());
        employee.setPhoneNo(dto.getPhoneNo());
        employee.setAddressLine1(dto.getAddressLine1());
        employee.setAddressLine2(dto.getAddressLine2());
        employee.setCity(dto.getCity());
        employee.setState(dto.getState());
        employee.setPostalCode(dto.getPostalCode());
        if (dto.getCountryCode() != null) {
            employee.setCountryCode(dto.getCountryCode());
        }
        // employeeCode intentionally excluded from updates
    }
}