package org.example.dto;

public class DepartmentDTO {
    private Long id;
    private String code;
    private String nom;
    private String description;

    public DepartmentDTO() {
    }

    public static Builder builder() {
        return new Builder();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public static class Builder {
        private final DepartmentDTO dto = new DepartmentDTO();

        public Builder id(Long id) {
            dto.setId(id);
            return this;
        }

        public Builder code(String code) {
            dto.setCode(code);
            return this;
        }

        public Builder nom(String nom) {
            dto.setNom(nom);
            return this;
        }

        public Builder description(String description) {
            dto.setDescription(description);
            return this;
        }

        public DepartmentDTO build() {
            return dto;
        }
    }
}