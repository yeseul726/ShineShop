<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<style>
div {
	margin: 25px;
}

p {
	position: absolute;
	width: 100px;
	height: 100px;
	background: transparent;
	background-image: url(image/heart.png);
	background-size: 100px;
	animation: 3s myanim;
	-webkit-animation-name: heart_bounce;
	-webkit-animation-iteration-count: infinite;
	-webkit-animation-iteration-duration: 1s;
	-webkit-animation-timing-function: ease;
	z-index: 999;
}

@keyframes heart_bounce {
            from,
            to {
                bottom: 150px;
                -webkit-animation-timing-function: ease-out;
            }
            0% {
                bottom: 150px;
            }
            50% {
                bottom: 450px;
                -webkit-animation-timing-function: ease-in;
            }
            100% {
                bottom: 150px;
            }
        }
</style>
</head>

<body>
	<div>
		<ul class="sub_menu">
			<%
					if (application.getAttribute("user_id") == null) {
			%>
			<li><a href="login.jsp" target="a">LOGIN</a></li>
			<li><a href="cart.jsp" target="a">CART</a></li>
			<li><a href="mypage.jsp" target="a">MY PAGE</a></li>
			<li><a href="qna.jsp" target="a">QNA</a></li>
			<%
 			} else {
 				if(((String)application.getAttribute("user_id")).equals("shineshopadmin")) {
		 			%>
					<li><a href="logout.jsp" target="a">LOGOUT</a></li>
					<li><a href="memberProc.jsp" target="a">회원관리</a></li>
					<li><a href="itemUploadList.jsp" target="a">상품관리</a></li>
					<li><a href="qna.jsp" target="a">QNA</a></li>
					<%
 				} else {
 			%>
			<li><a href="logout.jsp" target="a">LOGOUT</a></li>
			<li><a href="cart.jsp" target="a">CART</a></li>
			<li><a href="mypage.jsp" target="a">MY PAGE</a></li>
			<li><a href="qna.jsp" target="a">QNA</a></li>
			<%
 				}
 			}
			%>
		</ul>
	</div>
	<header>
		<h1>
			<a href="index.jsp">Shine Shop</a>
		</h1>
	</header>
	<nav>
		<ul>
			<li><a href="itemList.jsp?kind=necklace" target="a">NECKLACE</a></li>
			<li><a href="itemList.jsp?kind=earring" target="a">EARRING</a></li>
			<li><a href="itemList.jsp?kind=ring" target="a">RING</a></li>
			<li><a href="itemList.jsp?kind=watch" target="a">WATCH</a></li>
			<li><a href="itemList.jsp?kind=wallet" target="a">WALLET</a></li>
		</ul>
	</nav>
	<section>
		<article>
			<iframe width="100%" height="100%" name="a" src="indexProc.jsp">
				<img src="image/banner1.png" alt="">
			</iframe>
		</article>
		<p style="left: 150px;"></p>
		<p style="right: 150px;"></p>
	</section>
	<footer>
		<br>서울특별시 관악구 호암로 546<br>
		<br> 이메일 : <a href="mailto:yeseul726@e-mirim.hs.kr"
			style="text-decoration: none; color: white;">yeseul726@e-mirim.hs.kr</a><br>
		작성자 : 이예슬
	</footer>
	<!--<audio src="#" autoplay controls></audio>-->
</body>
</html>