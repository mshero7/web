<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>시작 페이지</title>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!-- Bootstrap core CSS -->
<link href="${path}/asset/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="${path}/asset/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${path}/asset/css/creative.css" rel="stylesheet">

<!-- Plugin CSS -->
<link href="${path}/asset/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">
<link href="${path}/asset/css/sign.css" rel="stylesheet">
<!-- source codepen.io -->
<link
	href="https://cdn.jsdelivr.net/foundation/6.2.0/foundation.min.css"
	rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">
<script type="text/javascript">
	// 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
	function checkValue() {
		if (!document.userInfo.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}

		if (!document.userInfo.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}

		// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인

		/* alert(document.userInfo.password.value);
		alert(document.userInfo.password_repeat.value); */

		if (document.userInfo.password.value != document.userInfo.password_repeat.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}

	// 취소 버튼 클릭시 로그인 화면으로 이동
	function redirect() {
		window.location.href = '${path}/index.jsp';
	}
</script>

</head>
<body id="page-top">

	<jsp:include page="../nav.jsp"></jsp:include>

	<div id="my_container">
		<form method="post" action="userUpdate.go" name="userInfo"
			id="userInfo" class="signUp" onsubmit="return checkValue();"
			autocomplete="off">
			<div class="row signRow signUpColor">
				<div
					class="wrapper large-5 columns large-centered small-7 small-centered">
					<div class="row header">
						<div class="large-12 columns">회원정보 수정</div>
					</div>
					<!-- 아이디 -->
					<div class="row username">
						<div class="large-9 columns large-centered">
							<label for="username"><i class="fa fa-user"></i></label> <input
								id="id" type="text" name="id" value="${user.id }" required
								autocomplete="off" readonly="readonly" />
						</div>
					</div>
					<!-- 비밀번호 -->
					<div class="row password">
						<div class="large-9 columns large-centered">
							<label for="password"><i class="fa fa-lock"></i></label> <input
								id="password" type="password" name="password"
								value="${user.password }" required autocomplete="off"
								placeholder="새로운 비밀번호를 입력하세요." />
						</div>
					</div>
					<!-- 비밀번호 재입력 -->
					<div class="row password">
						<div class="large-9 columns large-centered">
							<label for="password_repeat"><i class="fa fa-lock"></i></label> <input
								id="password_repeat" type="password" name="password_repeat"
								value="${user.password }" placeholder="새로운 비밀번호를 다시 입력하세요."
								required autocomplete="off" />
						</div>
					</div>
					<!-- 이름 -->
					<div class="row password">
						<div class="large-9 columns large-centered">
							<label for="name"><i class="fa font">이름</i></label> <input
								id="name" type="text" name="name" value="${user.name }" required
								autocomplete="off" />
						</div>
					</div>
					<!-- 이메일 -->
					<div class="row password">
						<div class="large-9 columns large-centered">
							<label for="email"><i class="fa font">이메일</i></label> <input
								id="email" type="email" name="email" value="${user.email }"
								required autocomplete="off" style="padding-right: 5%;" />
						</div>
					</div>
					<!-- 성별 -->
					<div class="row password">
						<div class="large-9 columns large-centered"
							style="padding-left: 5%;">
							<label for="gender"></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성별:
							<div style="display: inline; margin-left: 20%">
								<input class="gender" type="radio" name="gender" value="M" checked>
								남<input class="gender" type="radio" name="gender" value="F"
									style="margin-left: 20%"> 여
							</div>
						</div>
					</div>
					<!-- 생년월일 -->
					<div class="row password">
						<div class="large-9 columns large-centered">
							<label for="birthday"><i class="fa "></i></label> <input
								id="birthday" type="date" name="birthday"
								value="${user.birthday }" required autocomplete="off" />
						</div>
					</div>
					<!-- 내정보기억하기 -->
					<div class="row password">
						<div class="large-9 columns large-centered"
							style="padding-left: 5%;">
							<label for="userinfo"><i class="fa "></i></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;내 정보 저장: <input
								type="checkbox" placeholder="내 정보 기억하기" 
								autocomplete="off" style="margin-left: 8%" />
						</div>
					</div>
					<!-- 회원가입 -->
					<div class="row submit">
						<div class="large-9 columns large-centered btnTwo">
							<input type="button" value="CANCEL" onclick="redirect()">
							<input type="submit" value="SAVE">
						</div>
					</div>	
				</div>
			</div>
		</form>
	</div>

	<script src="${path}/asset/vendor/jquery/jquery.min.js"></script>
	<script src="${path}/asset/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${path}/asset/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="${path}/asset/vendor/scrollreveal/scrollreveal.min.js"></script>
	<script
		src="${path}/asset/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${path}/asset/js/creative.min.js"></script>
	<!-- sourceURL=pen.js -->
	<script
		src='https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.0/TweenMax.min.js'></script>
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	<script
		src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script>
	<!-- Custom scripts for this template -->
	<script src="${path}/asset/js/loginPop.js"></script>
	
</body>

</html>