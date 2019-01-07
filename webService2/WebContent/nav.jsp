<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Bootstrap core CSS -->
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<link href="${path}/asset/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="${path}/asset/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${path}/asset/css/creative.css" rel="stylesheet">
<link href="${path}/asset/css/loader.css" rel="stylesheet">

<!-- Plugin CSS -->
<link href="${path}/asset/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand js-scroll-trigger" href="${path}/index.jsp">오작교</a>
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#about">소개</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#services">장소찾기</a></li>

				<c:if test="${sessionScope.user == null}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${path}/user/signUp.jsp">회원가입</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${path}/user/sign.jsp">로그인</a></li>
				</c:if>

				<c:if test="${sessionScope.user != null}">
					<li class="nav-item">
						<div class="dropdown show">
							<a class="btn btn-secondary dropdown-toggle nav-link" id="dropdownMenuLink"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false"> 마이페이지 </a>

							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="${path}/user/addressInsert.go">내 위치 추가</a> <a
									class="dropdown-item" href="${path}/user/setMyAdd.go">즐겨찾기</a> <a
									class="dropdown-item" href="${path}/user/signUp.jsp">회원정보
									수정</a> <a class="dropdown-item" href="${path}/user/userDelete.jsp">회원
									탈퇴</a>
							</div>
						</div>
					</li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${path}/user/signOut.go">${sessionScope.user.name}님 로그아웃</a></li>
				</c:if>

			</ul>
		</div>
	</div>
</nav>
<div id="preloader">
	<div id="loader">
		<div class="line-scale-pulse-out">
			<div></div>
			<div></div>
			<div></div>
			<div></div>
			<div></div>
		</div>
	</div>
</div>

<script src="${path}/asset/js/jquery-3.2.1.min.js"></script>
<script src="${path}/asset/js/loader.js"></script>
<script src="${path}/asset/js/modernizr.js"></script>
<script src="${path}/asset/js/pace.min.js"></script>
<script src="${path}/asset/js/plugins.js"></script>