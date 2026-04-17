package com.rk.batch.demo.service;

import com.rk.batch.demo.dto.EmployeeRequestDTO;
import com.rk.batch.demo.dto.EmployeeResponseDTO;
import com.rk.batch.demo.dto.PagedResponseDTO;

public interface EmployeeService {
    EmployeeResponseDTO create(EmployeeRequestDTO requestDTO);
    EmployeeResponseDTO getById(Long id);
    EmployeeResponseDTO getByEmployeeCode(String employeeCode);
    PagedResponseDTO<EmployeeResponseDTO> getAll(int page, int size, String sortBy, String sortDir);
    PagedResponseDTO<EmployeeResponseDTO> search(String query, int page, int size);
    EmployeeResponseDTO update(Long id, EmployeeRequestDTO requestDTO);
    void delete(Long id);
}