<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
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
<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>

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
            <h3 class="large-logo"><a href="index.jsp">???????????????</a></h3>
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

        //Modar Login
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
	
	<section class="container mt-3" style="max-width:560px; padding-top:100px;">
		<div class="alert alert-warning mt-4" role="alert">
			Email permission is required to use it.<br> Did not receive the permission email?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">Permission E-mail</a>
	</section>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
		Copyright &copy; 2021 ????????? All Rights Reserved.
	</footer>

	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>