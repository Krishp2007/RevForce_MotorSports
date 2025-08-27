package model;

import java.sql.Date;

public class Driver {
    private int driverId;
    private String driverName;
    public int skillLevel;
    public Date joinedDate;
    private long rentalPrice;
    public String nationality;
    private int teamId;  // -1 if available

    public Driver() {}

    public Driver(int driverId, String driverName, int skillLevel, Date joinedDate, long rentalPrice, String nationality, int teamId) {
        this.driverId = driverId;
        this.driverName = driverName;
        this.skillLevel = skillLevel;
        this.joinedDate = joinedDate;
        this.rentalPrice = rentalPrice;
        this.nationality = nationality;
        this.teamId = (teamId == 0 ? -1 : teamId);
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }


    public long getRentalPrice() {
        return rentalPrice;
    }

    public void setRentalPrice(long rentalPrice) {
        this.rentalPrice = rentalPrice;
    }

    public int getExperienceYears() {
        long msPerYear = 1000L * 60 * 60 * 24 * 365;
        long diff = System.currentTimeMillis() - joinedDate.getTime();
        return (int)(diff / msPerYear);
    }

    @Override
    public String toString() {
        return String.format("%d - %s | Skill: %d | Rental Price: %,d | Nationality: %s | Experience: %d years | %s",
                driverId, driverName, skillLevel, rentalPrice, nationality, getExperienceYears(), (teamId == -1 ? "Available" : "Rented"));
    }
}
