
import java.io.IOException;
import java.sql.Connection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Roleen
 */
public class AdminServlet extends HttpServlet {

    private String DBurl, DBun, DBpw, DBdriver;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        DBurl = config.getInitParameter("DBurl");
        DBun = config.getInitParameter("DBun");
        DBpw = config.getInitParameter("DBpw");
        DBdriver = config.getInitParameter("DBdriver");
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String action = request.getParameter("action");
        
        if (action.equals("Edit")) {
            RequestDispatcher rd = request.getRequestDispatcher("/EditUser.jsp");
            request.setAttribute("editUN", username);
            rd.forward(request, response);
        }
        else if (action.equals("Add")) {
            response.sendRedirect(request.getContextPath() + "/AddUser.jsp");
        }
        else if (action.equals("Delete")) {
            Class.forName(DBdriver);
            String deleteString = "DELETE FROM USER_INFO WHERE USERNAME = ?";
            
            try (Connection conn = 
                DriverManager.getConnection(DBurl, DBun, DBpw);
                PreparedStatement ps = conn.prepareStatement(deleteString);) {
                ps.setString(1, username);
                ps.executeUpdate();
            }
        
            response.sendRedirect(request.getContextPath() + "/Admin.jsp");  
        }
        else if (action.equals("submEdit")){
            Class.forName(DBdriver);
            String updateString = "UPDATE USER_INFO SET PASSWORD = ?, ROLE = ? WHERE USERNAME = ?";

            try (Connection conn = 
                DriverManager.getConnection(DBurl, DBun, DBpw);
                PreparedStatement ps = conn.prepareStatement(updateString);) {
                ps.setString(1, password);
                ps.setString(2, role);
                ps.setString(3, username);
                ps.executeUpdate();
            }
            
            response.sendRedirect(request.getContextPath() + "/Admin.jsp"); 
        }
        else if (action.equals("submAdd")){
            Class.forName(DBdriver);
            String addString = "INSERT INTO USER_INFO (USERNAME, PASSWORD, ROLE) VALUES (?,?,?)";
        
            try (Connection conn = 
                DriverManager.getConnection(DBurl, DBun, DBpw);
            PreparedStatement ps = conn.prepareStatement(addString);) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.executeUpdate();
            }
            
            response.sendRedirect(request.getContextPath() + "/Admin.jsp"); 
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
