package org.example.dto;

public class SpecialityDTO {
    private Long id;
    private String code;
    private String nom;
    private String description;
    private Long departmentId;
    private String departmentName;

    public SpecialityDTO() {
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

    public Long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public static class Builder {
        private final SpecialityDTO dto = new SpecialityDTO();

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

        public Builder departmentId(Long departmentId) {
            dto.setDepartmentId(departmentId);
            return this;
        }

        public Builder departmentName(String departmentName) {
            dto.setDepartmentName(departmentName);
            return this;
        }

        public SpecialityDTO build() {
            return dto;
        }
    }
}