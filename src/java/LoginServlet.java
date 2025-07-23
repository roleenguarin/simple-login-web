import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

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
        
        String un = request.getParameter("username");
        String pw = request.getParameter("password");
        Boolean unIn = false;
        Boolean pwIn = false;
        
        // Null or empty check
        if (un == null || un.isEmpty() || pw == null || pw.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/noLoginCredentials.jsp");
            return;
        }

        Class.forName("org.apache.derby.jdbc.ClientDriver");
        String sql = "SELECT * FROM USER_INFO WHERE USERNAME = ?";
        
        try (Connection conn = DriverManager.getConnection(DBurl, DBun, DBpw);
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, un);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String dbPassword = rs.getString("PASSWORD");
                String role = rs.getString("ROLE");
                
                if (pw.equals(dbPassword)) {
                    unIn = true;
                    pwIn = true;
                    // Successful Login
                    HttpSession session = request.getSession(true);
                    session.setAttribute("username", un);
                    session.setAttribute("role", role);
                    session.setAttribute("dburl", DBurl);
                    session.setAttribute("dbun", DBun);
                    session.setAttribute("dbpw", DBpw);
                    session.setAttribute("dbdriver", DBdriver);
                    session.setMaxInactiveInterval(5 * 60); // 5 minutes
                    
                    if ("Guest".equals(role)) {
                        response.sendRedirect(request.getContextPath() + "/Guest.jsp");
                    } else if ("Admin".equals(role)) {
                        response.sendRedirect(request.getContextPath() + "/Admin.jsp");
                    }
                } else {
                    unIn = true;
                    // Incorrect password
                    response.sendRedirect(request.getContextPath() + "/error_2.jsp");
                }
            } else {
                unIn = true;
                // Username not found
                response.sendRedirect(request.getContextPath() + "/error_1.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error_4.jsp");
        }
        
        if (unIn == false && pwIn == false)
            response.sendRedirect(request.getContextPath() + "/error_3.jsp");
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