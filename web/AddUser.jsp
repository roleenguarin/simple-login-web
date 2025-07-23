<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Add User</title>
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
                <th>Actions</th>
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
                    rs = stmt.executeQuery("SELECT * FROM USER_INFO");

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
                <td>
                    <button type="submit" name="action" value="Edit">Edit</button>
                    <button type="submit" name="action" value="Delete">Delete</button>
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
            </tr>
                <form action="AdminServlet" method="post">
                    <td>
                        <fieldset>
                            <label id="username-label" for="username">Username: <input name="username" id="username" type="text" placeholder=" Input new username" /></label>
                        </fieldset>
                    </td>
                    <td>
                        <fieldset>
                            <label id="password-label" for="password">Username: <input name="password" id="password" type="text" placeholder=" Input new password" /></label>
                        </fieldset>
                    </td>
                    <td>
                        <fieldset>
                            <label id="role-label" for="role">Username: <input name="role" id="role" type="text" placeholder=" Input new role" /></label>
                        </fieldset>
                    </td>
                    <td>
                        <button type="submit" name="action" value="submAdd">Submit</button>
                    </td>
                </form>
            </tr>
            
        </table>

        <button type="submit">Logout</button>
        
        <footer>
            <p><% out.print(getServletContext().getInitParameter("footer")); %><p>
        </footer>
    </body>
</html>