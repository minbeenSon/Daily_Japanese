<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
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
            <form id="loginForm" action="./userLoginAction.jsp" method="post">
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

	<div style="overflow: hidden; position: relative;">
        <div class="slide-container">
            <div class="slide-box">
                <div style="padding: 80px 120px;">
                    <h1>Study with me?</h1>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. <br> Explicabo nam quidem, distinctio
                        magni.</p>
                    <a type="button" href="#" class="btn btn-dark mt-4">Lesson</a>
                </div>
            </div>
            <div class="slide-box">
                <div style="padding: 80px 120px;">
                    <h1>Ask me anything <br> about Japanese.</h1>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. <br> Explicabo nam quidem, distinctio
                        magni.</p>
                    <a type="button" href="#" class="btn btn-dark mt-4">Question</a>
                </div>
            </div>
            <div class="slide-box">
                <div style="padding: 80px 120px;">
                    <h1>Let's talk about Japan.</h1>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. <br> Explicabo nam quidem, distinctio
                        magni.</p>
                    <a type="button" href="#" class="btn btn-dark mt-4">Entertainment</a>
                </div>
            </div>
            <div class="slide-box">
                <div style="padding: 80px 120px;">
                    <h1>Why don't you <br> leave your message?</h1>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. <br> Explicabo nam quidem, distinctio
                        magni.</p>
                    <a type="button" href="visitorBook.jsp" class="btn btn-dark mt-4">VisitorBook</a>
                </div>
            </div>
            <div style="clear: both;"></div>
        </div>
        <p class="slide-btn">
            <!-- From JavaScript -->
        </p>
        <i class="fas fa-less-than slide-pre"></i>
        <i class="fas fa-greater-than slide-next"></i>
    </div>

	<script type="text/javascript"> 

        var currentImg = 0;
        var slideBtnHTML = '';
        var timer  //광역변수로 만들어야 함 // 함수에 변수를 넣으면 그 함수 안에서만 사용 가능

        //확장성을 위한 코딩
        for (var x = 0; x < $('.slide-box').length; x++) {
            slideBtnHTML += '<span style="margin:0 5px;">' + x + '</span>';
            console.log(slideBtnHTML);
            $('.slide-btn').html(slideBtnHTML);
        }

        //next, pre
        function goToSlide(pageNum) {
            for (var y = 0; y < $('.slide-btn span').length; y++) {
                $('.slide-btn span').eq(y).css('background', 'darkgray');
            }
            $('.slide-btn span').eq(pageNum).css('background', '#444');

            $('.slide-container').addClass('transforming').css('transform', 'translateX(-' + pageNum + '00vw)');
            currentImg = pageNum;
        }
        goToSlide(0); //처음 화면에서도 버튼색이 변하게 하기위해

        $('.slide-next').click(function () {
            if (currentImg == $('.slide-box').length - 1) {
                goToSlide(0);
            } else {
                goToSlide(currentImg + 1);
            }
        })

        $('.slide-pre').click(function () {
            if (currentImg == 0) {
                goToSlide($('.slide-box').length - 1)
            } else {
                goToSlide(currentImg - 1);
            }
        })

        //For Auto Slide // 0->1->2->3->0->1->2->3
        function startAutoSlide() {
            timer = setInterval(function () {
                var nextIdx = (currentImg + 1) % $('.slide-box').length;
                goToSlide(nextIdx);
            }, 4000);
        }
        startAutoSlide();
        //When mouseover, Stop Auto Slide
        $('.slide-container').mouseover(function () {
            clearInterval(timer);
        });
        //When mouseleave, Restart Auto Slide
        $('.slide-container').mouseleave(function () {
            startAutoSlide();
        });

        //Btn-slide
        for (var i = 0; i < $('.slide-btn span').length; i++) {
            $('.slide-btn span').eq(i).click(function (e) {
                console.log(e.target.innerHTML);
                var slideNum = e.target.innerHTML;
                goToSlide(slideNum);
            })
        }
    </script>
    
    <div class="purpose container mt-5">
        <div class="text-center">
            <h2>Our Purpose</h2>
            <p>Daily Japanese is for people who want to know about Japan.</p>
        </div>

        <div class="purpose-list row">
            <div class="icon-box col-lg-6 row mt-4 mb-4">
                <div class="col-5 text-right">
                    <i class="fas fa-sticky-note text-center"></i>
                </div>
                <div class="col-7 text-left">
                    <h5>Record</h5>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                </div>
            </div>
            <div class="icon-box col-lg-6 row mt-4 mb-4">
                <div class="col-5 text-right">
                    <i class="fas fa-question text-center"></i>
                </div>
                <div class="col-7 text-left">
                    <h5>Help</h5>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                </div>
            </div>
            <div class="icon-box col-lg-6 row mt-4 mb-4">
                <div class="col-5 text-right">
                    <i class="fas fa-retweet text-center"></i>
                </div>
                <div class="col-7 text-left">
                    <h5>Again</h5>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                </div>
            </div>
            <div class="icon-box col-lg-6 row mt-4 mb-4">
                <div class="col-5 text-right">
                    <i class="fas fa-hands-helping text-center"></i>
                </div>
                <div class="col-7 text-left">
                    <h5>Talk</h5>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                </div>
            </div>
        </div>
    </div>   
    
    <div class="advantage container mt-5 mb-5">
        <div class="text-center">
            <h2>Advantages</h2>
            <p>Why should we learn Japanese of foreign languages ?</p>
        </div>

        <div class="row mt-5">

            <div class="col-lg-4 mb-2">
                <div class="advantage-box">
                    <img src="./img/talk.jpg" class="front" style="width: 100%; margin-bottom: 10px;">
                    <div class="back p-4">
                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Vero laudantium unde, nobis esse reiciendis soluta id laborum tenetur qui,</p>
                    </div>
                </div>
                <h5 style="padding: 10px; text-align:center">Friendship ▲</h5>
            </div>

            <div class="col-lg-4 mb-2">
                <div class="advantage-box">
                    <img src="./img/world.jpg" class="front" style="width: 100%; margin-bottom: 10px;">
                    <div class="back p-4">
                        <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Commodi, harum ipsum! Tenetur expedita asperiores nemo vero possimus ut mollitia,</p>
                    </div>
                </div>
                <h5 style="padding: 10px; text-align:center">Outlook ▲</h5>
            </div>

            <div class="col-lg-4 mb-2">
                <div class="advantage-box">
                    <img src="./img/music.jpg" class="front" style="width: 100%; margin-bottom: 10px;">
                    <div class="back p-4">
                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus ea exercitationem illo voluptate laboriosam tempora sapiente beatae velit tempore sit.</p>
                    </div>
                </div>
                <h5 style="padding: 10px; text-align:center">Culture ▲</h5>
            </div>
        </div>
    </div>
    
     <script type="text/javascript"> 
        //advantage-box, height of width => height
        var advantageHeight = $('.front').outerHeight();
        console.log(advantageHeight);
        $('.advantage-box').css('height', advantageHeight);
    </script>
        

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
		Copyright &copy; 2021 손민빈 All Rights Reserved.
	</footer>

	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>