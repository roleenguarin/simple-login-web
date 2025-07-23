<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Error 2</title>
        <link rel="stylesheet" href="LoginCSS.css">
</head>
<body>
    <header>
        <h1>Welcome, Admin: <%= session.getAttribute("username") %></h1>
    </header>
    <h1>Application Error</h1>
    <h2>Login Error</h2>
    <p>Username is correct, but password is incorrect.</p>
    <a href="index.jsp">Go back to Login</a>
    <footer>
            <p><% out.print(getServletContext().getInitParameter("footer")); %><p>
        </footer>
</body>
</html>