<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
  // Invalidate the session and clear user data
  if (session != null) {
    session.invalidate();
  }

  // Optional: redirect with a logout message (you can catch this in login.jsp if you want)
  response.sendRedirect("login.jsp");
%>
