<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>
<%
	UserDAO userDAO = new UserDAO();
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
	
	request.setCharacterEncoding("UTF-8");
	String visitorBookReportTitle = null;
	String visitorBookReportContent = null;
	if (request.getParameter("visitorBookReportTitle") != null) {
		visitorBookReportTitle = request.getParameter("visitorBookReportTitle");
	}
	if (request.getParameter("visitorBookReportContent") != null) {
		visitorBookReportContent = request.getParameter("visitorBookReportContent");
	}
	if (visitorBookReportTitle == null || visitorBookReportContent == null || visitorBookReportTitle.equals("") || visitorBookReportContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('There is something yoy did not enter.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host ="http://localhost:8080/Daily_Japanese/";
	String from = userDAO.getUserEmail(userID); //왜 여기기가 회원의 이메일(네이버)이 아닌 구글로 나오는것이지?
	String to = "thsalsqls@gmail.com";
	String subject = "접수된 신고 메일입니다.";
	String content = "신고자ID : " + userID + 
					 "<br>제목 : " + visitorBookReportTitle + 
					 "<br>내용 : " + visitorBookReportContent;
	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	System.out.println("from = "+from);
	try {
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
	} catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('An error is issued.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Success report.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
%>