<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="visitorBook.VisitorBookDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Log In.');");
		script.println("location.href = 'visitorBook.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String visitorBookID = null;
	if (request.getParameter("visitorBookID") != null) {
		visitorBookID = request.getParameter("visitorBookID");
	}
	VisitorBookDAO visitorBookDAO = new VisitorBookDAO();
	if (userID.equals(visitorBookDAO.getUserID(visitorBookID))) {
		int result = new VisitorBookDAO().delete(visitorBookID);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Success delete.');");
			script.println("location.href = 'visitorBook.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Error of Database');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You can only delete what you wrote.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>