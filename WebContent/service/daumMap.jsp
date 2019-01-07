<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <link href="${pageContext.request.contextPath}/asset/css/creative.css" rel="stylesheet">  --%>
<head>

</head>
<script>
	var customOverlay;
	var summariesJson;
	var subwayJson;
	var busJson;
	var busAndSubwayJson;
	
	var points = [];
	
	function getRoute() {
		var start = $("#start").val();
		var arrive = $("#arrive").val();

		$.ajax({
			method : 'POST',
			url : "geo.go?start=" + start + "&arrive=" + arrive,
			traditional : true,
			
			success : function(data) {
				// 넘겨온 데이터를 쪼개기 위함.
				var total_str = data.split('/');
				
				summariesJson = JSON.parse(total_str[0]);
				subwayJson = JSON.parse(total_str[1]);
				busJson = JSON.parse(total_str[2]);
				busAndSubwayJson = JSON.parse(total_str[3]);
				
				console.log(subwayJson);
				console.log(busJson);
				console.log(busAndSubwayJson);
				
				// 키워드로 장소를 검색합니다.
				searchPlaces();
			},
			error : function(request, status, error) {
				alert(error);
			}
		});
	}
	
	function setPosition (name, lat, lng){
		var result ;
		
		result = { title : name, latlng : new Daum.maps.LatLng(lat,lng) };
		
		return result;
	}
</script>
	<div class="container">
		<div class="col-lg-12 text-center">
			<div class="map_wrap">
			
				<div id="map"
					style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

				<div id="menu_wrap" class="bg_white">
					<div class="option">
						<div>
							<form onsubmit="searchPlaces(); return false;">
								<input type="text" value="이태원 맛집" id="keyword" size="15"
									style="border-radius: 0px" hidden="true">
							</form>
						</div>
					</div>
					
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
			</div>
			<form class="daumMapForm">
				<input type="text" id="start" name="start" readonly="readonly"
					placeholder="출발지를 드래그 해주세요."> <input type="text"
					id="arrive" name="arrive" readonly="readonly"
					placeholder="도착지를 드래그 해주세요."> <input type="button"
					value="검색" id="search" onclick="getRoute();">
			</form>
		</div>
	</div>

<!-- Custom scripts for map -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f2f2e20edcea3241be825db9a7fdd43b&libraries=services"></script>

