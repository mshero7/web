<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<link href="${path}/asset/css/creative.css" rel="stylesheet">
<link href="${path}/asset/css/sign.css" rel="stylesheet">

<!-- Bootstrap core CSS -->
<link href="${path}/asset/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="${path}/asset/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- source codepen.io -->
<link
	href="https://cdn.jsdelivr.net/foundation/6.2.0/foundation.min.css"
	rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

<!-- Plugin CSS -->
<link href="${path}/asset/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">
<script src="${path}/asset/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
	function redirect() {
		window.location.href = '${path}/index.jsp';
	}
	// 비밀번호 미입력시 경고창
	function checkValue() {
		if (!document.userDelete.password.value) {
			alert("비밀번호를 입력하지 않았습니다.");
			return false;
		}
	}
	var isSame = '';
	$(function() {
		var password = $('#password');
		password.blur(function() {
			var url = "IdCheckForm.go?password="
					+ document.getElementById('password').value;
			$.post(url, function(data, status) {
				if (status == "success") {
					isSame = data;
					console.log(isSame.length)
					if (isSame.length == 6) {
						$('#pwCheck').val("회원탈퇴가 가능합니다.");
						$("#exit").prop("disabled", false);
					} else {
						$('#pwCheck').val("비밀번호를 잘못 입력하셨습니다.");
						password.val('');
						$("#exit").prop("disabled", true);
					}
				}
			});
		});
	});
</script>

</head>
<body>
	<jsp:include page="../nav.jsp"></jsp:include>
	<div id="my_container container">
		<form name="userDelete" method="post" action="userDelete.go"
			onsubmit="return checkValue()">
			<div class="row signRow info">
				<div
					class="wrapper large-5 columns large-centered small-7 small-centered">
					<div class="row header">
						<div class="large-12 columns">회원 탈퇴 하시겠습니까?</div>
					</div>
					<div class="row username">
						<div class="large-9 columns large-centered">
							<label for="password"><i class="fa fa-lock"></i></label> <input
								id="password" type="password" name="password"
								placeholder="비밀번호를 확인해주세요..." required autocomplete="off" />
						</div>
					</div>
					<div class="row password">
						<div class="large-9 columns large-centered">
							<input type="text" id="pwCheck" maxlength="50"
								readonly="readonly" placeholder="비밀번호 확인 결과">
						</div>
					</div>
					<div class="row submit" id="btnOn">
						<div class="large-9 columns large-centered btnTwo">
							<input type="button" value="취소" onclick="redirect()"> <input
								type="submit" id="exit" value="탈퇴" disabled="disabled"
								onsubmit="return true" />
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
	<script src="${path}/asset/js/creative.js"></script>
	
	<!-- sourceURL=pen.js -->
	<script
		src='https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.0/TweenMax.min.js'></script>
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	<script
		src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script>
	<!-- Custom scripts for this template -->
	<script src="${path}/asset/js/loginPop.js"></script>
	<script src="${path}/asset/js/login.js"></script>
</body>
</html>