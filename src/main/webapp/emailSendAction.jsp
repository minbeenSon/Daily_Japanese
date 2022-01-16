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
		script.println("alert('Please Log In');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if (emailChecked == true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You are a certified member.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host ="http://localhost:8080/Daily_Japanese/";
	String from ="thsalsqls@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "This is an email authentication for Join";
	String content = "Please go to the link and verify your email." + "<a href='" 
		+ host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>Permission</a>";
	
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

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
	<title>Daily Japanese</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>

	<div class="black-bg">
        <div class="white-bg">
            <form action="./userLoginAction.jsp" method="post">
                <div class="mb-3">
                    <label>ID</label>
                    <input type="text" name="userID" class="form-control" maxlength="30" placeholder="Enter your ID">
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" name="userPassword" class="form-control" maxlength="30" placeholder="Enter your Password">
                </div>

                <button type="submit" class="modal-submit btn btn-primary">Login</button>
                <button type="button" class="modal-close btn btn-danger">Close</button>
            </form>
        </div>
    </div>
    
    <div class="side-nav pt-3">
        <div class="x-box pt-2">
            <p>MENU</p>
            <div class="x"><i class="fas fa-times"></i></div>
        </div>
        <ul>
            <li><a href="#"><i class="fas fa-desktop"></i>Lesson</a></li>
            <li><a href="#"><i class="fas fa-question-circle"></i>Question</a></li>
            <li><a href="#"><i class="fas fa-play"></i>Entertainment</a></li>
            <li><a href="visitorBook.jsp"><i class="fas fa-sticky-note"></i>VisitorBook</a></li>
        </ul>
    </div>

    <nav>
        <div>
            <h3 class="large-logo"><a href="index.jsp">생활일본어</a></h3>
        </div>
        <div>
            <ul>
                <li class="nav-list"><a href="#">Lesson</a></li>
                <li class="nav-list"><a href="#">Question</a></li>
                <li class="nav-list"><a href="#">Entertainment</a></li>
                <li class="nav-list"><a href="visitorBook.jsp">VisitorBook</a></li>
                <li>
<%
	if (userID == null) {
%>
                	<button type="button" class="btn btn-secondary" id="login">Login</button>
                	<a type="button" href="userJoin.jsp" class="btn btn-secondary" id="join" style="color:white;">Join</a>
<%
	} else {
%>
					<a type="button" href="userLogout.jsp" class="btn btn-secondary" id="logout" style="color:white;">Logout</a>
<%
	}
%>					
                </li>
                <li class="side-control"><i class="fas fa-bars"></i></li>
            </ul>
        </div>
    </nav>
    
    <script type="text/javascript"> 

        //Modal Login
        $('#login').click(function () {
            $('.black-bg').addClass('slide-down');
        })

        $('.black-bg').click(function (e) {
            if (e.target == e.currentTarget) {
            	$("#loginForm")[0].reset();
                $('.black-bg').removeClass('slide-down');
            }
        })
        $('.modal-close').click(function (e) {
            e.preventDefault;
            $("#loginForm")[0].reset();
            $('.black-bg').removeClass('slide-down');
        })
        
         //For side-nav
        $('.side-control').click(function () {
            $('.side-nav').css('transform', 'translateX(0)');
        });

        $('.x').click(function () {
            $('.side-nav').css('transform', 'translateX(215px');
        });
            
      //When Scroll down, nav-bar gets change.
        $(window).scroll(function () {
            var height = $(window).scrollTop();
            console.log(height);

            if (height > 30) {
                $('nav').addClass('nav-black');;
                $('.large-logo').addClass('small-logo');
                $('.nav-list a, .large-logo a').css('color', 'white');
                $('#login, #join,#logout').css('transform','scale(0.87)');
            } else {
                $('nav').removeClass('nav-black');
                $('.large-logo').removeClass('small-logo');
                $('.nav-list a, .large-logo a').css('color', 'black');
                $('#login, #join,#logout').css('transform','scale(1)');
            }
        })
    </script>
	
	<section class="container" style="padding-top:100px; max-width:560px;">
		<div class="alert alert-success mt-4" role="alert">
			An authentication email has been sent.<br>
			When you sign up, please go into the email you entered and verify it.
		</div>
	</section>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
		Copyright &copy; 2021 손민빈 All Rights Reserved.
	</footer>

	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>