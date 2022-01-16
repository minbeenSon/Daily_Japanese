<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="visitorBook.VisitorBookDTO"%>
<%@ page import="visitorBook.VisitorBookDAO"%>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
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
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if (emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String visitorBookTitle = null;
	String visitorBookContent = null;
	
	if (request.getParameter("visitorBookTitle") != null) {
		visitorBookTitle = request.getParameter("visitorBookTitle");
	}
	if (request.getParameter("visitorBookContent") != null) {
		visitorBookContent = request.getParameter("visitorBookContent");
	}
	if (visitorBookTitle == null || visitorBookContent == null || visitorBookTitle.equals("") || visitorBookContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('There is something you did not enter.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	VisitorBookDAO visitorBookDAO = new VisitorBookDAO();
	int result = visitorBookDAO.write(new VisitorBookDTO(0, userID, visitorBookTitle, visitorBookContent, "", 0));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Fail visitorBook.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'visitorBook.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>