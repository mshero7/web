<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>주소 추가 페이지</title>
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
<link href="${path}/asset/css/autoComplete.css" rel="stylesheet">


<script src="${path}/asset/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
	// 추가 버튼 클릭시 주소 추가
	var index = 1;
	$(function(){
		var id = $('#pac-input');
		var btn = $('#pac-input-btn');
		id.blur(function(){
			if(document.getElementById("pac-input").value == '')
				btn.prop("disabled", true);
			else
				btn.prop("disabled", false);
		});
		btn.click(function() {
				btn.prop("disabled", true);
		})
	});
	function erase(eraseNo, eraseBtn) {
		var number = eraseNo.substr(5);
		index = index - 1;
		if (number == index) {
			document.getElementById("addElmt").removeChild(
					document.getElementById("addNo" + number));
			document.getElementById("addElmt").removeChild(
					document.getElementById("eraseBtn" + number));
		} else {
			document.getElementById("addNo" + index).setAttribute("name",
					"addNo" + number);
			document.getElementById("addNo" + number).setAttribute("name",
					"addNo" + index);
			document.getElementById("eraseBtn" + index).setAttribute("name",
					"eraseBtn" + number);
			document.getElementById("eraseBtn" + number).setAttribute("name",
					"eraseBtn" + index);
			document.getElementsByName("addNo" + number).item(0).setAttribute(
					"id", "addNo" + number);
			document.getElementsByName("addNo" + index).item(0).setAttribute(
					"id", "addNo" + index);
			document.getElementsByName("eraseBtn" + number).item(0)
					.setAttribute("id", "eraseBtn" + number);
			document.getElementsByName("eraseBtn" + index).item(0)
					.setAttribute("id", "eraseBtn" + index);
			document.getElementById("eraseBtn" + number).setAttribute(
					"onclick",
					"erase('addNo" + number + "', 'eraseBtn" + number + "')")

			document.getElementById("addElmt").removeChild(
					document.getElementById("addNo" + index));
			document.getElementById("addElmt").removeChild(
					document.getElementById("eraseBtn" + index));
		}
	}
	function addElmt() {
		if (document.getElementById("addNo" + index) == null) {
			var div = document.createElement("div");
			div.setAttribute("class", "pac-card");
			div.setAttribute("id", "pac-card");
			var inputText = document.createElement("input");
			var eraseBtn = document.createElement("input");
			inputText.setAttribute("id", "addNo" + index);
			inputText.setAttribute("type", "text");
// 			inputText.placeholder = "Enter a location";
			inputText.value = document.getElementById("pac-input").value;
			document.getElementById("pac-input").value = '';
			inputText.setAttribute("name", "addNo" + index);
			inputText.setAttribute("class", "addInput pac-input");;
			inputText.setAttribute("style", "padding-left: 4% !important");
			document.getElementById("addElmt").appendChild(inputText);

			eraseBtn.value = "-";
			eraseBtn.setAttribute("type", "button");
			eraseBtn.setAttribute("id", "eraseBtn" + index);
			eraseBtn.setAttribute("class", "addBtn");
			eraseBtn.setAttribute("onclick", "erase('addNo" + index
					+ "', 'eraseBtn" + index + "')");
			document.getElementById("addElmt").appendChild(eraseBtn);
			index = Number(index) + 1;
		} else {
			index = Number(index) + 1;
			addElmt();
		}
	}
	// 취소 버튼 클릭시 로그인 화면으로 이동
	function redirect() {
		window.location.href = '${path}/index.jsp';
	}
</script>
</head>
<body>
	<jsp:include page="../nav.jsp"></jsp:include>

	<div id="my_container">
		<form method="post" action="addressInsert.go" name="address"
			class="address" autocomplete="off">
			<div class="row signRow signUpColor addMargin">
				<div
					class="wrapper large-5 columns large-centered small-7 small-centered">
					<div class="row header">
						<div class="large-12 columns">나의 주소 입력</div>
					</div>

					<!-- 주소 -->
					<div class="row username">
						<div class="large-9 columns large-centered" id="addElmt">
							<label for="address"><i class="fa font"> 주소 검색</i></label>
							<div class="pac-card" id="pac-card">
								<input id="pac-input" type="text" placeholder="Enter a location">
								<input type="button" value="+" onclick="addElmt()"
									class="addBtn" disabled="disabled" id="pac-input-btn">
							</div>
						</div>
					</div>
					<div id="map"></div>

					<!-- 저장하기 -->
					<br>
					<div class="row submit">
						<div class="large-9 columns large-centered btnTwo">
							<input type="button" value="CANCEL" onclick="redirect()">
							<input type="submit" value="SAVE">
						</div>
					</div>
					<br>
				</div>
			</div>
		</form>
	</div>
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

	<!-- Custom scripts for this template -->
	<script>
		document.addEventListener('keydown', function(event) {
			if (event.keyCode === 13) {
				event.preventDefault();
			}
		}, true);

		function initMap() {
			var map = new google.maps.Map(document.getElementById('map'), {
				center : {
					lat : -33.8688,
					lng : 151.2195
				},
				zoom : 13
			});
			var card = document.getElementById('pac-card');
			var input = document.getElementById('pac-input');

			map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

			var autocomplete = new google.maps.places.Autocomplete(input);

			autocomplete.bindTo('bounds', map);

			autocomplete.setFields([ 'address_components', 'geometry', 'icon',
					'name' ]);
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAoFRsAM0v-T1zPcKrUL4SPy-jCNo62vUA&libraries=places&callback=initMap"
		async defer></script>


</body>
</html>