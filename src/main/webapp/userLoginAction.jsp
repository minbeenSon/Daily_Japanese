<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	if(request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	} //데이터 담는것
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	} //데이터 담는것
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	} //데이터 담는것
	if (userID == null || userPassword == null || userID.equals("") || userPassword.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('There is something you did not enter.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	System.out.println("result = " + result);
	if (result == 1) {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Wrong Password');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This ID does not exist.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('An error of Database.';)");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>