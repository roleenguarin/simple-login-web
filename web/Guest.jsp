<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Guest Dashboard</title>
        <link rel="stylesheet" href="LoginCSS.css">
    </head>
    <body>
        <header>
            <p><% out.print(getServletContext().getInitParameter("header")); %></p>
        </header>
        
        <form method="post" action='/MP2/AdminServlet.java'>
        <table>
            <tr>
                <th>Username</th>
                <th>Password</th>
                <th>Role</th>
            </tr>
            <%
                int rows = 0;
                
                String dbURL = (String) session.getAttribute("dburl");
                String dbUser = (String) session.getAttribute("dbun");
                String dbPassword = (String) session.getAttribute("dbpw");
                String DBdriver = (String) session.getAttribute("dbdriver");
                
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName(DBdriver); 
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM USER_INFO ORDER BY USERNAME ASC");

                    while (rs.next()) {
                        String uname = rs.getString("USERNAME");
                        String urole = rs.getString("ROLE");
                        String upw = rs.getString("PASSWORD");
             %>
            <tr>
                
            <tr>
                <td><%= uname %></td>
                <td><%= upw %></td>
                <td><%= urole %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            </tr>
            
        </table>
        </form>

        <form action="LogoutServlet" method="post">
            <button type="submit">Logout</button>
        </form>
            
            <footer>
            <p><% out.print(getServletContext().getInitParameter("footer")); %><p>
        </footer>
    </body>
</html>