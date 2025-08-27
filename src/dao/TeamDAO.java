package dao;

import model.Team;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeamDAO {
    public static Team getTeamById(int teamId) {
        String query = "SELECT * FROM teams WHERE team_id = ?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, teamId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Team t = new Team();
                t.setTeamId(rs.getInt("team_id"));
                t.teamName = rs.getString("team_name");
                t.setBudget(rs.getLong("budget"));
                t.origin = rs.getString("origin");
                t.foundingYear = rs.getInt("founding_year");
                t.email = rs.getString("email");
                return t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int addTeam(String teamName, String origin) {
        int teamId = -1;
        String email = teamName.replaceAll("\\s+", "").toLowerCase() + "@gmail.com";
        try {
            Connection conn = DBManager.getConnection();
            String query = "INSERT INTO teams (team_name, origin, email) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, teamName);
            ps.setString(2, origin);
            ps.setString(3, email);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                teamId = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return teamId;
    }

}
