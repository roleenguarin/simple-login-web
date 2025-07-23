<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="LoginCSS.css">
    </head>
    <body>
        <header>
            <p><% out.print(getServletContext().getInitParameter("header")); %></p>
        </header>
        
        <table>
            <tr>
                <th>Username</th>
                <th>Password</th>
                <th>Role</th>
                <th></th>
            </tr>
            <%
                String dbURL = (String) session.getAttribute("dburl");
                String dbUser = (String) session.getAttribute("dbun");
                String dbPassword = (String) session.getAttribute("dbpw");
                String DBdriver = (String) session.getAttribute("dbdriver");
                
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                List<String> uns  = null;
                List<String> pws  = null;
                List<String> roles  = null;
                int row = 0;

                try {
                    Class.forName(DBdriver); 
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM USER_INFO ORDER BY USERNAME ASC");

                    while (rs.next()) {
                        String uname = rs.getString("USERNAME");
                        String urole = rs.getString("ROLE");
                        String upw = rs.getString("PASSWORD");
                        

                        //uns.add(uname);
                        //pws.add(upw);
                        //roles.add(urole);
                        
                        row++;
             %>
            <tr>
                
            <tr>
                <td><%= uname %></td>
                <td><%= upw %></td>
                <td><%= urole %></td>
                <td>
                    <form action="AdminServlet" method="post">
                        <input type="hidden" name="username" value="<%= uname %>">
                        <input type="hidden" name="password" value="<%= upw %>">
                        <input type="hidden" name="role" value="<%= urole %>">
                        <button type="submit" name="action" value="Delete">Delete</button>
                    </form>
                </td>
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

        
        <form action="AdminServlet" method="post">
            <button type="submit" name="action" value="Edit">Edit</button>
        </form>
        <form action="AdminServlet" method="post">
            <button type="submit" name="action" value="Add">Add New User</button>
        </form><br><br>
        <form action="LogoutServlet" method="post">
            <button type="submit">Logout</button>
        </form>
        
        <footer>
            <p><% out.print(getServletContext().getInitParameter("footer")); %><p>
        </footer>
    </body>
</html>