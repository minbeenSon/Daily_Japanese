<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
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

        //login 모달창
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
        
         //side-nav 용
        $('.side-control').click(function () {
            $('.side-nav').css('transform', 'translateX(0)');
        });

        $('.x').click(function () {
            $('.side-nav').css('transform', 'translateX(215px');
        });
            
      //스크롤에 따른 nav 바 크기 변화
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
    	<form id="joinForm" method="post" action="./userRegisterAction.jsp" >
			<div class="form-group">
				<label>ID</label>
				<input type="text" name="userID" class="form-control joinID" maxlength="30">
				<p id="IDAlert" style="color: red; display:none;">Please start with English and write at least 6 letters in English and numbers.</p>
			</div>
			<div class="form-group">
				<label>Password</label>
				<input type="password" name="userPassword" class="form-control joinPassword" maxlength="30">
				<p id="passwordAlert" style="color: red; display:none;">Please write at least 8 letters in English and numbers.</p>
			</div>
			<div class="form-group">
				<label>E-mail</label>
				<input type="email" name="userEmail" class="form-control joinEmail" maxlength="30">
				 <p id="emailAlert" style="color: red; display:none;">Please write your right E-mail.</p>
			</div>
			<button type="submit" class="btn btn-primary">Join</button>
		</form>
    </section> 

	<script type="text/javascript">
    	$('#joinForm').on('submit', function(e) {
    		var IDExp = /^[a-z]+[a-z0-9]{5,19}$/g;
    		var writtenID = $('.joinID').val();
    		if (writtenID == "" || IDExp.test(writtenID) == false) {
    			e.preventDefault();
           		$('#IDAlert').show();
    		} else {
    			$('#IDAlert').hide();
    		}
    		
    		var passwordExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
           	var writtenPassword = $('.joinPassword').val();
           	if (writtenPassword =="" || passwordExp.test(writtenPassword) == false) {
           		e.preventDefault();
           		$('#passwordAlert').show();
           	} else {
    			$('#passwordAlert').hide();
    		}
           	
    		var emailExp = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\.,;\s@\"]+\.{0,1})+([^<>()\.,;:\s@\"]{2,}|[\d\.]+))$/;
            var writtenEmail = $('.joinEmail').val();
            if (writtenEmail == "" || emailExp.test(writtenEmail) == false) {
            	e.preventDefault();
            	$('#emailAlert').show();
            } else {
    			$('#emailAlert').hide();
    		}
    	})
    </script>

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
		Copyright &copy; 2021 손민빈 All Rights Reserved.
	</footer>

	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>