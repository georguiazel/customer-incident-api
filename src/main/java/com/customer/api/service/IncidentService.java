package com.customer.api.service;

import com.customer.api.model.Incident;
import com.customer.api.repository.IncidentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IncidentService {

    private final IncidentRepository repository;

    public IncidentService(IncidentRepository repository) {
        this.repository = repository;
    }

    public Incident register(Incident incident) {
        if (incident.getTitle() == null || incident.getTitle().isBlank()) {
            throw new IllegalArgumentException("El campo 'title' es obligatorio");
        }
        return repository.save(incident);
    }

    public List<Incident> findAll() {
        return repository.findAll();
    }

    public Incident findById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Incidente no encontrado con id: " + id));
    }
}
