<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="visitorBook.VisitorBookDAO" %>
<%@ page import="visitorBook.VisitorBookDTO" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
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
	request.setCharacterEncoding("UTF-8");
	String orderType ="최신순";
	String searchType="제목";
	String search = "";
	int pageNumber = 0;
	if (request.getParameter("orderType") != null) {
		orderType =request.getParameter("orderType");
	}
	if (request.getParameter("searchType") != null) {
		searchType =request.getParameter("searchType");
	}
	if (request.getParameter("search") != null) {
		search =request.getParameter("search");
	}
	if (request.getParameter("pageNumber") != null) {
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("Error of pageNumber");
		}
		
	}
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

	<section class="container" style="padding-top:100px;">
		<form action="./visitorBook.jsp" method="get" class="form-inline mt-3">
			<select name="orderType" class="form-control mx-1 mt-3">
				 <option value="최신순" <% if(orderType.equals("최신순")) out.println("selected"); %>>최신순</option>
				 <option value="추천순" <% if(orderType.equals("추천순")) out.println("selected"); %>>추천순</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-3">
				 <option value="제목" <% if(searchType.equals("제목")) out.println("selected"); %>>제목</option>
				 <option value="내용" <% if(searchType.equals("내용")) out.println("selected"); %>>내용</option>
				 <option value="제목+내용" <% if(searchType.equals("제목+내용")) out.println("selected"); %>>제목+내용</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-3" placeholder="Search" value = '<% if(!search.equals("")) out.println(search);%>'  />
			<button type="submit" class="btn btn-primary mx-1 mt-3">Search</button>
			<div class="mx-3">
				<a class="btn btn-primary mt-3" data-toggle="modal" href="#visitorBookRegisterModal">Register</a>
				<a class="btn btn-danger mt-3" data-toggle="modal" href="#visitorBookReportModal">Report</a>
			</div>
		</form>
		
<%
	ArrayList<VisitorBookDTO> visitorBookList = new ArrayList<VisitorBookDTO>();
	visitorBookList = new VisitorBookDAO().getList(orderType, searchType, search, pageNumber);
	if (visitorBookList != null) 
		for (int i = 0; i < visitorBookList.size(); i++) {
			if ( i == 5) break;
			VisitorBookDTO visitorBook = visitorBookList.get(i);
%>
		<div class="card bg-light mt-3">
			<div class="card-header">
				<div class="row">
					<div class="col-7 text-left"><%=visitorBook.getVisitorBookTitle() %></div>
					<div class="col-5 text-right">ID : <%=visitorBook.getUserID() %> <small>(<%=visitorBook.getCreated() %>)</small></div>
				</div>
			</div>
			<div class="card-body">
				<p class="card-text"><%=visitorBook.getVisitorBookContent() %></p>
				<div class="text-right">
					<a onclick="return confirm('추천하시겠습니까?')" href="./visitorBookLikeAction.jsp?visitorBookID=<%=visitorBook.getVisitorBookID()%>">추천(<%=visitorBook.getLikeCount() %>)</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="./visitorBookDeleteAction.jsp?visitorBookID=<%=visitorBook.getVisitorBookID()%>">삭제</a>
				</div>
			</div>
		</div>
<%
		}
%>
	</section>
	
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
			if (pageNumber <= 0) {
%>
			<a class="page-link disabled">Pre</a>
<%
			} else {
%>
			<a class="page-link" href="./visitorBook.jsp?searchType=<%= URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=<%= pageNumber-1 %>">Pre</a>
<%
			}
%>			
		</li>
		<li class="page-item">
<%
			if (visitorBookList.size() < 6) {
%>
			<a class="page-link disabled">Next</a>
<%
			} else {
%>
			<a class="page-link" href="./visitorBook.jsp?searchType=<%= URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=<%= pageNumber+1 %>">Next</a>
<%
			}
%>			
		</li>
	</ul>
	
	<div class="modal fade" id="visitorBookRegisterModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Register</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./visitorBookRegisterAction.jsp" method="post">
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="visitorBookTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea name="visitorBookContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Register</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="visitorBookReportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Report</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./visitorBookReportAction.jsp" method="post">
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="visitorBookReportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea name="visitorBookReportContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-danger">Send</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
		Copyright &copy; 2021 손민빈 All Rights Reserved.
	</footer>

	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>