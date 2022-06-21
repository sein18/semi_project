<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=635a1cbf5d8015b6c619d8b4f941ae4a"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function showTable(station) {
		$('.DesBox').hide();
		$(station).show();
		console.log(station);
		console.log(typeof (station));

		var listlng = new Array();
		var listlat = new Array();
		var listtype = new Array();

		<c:forEach var="list" items="${list}" varStatus="status">
		listlng.push("${list.getLng()}");
		listlat.push("${list.getLat()}");
		listtype.push("${list.getType_num()}");
		</c:forEach>

		if (station == "#seoul") {
			hideMarkers();
			for (var i = 0; i < listlng.length; i++) {

				addMarker(new kakao.maps.LatLng(listlat[i], listlng[i]));
			}

		} else if (station == "#table1") {
			hideMarkers();
			for (var i = 0; i < listlng.length; i++) {
				if (parseInt(listtype[i]) == 1) {
					addMarker(new kakao.maps.LatLng(listlat[i], listlng[i]));
				}
			}
		} else if (station == "#table2") {
			hideMarkers();
			for (var i = 0; i < listlng.length; i++) {
				if (parseInt(listtype[i]) == 2) {
					addMarker(new kakao.maps.LatLng(listlat[i], listlng[i]));
				}
			}
		} else if (station == "#table3") {
			hideMarkers();
			for (var i = 0; i < listlng.length; i++) {
				if (parseInt(listtype[i]) == 3) {
					addMarker(new kakao.maps.LatLng(listlat[i], listlng[i]));
				}
			}
		} else if (station == "#table4") {
			hideMarkers();
			for (var i = 0; i < listlng.length; i++) {
				if (parseInt(listtype[i]) == 4) {
					addMarker(new kakao.maps.LatLng(listlat[i], listlng[i]));
				}
			}
		}
	}

	// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
	var markers = [];

	// 마커를 생성하고 지도위에 표시하는 함수입니다
	function addMarker(position) {

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : position
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 생성된 마커를 배열에 추가합니다
		markers.push(marker);
	}

	// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
	function setMarkers(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map);
		}
	}

	// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
	function showMarkers() {
		setMarkers(map)
	}

	// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
	function hideMarkers() {
		setMarkers(null);
	}
	
	function selectone(lat,lng){
		hideMarkers();
		addMarker(new kakao.maps.LatLng(lat, lng));
	}
</script>

<!-- @!@!@!@STYLE@!@!@!@ -->
<style>
/*
        가장 속의 div가 선택된다.
        */
div {
	font-size: 20px;
	color: white;
}

ul {
	list-style: none;
	padding: 50px;
}

a, a:visited {
	color: #222;
	text-decoration: none;
}

html, body {
	width: 100%;
	height: 100%;
}

.MapBox {
	width: 400px;
	height: 500px;
}

#dogGnb {
	position: relative;
	background: linear-gradient(#141e30, #243b55);
	z-index: 2000;
	width: 100%;
	height: 100%;
}

.DesBox {
	overflow: auto;
	flex-basis: 1000px;
}

#FAVORITE {
	margin-left: -20%;
}

.container {
	position: relative;
	width: 1130px;
	height: 100%;
	margin: 0 auto;
	padding: 0 30px;
	display: flex;
	font-family: sans-serif;
	font-weight: bold;
}

hr {
	height: 30vh;
	width: .5vw;
	border-width: 0;
	color: #000;
	background-color: #000;
}

button, input {
	font-family: sans-serif;
	font-weight: bold;
}

li {
	overflow: hidden;
}
</style>
<!-- @!@!@!@STYLE@!@!@!@ -->


