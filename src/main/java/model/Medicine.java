package model;

/**
 *
 * @author Le Phong Vinh - CE181130
 */
public class Medicine {

    private int medicineId;
    private String name;
    private String description;
    private String unit;

    public Medicine() {
    }

    public Medicine(int medicineId, String name, String description, String unit) {
        this.medicineId = medicineId;
        this.name = name;
        this.description = description;
        this.unit = unit;
    }

    public Medicine(String name, String description, String unit) {
        this.name = name;
        this.description = description;
        this.unit = unit;
    }

    public int getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
