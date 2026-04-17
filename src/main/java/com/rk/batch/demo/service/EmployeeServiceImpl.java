package com.rk.batch.demo.service;

import com.rk.batch.demo.dto.EmployeeRequestDTO;
import com.rk.batch.demo.dto.EmployeeResponseDTO;
import com.rk.batch.demo.dto.PagedResponseDTO;
import com.rk.batch.demo.entity.Employee;
import com.rk.batch.demo.exception.DuplicateResourceException;
import com.rk.batch.demo.exception.ResourceNotFoundException;
import com.rk.batch.demo.mapper.EmployeeMapper;
import com.rk.batch.demo.repository.EmployeeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class EmployeeServiceImpl implements EmployeeService {

    private final EmployeeRepository employeeRepository;
    private final EmployeeMapper employeeMapper;

    @Override
    @Transactional
    public EmployeeResponseDTO create(EmployeeRequestDTO requestDTO) {
        if (employeeRepository.existsByEmployeeCode(requestDTO.getEmployeeCode())) {
            throw new DuplicateResourceException("Employee code already exists: " + requestDTO.getEmployeeCode());
        }
        if (employeeRepository.existsByEmail(requestDTO.getEmail())) {
            throw new DuplicateResourceException("Email already registered: " + requestDTO.getEmail());
        }
        Employee employee = employeeMapper.toEntity(requestDTO);
        Employee saved = employeeRepository.save(employee);
        log.info("Created employee with id={}, code={}", saved.getId(), saved.getEmployeeCode());
        return employeeMapper.toResponseDTO(saved);
    }

    @Override
    public EmployeeResponseDTO getById(Long id) {
        return employeeRepository.findById(id)
                .map(employeeMapper::toResponseDTO)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));
    }

    @Override
    public EmployeeResponseDTO getByEmployeeCode(String employeeCode) {
        return employeeRepository.findByEmployeeCode(employeeCode)
                .map(employeeMapper::toResponseDTO)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with code: " + employeeCode));
    }

    @Override
    public PagedResponseDTO<EmployeeResponseDTO> getAll(int page, int size, String sortBy, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("desc")
                ? Sort.by(sortBy).descending()
                : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Employee> employeePage = employeeRepository.findAll(pageable);
        return buildPagedResponse(employeePage);
    }

    @Override
    public PagedResponseDTO<EmployeeResponseDTO> search(String query, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("name").ascending());
        Page<Employee> result = employeeRepository
                .findByNameContainingIgnoreCaseOrEmailContainingIgnoreCase(query, query, pageable);
        return buildPagedResponse(result);
    }

    @Override
    @Transactional
    public EmployeeResponseDTO update(Long id, EmployeeRequestDTO requestDTO) {
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));

        if (employeeRepository.existsByEmailAndIdNot(requestDTO.getEmail(), id)) {
            throw new DuplicateResourceException("Email already in use: " + requestDTO.getEmail());
        }
        employeeMapper.updateEntityFromDTO(requestDTO, employee);
        Employee updated = employeeRepository.save(employee);
        log.info("Updated employee id={}", id);
        return employeeMapper.toResponseDTO(updated);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        if (!employeeRepository.existsById(id)) {
            throw new ResourceNotFoundException("Employee not found with id: " + id);
        }
        employeeRepository.deleteById(id);
        log.info("Deleted employee id={}", id);
    }

    private PagedResponseDTO<EmployeeResponseDTO> buildPagedResponse(Page<Employee> employeePage) {
        List<EmployeeResponseDTO> content = employeePage.getContent()
                .stream()
                .map(employeeMapper::toResponseDTO)
                .toList();
        return PagedResponseDTO.<EmployeeResponseDTO>builder()
                .content(content)
                .page(employeePage.getNumber())
                .size(employeePage.getSize())
                .totalElements(employeePage.getTotalElements())
                .totalPages(employeePage.getTotalPages())
                .last(employeePage.isLast())
                .build();
    }
}