<body>
	<!-- div 1 -->
	<div id="dogGnb" role="navigation">
		<div class="container">
			<h1 id="logo">
				<a href="/">
					<div class="three">Three</div> "Maps API"
				</a>
			</h1>

			<div id="FAVORITE" class="gnbBox">
				<ul class="list_nav type fix">
					<li class="nav_item" onclick="showTable('#seoul')">서울</li>
					<li class="nav_item" onclick="showTable('#table1')">강남</li>
					<li class="nav_item" onclick="showTable('#table2')">강동</li>
					<li class="nav_item" onclick="showTable('#table3')">강북</li>
					<li class="nav_item" onclick="showTable('#table4')">강서</li>
				</ul>
				<button onclick="tableDelete()">명단제거</button>
				<br>
				<form action="/mapmain" method="GET">
					<input type="text" name="hospitalname" placeholder="검색창"> <input
						type="submit" value="검색하기" onclick="showTable('#table5')">
				</form>
			</div>
			<hr>
			<!-- div 2 -->
			<div class="DesBox" id="seoul" style="display: none;">
				<table border="1">
					<c:forEach var="dto" items="${list}">
						<tr>
							<th>병원 이름</th>
							<th>병원 전화번호</th>
							<th>도로명 주소</th>
						</tr>
						<tr>
							<td><a onclick="selectone(${dto.lat},${dto.lng});">${dto.name}</a></td>
							<td>${dto.phone }</td>
							<td>${dto.addr }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="DesBox" id="table1" style="display: none;">
				<table border="1">
					<c:forEach var="dto" items="${list}">
						<c:set var="data" value="${dto.addr}" />
						<c:if test="${fn:contains(data,'강남구') }">
							<tr>
								<th>병원 이름</th>
								<th>병원 전화번호</th>
								<th>도로명 주소</th>
							</tr>
							<tr>
								<td><a onclick="selectone(${dto.lat},${dto.lng});">${dto.name}</a></td>
								<td>${dto.phone }</td>
								<td>${dto.addr }</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
			<div class="DesBox" id="table3" style="display: none;">
				<table border="1">
					<c:forEach var="dto" items="${list}">
						<c:set var="data" value="${dto.addr}" />
						<c:if test="${fn:contains(data,'강북구') }">
							<tr>
								<th>병원 이름</th>
								<th>병원 전화번호</th>
								<th>도로명 주소</th>
							</tr>
							<tr>
								<td><a onclick="selectone(${dto.lat},${dto.lng});">${dto.name}</a></td>
								<td>${dto.phone }</td>
								<td>${dto.addr }</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
			<div class="DesBox" id="table4" style="display: none;">
				<table border="1">
					<c:forEach var="dto" items="${list}">
						<c:set var="data" value="${dto.addr}" />
						<c:if test="${fn:contains(data,'강서구') }">
							<tr>
								<th>병원 이름</th>
								<th>병원 전화번호</th>
								<th>도로명 주소</th>
							</tr>
							<tr>
								<td><a onclick="selectone(${dto.lat},${dto.lng});">${dto.name}</a></td>
								<td>${dto.phone }</td>
								<td>${dto.addr }</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
			<div class="DesBox" id="table2" style="display: none;">
				<table border="1">
					<c:forEach var="dto" items="${list}">
						<c:set var="data" value="${dto.addr}" />
						<c:if test="${fn:contains(data,'강동구') }">
							<tr>
								<th>병원 이름</th>
								<th>병원 전화번호</th>
								<th>도로명 주소</th>
							</tr>
							<tr>
								<td><a onclick="selectone(${dto.lat},${dto.lng});">${dto.name}</a></td>
								<td>${dto.phone }</td>
								<td>${dto.addr }</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
			<div class="DesBox" id="table5" style="display: block;">
				<table border="1">
					<c:forEach var="dto" items="${searchlist}">
						<tr>
							<th>병원 이름</th>
							<th>병원 전화번호</th>
							<th>도로명 주소</th>
						</tr>
						<tr>
							<td><a onclick="selectone(${dto.lat},${dto.lng});">${dto.name}</a></td>
							<td>${dto.phone }</td>
							<td>${dto.addr }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<hr>


			<!-- div 3 -->
			<div id="map" class="MapBox"
				style="margin-top: 50px; margin-right: -400px;; width: 50%; height: 50%;"></div>
			<script type="text/javascript">
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(37.5638532, 126.9740863), // 지도의 중심좌표
					level : 10
				// 지도의 확대 레벨
				};

				// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption);
			</script>

		</div>


	</div>
</body>
</html>