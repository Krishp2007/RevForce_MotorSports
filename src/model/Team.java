package model;

public class Team {
    private int teamId;
    public String teamName;
    private long budget;
    public String origin;
    public int foundingYear;
    public String email;

    public Team() {}

    public Team(int teamId, String teamName, long budget, String origin, int foundingYear, String email) {
        this.teamId = teamId;
        this.teamName = teamName;
        this.budget = budget;
        this.origin = origin;
        this.foundingYear = foundingYear;
        this.email = email;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public long getBudget() {
        return budget;
    }

    public void setBudget(long budget) {
        this.budget = budget;
    }

    public String toString() {
        return String.format("%d - %s | Origin: %s | Budget: %,d | Founded: %d", teamId, teamName, origin, budget, foundingYear);
    }
}
