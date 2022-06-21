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
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
	function setMapType(maptype) { 
	    var roadmapControl = document.getElementById('btnRoadmap');
	    var skyviewControl = document.getElementById('btnSkyview'); 
	    if (maptype === 'roadmap') {
	        map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);    
	        roadmapControl.className = 'selected_btn';
	        skyviewControl.className = 'btn';
	    } else {
	        map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);    
	        skyviewControl.className = 'selected_btn';
	        roadmapControl.className = 'btn';
	    }
	}

	// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomIn() {
	    map.setLevel(map.getLevel() - 1);
	}

	// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomOut() {
	    map.setLevel(map.getLevel() + 1);
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
html, body {width:100%;height:100%;margin:0;padding:0;} 
.map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:130px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}       
.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
.custom_typecontrol .selected_btn:hover {color:#fff;}   
.custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5;} 
.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}     
.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}             
.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;}     
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
			<div class="map_wrap">
				<div id="map"
					style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
				<!-- 지도타입 컨트롤 div 입니다 -->
				<div class="custom_typecontrol radius_border">
					<span id="btnRoadmap" class="selected_btn"
						onclick="setMapType('roadmap')">지도</span> <span id="btnSkyview"
						class="btn" onclick="setMapType('skyview')">스카이뷰</span>
				</div>
				<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
				<div class="custom_zoomcontrol radius_border">
					<span onclick="zoomIn()"><img
						src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
						alt="확대"></span> <span onclick="zoomOut()"><img
						src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
						alt="축소"></span>
				</div>
			</div>
			
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