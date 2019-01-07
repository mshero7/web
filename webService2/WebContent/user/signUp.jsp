<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>시작 페이지</title>
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
</head>
<body id="page-top">

	<jsp:include page="../nav.jsp"></jsp:include>

	<c:if test="${user == null}">
		<div id="my_container">
			<form method="post" action="signUp.go" name="userInfo" class="signUp"
				onsubmit="return _repeatValue();" autocomplete="off">
				<div class="row signRow signUpColor">
					<div
						class="wrapper large-5 columns large-centered small-7 small-centered">
						<div class="row header">
							<div class="large-12 columns">SIGN UP!</div>
						</div>
						<!-- 아이디 -->
						<div class="row username">
							<div class="large-9 columns large-centered">
								<label for="username"><i class="fa fa-user"></i></label> <input
									id="id" type="text" name="id" placeholder="아이디를 입력하세요."
									required autocomplete="off" /> <input type="text" id="idCheck"
									placeholder="아이디 중복체크" readonly="readonly"> <input
									type="hidden" name="idDuplication" value="idUncheck">
							</div>
						</div>
						<!-- 비밀번호 -->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="password"><i class="fa fa-lock"></i></label> <input
									id="password" type="password" name="password"
									placeholder="비밀번호를 입력하세요." required autocomplete="off" />
							</div>
						</div>
						<!-- 비밀번호 재입력 -->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="password-repeat"><i class="fa fa-lock"></i></label>
								<input id="password_repeat" type="password"
									name="password_repeat" placeholder="비밀번호를 다시 입력하세요." required
									autocomplete="off" />
							</div>
						</div>
						<!-- 이름 -->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="name"><i class="fa font">이름</i></label> <input
									id="name" type="text" name="name" placeholder="이름을 입력하세요."
									required autocomplete="off" />
							</div>
						</div>
						<!-- 이메일 -->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="email"><i class="fa font">이메일</i></label> <input
									id="email" type="email" name="email" placeholder="이메일을 입력하세요."
									required autocomplete="off" style="padding-right: 5%;" />
							</div>
						</div>
						<!-- 성별 -->
						<div class="row password">
							<div class="large-9 columns large-centered"
								style="padding-left: 5%;">
								<label for="gender"></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성별:
								<div style="display: inline; margin-left: 20%">
									<input class="gender" type="radio" name="gender" value="M"
										checked> 남<input class="gender" type="radio"
										name="gender" value="F" style="margin-left: 20%"> 여
								</div>
							</div>
						</div>
						<!-- 생년월일 -->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="birthday"><i class="fa font">생년월일</i></label> <input
									id="birthday" type="date" name="birthday" required
									autocomplete="off" />
							</div>
						</div>
						<!-- 짝꿍입력-->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="partner"><i class="fa font">짝꿍</i></label> <input
									id="partner" type="text" name="partner"
									placeholder="짝꿍의 id를 입력하세요." autocomplete="off" /><input
									type="text" id="partnerCheck" placeholder="짝꿍을 입력하지 않았습니다."
									readonly="readonly">
							</div>
						</div>
						<!-- 회원가입 -->
						<br>
						<div class="row submit">
							<div class="large-9 columns large-centered btnTwo">
								<input type="button" value="CANCEL" onclick="redirect()">
								<input type="submit" value="JOIN">
							</div>
						</div>
						<br>
					</div>
				</div>
			</form>
		</div>
	</c:if>
	<c:if test="${user != null}">
		<div id="my_container">
			<form method="get" action="signUp.go" name="userInfo" id="userInfo"
				class="signUp" onsubmit="return checkValue();" autocomplete="off">
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
								<label for="password_repeat"><i class="fa fa-lock"></i></label>
								<input id="password_repeat" type="password"
									name="password_repeat" value="${user.password }"
									placeholder="새로운 비밀번호를 다시 입력하세요." required autocomplete="off" />
							</div>
						</div>
						<!-- 이름 -->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="name"><i class="fa font">이름</i></label> <input
									id="name" type="text" name="name" value="${user.name }"
									required autocomplete="off" />
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
									<input class="gender" type="radio" name="gender" value="M"
										checked> 남<input class="gender" type="radio"
										name="gender" value="F" style="margin-left: 20%"> 여
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
						<!-- 짝꿍입력-->
						<div class="row password">
							<div class="large-9 columns large-centered">
								<label for="partner"><i class="fa font">짝꿍</i></label> <input
									id="partner" type="text" name="partner"
									value="${user.partner }" autocomplete="off" />
								<c:if test="${fn:length(user.partner) == 0}">
									<input type="text" id="partnerCheck"
										placeholder="짝꿍을 입력하지 않았습니다." readonly="readonly">
								</c:if>
								<c:if test="${fn:length(user.partner) != 0}">
									<input type="text" id="partnerCheck" placeholder="유효한 짝꿍입니다."
										readonly="readonly">
								</c:if>
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
	</c:if>
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
	<script type="text/javascript">
		// 취소 버튼 클릭시 로그인 화면으로 이동
		function redirect() {
			window.location.href = '${path}/index.jsp';
		}
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
	</script>
	<!-- Custom scripts for this template -->
	<script type="text/javascript">
		// 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
		function _repeatValue() {
			if (!document.userInfo.id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}

			if (!document.userInfo.password.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}

			// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
			if (document.userInfo.password.value != document.userInfo.password_repeat.value) {
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}

			if (!document.userInfo.name.value) {
				alert("이름을 입력하세요.");
				return false;
			}
		}

		function goLoginForm() {
			location.href = "login.jsp";
		}
		var isNew = '';
		$(function() {
			var id = $('#id');
			id.blur(function() {
				var url = "IdCheckForm.go?id="
						+ document.getElementById('id').value;
				$.get(url, function(data, status) {
					if (status == "success") {
						isNew = data;
						if (isNew.length == 6)
							$('#idCheck').val("사용가능한 아이디입니다.");
						else {
							$('#idCheck').val("사용불가능한 아이디입니다.");
							id.val('');
						}
					}
				});
			});
		});
		$(function() {
			var partner = $('#partner');
			partner.blur(function() {
				if (document.getElementById('partner').value.length == 0) {
					document.getElementById("partnerCheck").setAttribute(
							"placeholder", "짝꿍을 입력하지 않았습니다.");
					$('#partnerCheck').val('');
					return;
				}
				var url = "IdCheckForm.go?id="
						+ document.getElementById('partner').value;
				// 				console.log( "value:" + document.getElementById('partner').value + " length: " + document.getElementById('partner').value.length);
				$.get(url, function(data, status) {
					if (status == "success") {
						if (data.length == 7)
							$('#partnerCheck').val("유효한 짝궁입니다.");
						else {
							$('#partnerCheck').val("존재하지 않는 짝궁입니다.");
							partner.val('');
						}
					}
				});
			});
		});
	</script>

</body>

</html>