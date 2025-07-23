<%-- 
    Document   : index
    Created on : 02 27, 25, 6:43:21 PM
    Author     : Roleen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="LoginCSS.css">
    </head>
    <body>
        <header>
            <p><% out.print(getServletContext().getInitParameter("header")); %></p>
        </header>
        <div id="content">
            <h1>Login</h1>
            <form method="post" action='/MP2_2CSB_GUARIN_JALANDONI/LoginServlet'>
                <fieldset>
                    <label id="username-label" for="username">Username: <input name="username" id="username" type="text" placeholder=" Input username here" /></label>
                    <label id="password-label" for="password">Password: <input name="password" id="password" type="text" placeholder=" Input password here" /></label>
                </fieldset>
                <input type="submit" id="submit" value="Submit" /> 
            </form>
        </div>
        <footer>
            <p><% out.print(getServletContext().getInitParameter("footer")); %><p>
        </footer>
    </body>
</html>

