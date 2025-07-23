<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Session Expired</title>
        <link rel="stylesheet" href="LoginCSS.css">
</head>
<body>
    <header>
        <h1>Welcome, Admin: <%= session.getAttribute("username") %></h1>
    </header>
    <h1>Application Error</h1>
    <h2>Session Expired</h2>
    <p>You attempted to access the success page without logging in.</p>
    <a href="index.jsp">Go back to Login</a>
    <footer>
            <p><% out.print(getServletContext().getInitParameter("footer")); %><p>
        </footer>
</body>
</html>