<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=key"></script>

<body>

<div id="map" style="width:500px;height:400px;"></div>
 
<script>
		
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		var icon = new kakao.maps.MarkerImage(
		        'https://i1.daumcdn.net/dmaps/apis/n_local_blit_04.png',
		        new kakao.maps.Size(31, 35));
</script>
<img width="31" height="35" src="https://i1.daumcdn.net/dmaps/apis/n_local_blit_04.png" alt="">
</body>
</html>