<script>
	var markers = [];
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new daum.maps.LatLng(37.56623844640287, 126.97805818016076),
		level : 5
	// 지도의 확대 레벨
	};
	
	// 가운데 찍히는 마커가 저장될곳.
	var seoulM;
	
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	var startSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
	startSize = new daum.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
	startOption = {
		offset : new daum.maps.Point(15, 43)
	// 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};

	// 출발 마커 이미지를 생성합니다
	var startImage = new daum.maps.MarkerImage(startSrc, startSize, startOption);

	var startDragSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_drag.png', // 출발 마커의 드래그 이미지 주소입니다    
	startDragSize = new daum.maps.Size(50, 64), // 출발 마커의 드래그 이미지 크기입니다 
	startDragOption = {
		offset : new daum.maps.Point(15, 54)
	// 출발 마커의 드래그 이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};

	// 출발 마커의 드래그 이미지를 생성합니다
	var startDragImage = new daum.maps.MarkerImage(startDragSrc, startDragSize,
			startDragOption);

	// 출발 마커가 표시될 위치입니다 
	var startPosition = new daum.maps.LatLng(37.565805120730666,
			126.97389295116301);

	// 출발 마커를 생성합니다
	var startMarker = new daum.maps.Marker({
		map : map, // 출발 마커가 지도 위에 표시되도록 설정합니다
		position : startPosition,
		draggable : true, // 출발 마커가 드래그 가능하도록 설정합니다
		image : startImage
	// 출발 마커이미지를 설정합니다
	}), infowindow = new daum.maps.InfoWindow({
		zindex : 1
	});

	// 출발 마커에 dragstart 이벤트를 등록합니다
	daum.maps.event.addListener(startMarker, 'dragstart', function() {
		// 출발 마커의 드래그가 시작될 때 마커 이미지를 변경합니다
		startMarker.setImage(startDragImage);
	});

	var geocoder = new daum.maps.services.Geocoder();
	// 출발 마커에 dragend 이벤트를 등록합니다
	daum.maps.event.addListener(startMarker, 'dragend', function() {
		// 출발 마커의 드래그가 종료될 때 마커 이미지를 원래 이미지로 변경합니다
		startMarker.setImage(startImage);

		var latlng = startMarker.getPosition();

		var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		message += '경도는 ' + latlng.getLng() + ' 입니다';

		var resultDiv = document.getElementById('start');

		var coord = startMarker.getPosition();
		var callback = function(result, status) {
			if (status === daum.maps.services.Status.OK) {
				resultDiv.value = result[0].address.address_name + ","
						+ latlng.getLat() + "," + latlng.getLng();
				resultDiv.innerHTML = result[0].address.address_name + ","
						+ latlng.getLat() + "," + latlng.getLng();
			}
		};
		geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);

		//		resultDiv.value = re + "," + latlng.getLat() + "," + latlng.getLng();
		resultDiv.innerHTML = resultDiv.value;
		//		resultDiv.innerHTML = message;
	});

	var arriveSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
	arriveSize = new daum.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
	arriveOption = {
		offset : new daum.maps.Point(15, 43)
	// 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};

	// 도착 마커 이미지를 생성합니다
	var arriveImage = new daum.maps.MarkerImage(arriveSrc, arriveSize,
			arriveOption);

	var arriveDragSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_drag.png', // 도착 마커의 드래그 이미지 주소입니다    
	arriveDragSize = new daum.maps.Size(50, 64), // 도착 마커의 드래그 이미지 크기입니다 
	arriveDragOption = {
		offset : new daum.maps.Point(15, 54)
	// 도착 마커의 드래그 이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};

	// 도착 마커의 드래그 이미지를 생성합니다
	var arriveDragImage = new daum.maps.MarkerImage(arriveDragSrc,
			arriveDragSize, arriveDragOption);

	// 도착 마커가 표시될 위치입니다 
	var arrivePosition = new daum.maps.LatLng(37.5636444367528,
			126.98331076006214);

	// 도착 마커를 생성합니다 
	var arriveMarker = new daum.maps.Marker({
		map : map, // 도착 마커가 지도 위에 표시되도록 설정합니다
		position : arrivePosition,
		draggable : true, // 도착 마커가 드래그 가능하도록 설정합니다
		image : arriveImage
	// 도착 마커이미지를 설정합니다
	}), infowindowArrive = new daum.maps.InfoWindow({
		zindex : 1
	});

	// 도착 마커에 dragstart 이벤트를 등록합니다
	daum.maps.event.addListener(arriveMarker, 'dragstart', function() {
		// 도착 마커의 드래그가 시작될 때 마커 이미지를 변경합니다
		arriveMarker.setImage(arriveDragImage);
	});

	// 도착 마커에 dragend 이벤트를 등록합니다
	daum.maps.event.addListener(arriveMarker, 'dragend', function() {
		// 도착 마커의 드래그가 종료될 때 마커 이미지를 원래 이미지로 변경합니다
		arriveMarker.setImage(arriveImage);

		var latlng = arriveMarker.getPosition();

		var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		message += '경도는 ' + latlng.getLng() + ' 입니다';

		var resultDiv = document.getElementById('arrive');
		var coord = arriveMarker.getPosition();
		var callback = function(result, status) {
			if (status === daum.maps.services.Status.OK) {
				resultDiv.value = result[0].address.address_name + ","
						+ latlng.getLat() + "," + latlng.getLng();
				resultDiv.innerHTML = result[0].address.address_name + ","
						+ latlng.getLat() + "," + latlng.getLng();
			}
		};
		geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
		//		resultDiv.value = latlng.getLat()+","+latlng.getLng();
		//		resultDiv.innerHTML = resultDiv.value;
		//		resultDiv.innerHTML = message;
	});

	function searchAddrFromCoords(coords, callback) {
		// 좌표로 행정동 주소 정보를 요청합니다
		geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
	}

	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 법정동 상세 주소 정보를 요청합니다
		geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}

	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayCenterInfo(result, status) {
		if (status === daum.maps.services.Status.OK) {
			var infoDiv = document.getElementById('centerAddr');

			for (var i = 0; i < result.length; i++) {
				// 행정동의 region_type 값은 'H' 이므로
				if (result[i].region_type === 'H') {
					infoDiv.innerHTML = result[i].address_name;
					break;
				}
			}
		}
	}
	// 수정부분

	var ps = new daum.maps.services.Places();

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new daum.maps.InfoWindow({
		zIndex : 1
	});
	
	function searchPlaces() {
		var keyword = document.getElementById('keyword').value;

		if (!keyword.replace(/^\s+|\s+$/g, '')) {
			alert('키워드를 입력해주세요!');
			return false;
		}

		// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		ps.keywordSearch(keyword, placesSearchCB);
	}
	
	// result, status, pagination
	function placesSearchCB(data, status, pagination) {
		if (status === daum.maps.services.Status.OK) {

			// 정상적으로 검색이 완료됐으면
			// 검색 목록과 마커를 표출합니다
			displayPlaces(data);

			// 페이지 번호를 표출합니다
			displayPagination(pagination);

		} else if (status === daum.maps.services.Status.ZERO_RESULT) {
			alert('검색 결과가 존재하지 않습니다.');
			return;
		} else if (status === daum.maps.services.Status.ERROR) {
			alert('검색 결과 중 오류가 발생했습니다.');
			return;
		}
	}

	
	
	function displayPlaces(places) {
		// 정렬된 ranking 별 지나오는 점들을 보관하기 위한 변수
		
		var listEl = document.getElementById('placesList'),
			menuEl = document.getElementById('menu_wrap'), 
			fragment = document.createDocumentFragment(),
			bounds = new daum.maps.LatLngBounds(), listStr = '';

		// 검색 결과 목록에 추가된 항목들을 제거합니다
		removeAllChildNods(listEl);
		// Json으로 파싱.
		var summariesJsonCount = 0;

		for (key in summariesJson) {
			var routeJson = summariesJson[key][0];
			var summaryJson = summariesJson[key][0]['summaries'];
			var itemEl = getListItem(key, routeJson, summaryJson); // 검색 결과 항목 Element를 생성합니다
	
			fragment.appendChild(itemEl);
		}
		
		removeMarker();
		
		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;

		var midPosition = new daum.maps.LatLng( (startMarker.getPosition().getLat()+arriveMarker.getPosition().getLat() ) / 2,
				(startMarker.getPosition().getLng()+arriveMarker.getPosition().getLng() ) / 2 );
		
		var points = [
			startMarker.getPosition(),
			arriveMarker.getPosition(),
		    midPosition
		];
		
		seoulM = new daum.maps.Marker({
			map : map, // 출발 마커가 지도 위에 표시되도록 설정합니다
			position : midPosition,
			draggable : true, // 출발 마커가 드래그 가능하도록 설정합니다
			opacity : 1,
		}), infowindow = new daum.maps.InfoWindow({
			zindex : 1
		});
		
		for (i = 0; i < points.length; i++) {
		    bounds.extend(points[i]);
		}
		markers.push(seoulM);
		// bounds.extend(seoulPosition);
		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		map.setBounds(bounds);
	}
	
	// 오버레이를 끄기위한 메소드

	
	// 커스텀 오버레이에 들어갈 내용
	// close를 구현해야함.
	function getCustomOverlay(position){
		var content = '<div class="overlaybox">' +
	    '    <div class="boxtitle">' +
		'		<div class="title boxtitle_main"> 금주 영화순위 </div>' +
	    '		<div class="close boxtitle_main" onclick="closeOverlay()" title="닫기"></div>' +
	    '	 </div>' +
	    '    <div class="first">' +
	    '        <div class="triangle text">1</div>' +
	    '        <div class="movietitle text">드래곤 길들이기2</div>' +
	    '    </div>' +
	    '    <ul>' +
	    '        <li class="up">' +
	    '            <span class="number">2</span>' +
	    '            <span class="title">명량</span>' +
	    '            <span class="arrow up"></span>' +
	    '            <span class="count">2</span>' +
	    '        </li>' +
	    '        <li>' +
	    '            <span class="number">3</span>' +
	    '            <span class="title">해적(바다로 간 산적)</span>' +
	    '            <span class="arrow up"></span>' +
	    '            <span class="count">6</span>' +
	    '        </li>' +
	    '        <li>' +
	    '            <span class="number">4</span>' +
	    '            <span class="title">해무</span>' +
	    '            <span class="arrow up"></span>' +
	    '            <span class="count">3</span>' +
	    '        </li>' +
	    '        <li>' +
	    '            <span class="number">5</span>' +
	    '            <span class="title">안녕, 헤이즐</span>' +
	    '            <span class="arrow down"></span>' +
	    '            <span class="count">1</span>' +
	    '        </li>' +
	    '    </ul>' +
	    '</div>';
		
		var customOverlay = new daum.maps.CustomOverlay({
		    position: position,
		    content: content,
		    xAnchor: 0.3,
		    yAnchor: 0.91
		});
		
		return customOverlay;
	}
	
	// 지도 위에 마커를 표시하는 함수.
	function setMarkOnMap(positions){
		for (let i = 0; i < positions.length; i ++) {
			var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new daum.maps.Size(12, 17); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
		    
		    var marker = new daum.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        image : markerImage, // 마커 이미지
		        clickable : true
		    });
		    // 기존 마커에 넣기.
		    markers.push(marker);
		    
		    // 커스텀 오버레이
		    daum.maps.event.addListener(marker, 'click', function(mouseEvent) {
		    	// 전역으로 빼놨음
		    	if(customOverlay != null)
		    		customOverlay.setMap(null);
		    	
		    	customOverlay = getCustomOverlay(positions[i].latlng);
				customOverlay.setMap(map);
		  		
		    });
		}
	}
	
	function ranking_click(index){
		var jsonObj ;
		var points = []; 
		
		for(key in busJson)
			if(index == key) jsonObj = busJson[key];
		for(key in subwayJson)
			if(index == key) jsonObj = subwayJson[key];
		for(key in busAndSubwayJson)
			if(index == key) jsonObj = busAndSubwayJson[key];
		
		for(var i = 0 ;i<jsonObj.length ; i++) {
			
			// 도보 경로
			if(jsonObj[i]['information'] != null){
				points.push({		
					title : jsonObj[i]['information']+"(시작지점)",
					latlng : new daum.maps.LatLng(jsonObj[i]['s_lng'],jsonObj[i]['s_lat'])
				});
				points.push({
					title : jsonObj[i]['information']+"(끝지점)",
					latlng : new daum.maps.LatLng(jsonObj[i]['e_lng'],jsonObj[i]['e_lat'])
				});
			} else {
				points.push({
					title :	jsonObj[i]['stationName'],
					latlng : new daum.maps.LatLng(jsonObj[i]['longitude'],jsonObj[i]['latitude'])
				});
			}
		}
		console.log(points);
		removeMarker();
		setMarkOnMap(points);
	}
	
	function getListItem(index, routeJson, summaryJson) {
		var el = document.createElement('li');
		
		// routeJson 만 조작
		var itemStr = '<span class="markerbg marker_' + (index) + '"></span>'
				+ '<div class="info" onclick="ranking_click('+index+');">' + '   <h5>총 시간'
				+ routeJson['route_time'] + '</h5>' + '   <h5>걷는 시간'
				+ routeJson['walking_time'] + '</h5>' + '   <h5>환승 회수'
				+ routeJson['transfers'] + '</h5>';

		// summaries 만 조작.
		for (var i = 0; i < summaryJson.length; i++) {
			itemStr += '  <span class="tel">' + summaryJson[i]['startName']
					+ '</span>' + '  <span class="tel">'
					+ summaryJson[i]['endName'] + '</span>'
					+ '  <span class="tel">' + summaryJson[i]['VehiclesName']
					+ '</span>';
		}
		itemStr += '</div>';
		el.innerHTML = itemStr;
		el.className = 'item';

		return el;
	}

	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
		var paginationEl = document.getElementById('pagination'), fragment = document
				.createDocumentFragment(), i;

		// 기존에 추가된 페이지번호를 삭제합니다
		while (paginationEl.hasChildNodes()) {
			paginationEl.removeChild(paginationEl.lastChild);
		}

		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;

			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}

			fragment.appendChild(el);
		}
		paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	
	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}
</script>