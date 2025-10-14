package model;
public class Specialty {
  private int specialtyId;
  private String specialtyName;
  public Specialty() {}
  public Specialty(int id, String name){ this.specialtyId=id; this.specialtyName=name; }
  public int getSpecialtyId(){ return specialtyId; }
  public void setSpecialtyId(int id){ this.specialtyId=id; }
  public String getSpecialtyName(){ return specialtyName; }
  public void setSpecialtyName(String name){ this.specialtyName=name; }
}
