<!DOCTYPE html>
<html >
<head>
	<meta charset="UTF-8">
	<link href="images/logo.ico" rel="icon" type="image/x-icon"/>
	<link href="images/logo.ico" rel="shortcut icon" type="image/x-icon"/>
	<title>e-work信息化办公管理系统</title>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="css/login.css">
	<style>
		.login {
			width: 100%;
			height: 100%;
			background: url('images/background.png') no-repeat center center;
			background-size: 101% 122%;
			display: flex;
			position: relative;
			overflow: hidden;
		}
	</style>
</head>
<body>
<div class="app">
	<div class="login">
		<div class="header">
			<img src="images/Logo.png" alt="logo" class="logo">
			<h1 class="title">
				e-work信息化办公管理系统
			</h1>
		</div>
		<div class="loginModule">
			<div class="alert alert-danger alert-dismissible errorMessage"  role="alert">
				错误信息: <span class="error-mess"></span>
				<button type="button" class="close" data-dismiss="alert" aria-label="Close" style="right:0px;"><span aria-hidden="true">&times;</span></button>
			</div>
			<h2 class="loginTitle">登 录</h2>
			<div class="loginStyle">
				<div class="accountLogin">
					<a href="##" class="accountPassword">账号密码登录</a>
				</div>
				<div class="divider"></div>
				<div class="faceRecognitionLogin">
					<a href="#" class="faceRecognition">人脸识别登录</a>
				</div>
			</div>
			<div class="thisTable">
				<#include "/login/account.ftl">
			</div>
		</div>
		<div class="centerBgc">
			<img class="cityBgc" src="images/cityBgc.png" alt="">
			<img class="bgcImg" src="images/bgcImg.png" alt="">
		</div>
	</div>
</div>
<div class="modal fade in" id="mymodal" data-backdrop="static" >
	<div class="modal-dialog" style="top: 20%;">
		<div class="modal-content">
			<div class="modal-body modal-error">
				<div class="icon">
					<span class="glyphicon">!</span>
				</div>
				<div class="modal-p">
					<!--<h2 style="text-align: center;">提示信息</h2>-->
					<p class="modal-error-mess">该用户已经登录了，是否继续 ？</p>
					<div class="modal-p">
						<button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>
						<button type="button" class="btn btn-primary contiue" data-dismiss="modal">继续</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<#if hasmess??>
	<script type="text/javascript">
		$(function(){
			$('#mymodal').modal('show');
		})
	</script>
</#if>
<#if errormess??>
	<script>
		$(function(){
			$('.error-mess').text('${errormess}');
			$('.alert-danger').css('display','block');
		})
	</script>
</#if>
<script type="text/javascript">
	$('.test').on('click',function(){
		$(this).css('border',"1px solid transparent");
	})
	$('.contiue').on('click',function(){
		location.href="/handlehas";
	})

	/*账号密码登录点击事件*/
	$(function () {
		$('.thisTable').on('click','accountLogin',function () {
			$('.thisTable').load('accountLogin');
		})
	})
	$('.accountPassword').on('click',function () {
		$('.thisTable').load('accountLogin');
	})

	/*人脸识别登录点击事件*/
	$(function () {
		$('.thisTable').on('click','faceRecognitionLogin',function () {
			$('.thisTable').load('faceRecognitionLogin');
		})
	})
	$('.faceRecognition').on('click',function () {
		$('.thisTable').load('faceRecognitionLogin');
	})

	function check() {
		var userName=$('.userName').val().trim();
		var password=$('.password').val().trim();
		var code=$('.code').val().trim();
		var count=1;
		if(userName==null || userName==""){
			$('.error-mess').text("登录账号不能为空!");
			$('.alert-danger').css('display','block');
			$('.userName').css('border-color',"#a94442");
			count=0;
			return false;
		}
		if(password==null || password==""){
			$('.error-mess').text("登录密码不能为空!");
			$('.alert-danger').css('display','block');
			$('.password').css('border-color',"#a94442");
			count=0;
			return false;
		}
		if(code==null || code==""){
			$('.error-mess').text("验证码不能为空!");
			$('.alert-danger').css('display','block');
			$('.code').css('border-color',"#a94442");
			count=0;
			return false;
		}
		console.log(count);
		return true;
	}
</script>
</body>
</html>