<#include "/common/commoncss.ftl">
<style type="text/css">
a {
	color: black;
}

a:hover {
	text-decoration: none;
}

.bgc-w {
	background-color: #fff;
}
</style>
<div class="row" style="padding-top: 10px;">
	<div class="col-md-2">
		<h1 style="font-size: 24px; margin: 0;" class="">用户管理</h1>
	</div>
</div>
<div class="row" style="padding-top: 15px;">
	<div class="col-md-12">
		<!--id="container"-->
		<div class="bgc-w box">
			<!--盒子头-->
			<form action="useredit" method="post" onsubmit="return check();">
				<div class="box-header">
					<h3 class="box-title">
						<a href="javascript:history.back();" class="label label-default" style="padding: 5px;">
							<i class="glyphicon glyphicon-chevron-left"></i> <span>返回</span>
						</a>
					</h3>
				</div>
				<!--盒子身体-->
				<div class="box-body no-padding">
					<div class="box-body">
						<div class="alert alert-danger alert-dismissable" role="alert" style="display: none;">
							错误信息:<button class="close thisclose" type="button">&times;</button>
							<span class="error-mess"></span>
						</div>
						<div class="row">
							<#if where??>
								<div class="col-md-6 form-group">
									<label class="control-label"><span>用户名</span></label>
									<input name="userName" readonly="readonly" class="form-control" value="${(user.userName)!''}"/>
								</div>
							<#else>
								<div class="col-md-6 form-group">
									<label class="control-label"><span>用户名</span></label>
									<input name="userName" class="form-control usernameonliy" value="${(user.userName)!''}"/>
									<input type="hidden" class="usernameonliyvalue" value=""/>
								</div>
							</#if>
							
							<div class="col-md-6 form-group">
								<label class="control-label"><span>电话</span></label>
								<input name="userTel" class="form-control" value="${(user.userTel)!''}"/>
							</div>
							<#if where??>
								<div class="col-md-6 form-group">
									<label class="control-label"><span>真实姓名</span></label>
									<input name="realName" readonly="readonly" class="form-control" value="${(user.realName)!''}"/>
								</div>
							<#else>
								<div class="col-md-6 form-group">
									<label class="control-label"><span>真实姓名</span></label>
									<input name="realName" class="form-control" value="${(user.realName)!''}"/>
								</div>
							</#if>

							<div class="col-md-6 form-group">
								<label class="control-label"><span>地址</span></label>
								<input name="address" class="form-control" value="${(user.address)!''}"/>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"><span>学历</span></label>
								<input name="userEdu" class="form-control" value="${(user.userEdu)!''}"/>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"><span>毕业院校</span></label>
								<input name="school" class="form-control" value="${(user.school)!''}"/>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"><span>身份证号</span></label>
								<input name="idCard" class="form-control" id="idC" value="${(user.idCard)!''}"/>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"><span>银行账号</span></label>
								<input name="bank" class="form-control" value="${(user.bank)!''}"/>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"> <span>部门</span></label> 
								<select class="deptselect form-control" name="deptid">
									<#if user??>
										<option value="${(user.dept.deptId)!''}">${user.dept.deptName}</option>
									</#if>
									<#list depts as dept>
										<option value="${dept.deptId}">${dept.deptName}</option>
									</#list>
								</select>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"> <span>性别</span></label>
								<select class="form-control" name="sex" value="${(user.sex)!''}">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"> <span>职位</span></label> 
								<select class="positionselect form-control" name="positionid">
									<#if user??>
										<option value="${(user.position.id)!''}">${user.position.name}</option>
									</#if>
									<#list positions as position>
										<option value="${position.id}">${position.name}</option>
									</#list>
								</select>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"> <span>角色</span></label>
								<select class="form-control" name="roleid">
									<#if user??>
										<option value="${(user.role.roleId)!''}">${user.role.roleName}</option>
									</#if>
									<#list roles as role>
										<option value="${role.roleId}">${role.roleName}</option>
									</#list>
								</select>
							</div>
							<div class="col-md-6 form-group">
								<label class="control-label"><span>工资</span></label>
								<input name="salary" class="form-control" value="${(user.salary)!''}"/>
							</div>

							<#if where??>
							<#else>
								<div class="col-md-6 form-group">
									<span> <label class="control-label">入职时间</label>
									</span> <input name="hireTime" class="form-control" id="start" onclick="WdatePicker()"
										value="${(user.hireTime)!''}"/>
								</div>
							</#if>
							<!-- <div class="col-md-6 form-group">
								<label class="control-label">生日</label> <input
									name="birth" class="form-control" id="start" onclick="WdatePicker()" value="${(user.birth)!''}"/>
							</div> -->
							<div class="col-md-6 form-group">
								<label class="control-label"> <span>皮肤</span></label>
								<select class="form-control" name="themeSkin" value="${(user.themeSkin)!''}">
									<option value="blue">经典蓝</option>
									<option value="green">清新绿绿</option>
									<option value="red">中国红</option>
									<option value="yellow">正气黄</option>
								</select>
							</div>
							<input type="hidden" name="userId" value="${(user.userId)!''}"/>
							<input name="birth" type="hidden" id="birthday" class="form-control" readonly="readonly" style="background-color:#fff;"/>
						</div>
	
						<!--判断一下 请求参数的值  进行显示-->
						<#if where??>
							<div class="row">
								<hr />

								<div class="col-md-6">
									<label class="control-label"><span>重置密码</span></label> <br>
									<span class="labels"><label><input name="isbackpassword" type="checkbox"><i>✓</i></label></span>
								</div>
							</div>
						</#if>
					</div>
				</div>
				<!--盒子尾-->
				<div class="box-footer">
					<input class="btn btn-primary" id="save" type="submit" value="保存" />
					<input class="btn btn-default" id="cancel" type="button" value="取消" onclick="window.history.back();" />
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="plugins/My97DatePicker/WdatePicker.js"></script>
<#include "/common/modalTip.ftl"/> 
<script type="text/javascript">
	$(function () {
		getBirth();
		/* 从身份证号当中截取出生年月 */
		function getBirth(){
			if($.trim($("#idC").val()) != "") {
				var date = "";
				if($("#idC").val().length == 15) {
					date =  '19'+$("#idC").val().substr(6,2)+'-'+$("#idC").val().substr(8,2)+'-'+$("#idC").val().substr(10,2);
				} else if ($("#idC").val().length == 18) {
					date =  $("#idC").val().substr(6,4)+'-'+$("#idC").val().substr(10,2)+'-'+$("#idC").val().substr(12,2);
				}
				$("#birthday").val(date);
			}
		}
		$("#idC").blur(function(){getBirth();});
	})

$(".usernameonliy").on("blur",function(){
	$.post("useronlyname",{"username":$(this).val()},function(data){
		$(".usernameonliyvalue").val(data);
	});
}); 
$(".usernameonliy").focus(function(){
	$(this).parent().removeClass("has-error has-feedback");
	$('.alert-danger').css('display', 'none');
});


/* if(index == 0){
	var $username = $(this).val();
	
	$.ajax(url:"useronlyname",{"username",$username},success:function(data){
		if(!data){
			$(".usernameonliy").parent().addClass("has-error has-feedback");
				alertCheck("用户名已存在");
				isRight = 0;
	 			return false;
		}
	});
	
} */

$(".deptselect").on("change",function(){
	//alert("部门选择变化");
	var selectdeptid = $(this).val();
	
	$.post("selectdept",{selectdeptid:selectdeptid},function(data){
		$(".positionselect").empty();
		$.each(data,function(i,item){
			var potion = $("<option value="+item.id+">"+item.name+"</option>");
			$(".positionselect").append(potion);
		});
	});
	
});

function alertCheck(errorMess){
	
	$('.alert-danger').css('display', 'block');
	// 提示框的错误信息显示
	$('.error-mess').text(errorMess);
	
}
//表单提交前执行的onsubmit()方法；返回false时，执行相应的提示信息；返回true就提交表单到后台校验与执行
function check() {
	//提示框可能在提交之前是block状态，所以在这之前要设置成none
	$('.alert-danger').css('display', 'none');
	var isRight = 1;
	$('.form-control').each(function(index) {
		// 如果在这些input框中，判断是否能够为空
		if ($(this).val() == "") {
			// 获取到input框的兄弟的文本信息，并对应提醒；
			var brother = $(this).siblings('.control-label').text();
			var errorMess = "[" + brother + "输入框信息不能为空]";
			// 对齐设置错误信息提醒；红色边框
			$(this).parent().addClass("has-error has-feedback");
			$('.alert-danger').css('display', 'block');
			// 提示框的错误信息显示
			$('.error-mess').text(errorMess);
			// 模态框的错误信息显示
			$('.modal-error-mess').text(errorMess);
			isRight = 0;
			return false;
		} else {
			if(index == 0){
				var aaa= $(".usernameonliyvalue").val();
				if(aaa=="false"){
					$(this).parent().addClass("has-error has-feedback");
 					alertCheck("用户名已存在");
 					isRight = 0;
 		 			return false;
				}
			}
			if(index == 1){
				var $tel = $(this).val();
				if(isPhoneNo($tel) == false){
					$(this).parent().addClass("has-error has-feedback");
 					alertCheck("手机格式错误");
 					isRight = 0;
 		 			return false;
				}
			}

			if(index == 6){
				var $idcard = $(this).val();
				
				if(isCardNo($idcard) == false){
					$(this).parent().addClass("has-error has-feedback");
 					alertCheck("错误身份证");
 					isRight = 0;
 		 			return false;
				}
			}
			if(index == 7){
				var $bank = $(this).val();
 				if(CheckBankNo($bank) == false){
 					$(this).parent().addClass("has-error has-feedback");
 					isRight = 0;
 		 			return false;
 				}
			}
			// 在这个里面进行其他的判断；不为空的错误信息提醒
			return true;
		}
	});
	if (isRight == 0) {
		//modalShow(0);
		 return false;
	} else if (isRight == 1) {
		//modalShow(1);
		 return true;
	}
//	return false;
}

// 验证手机号
function isPhoneNo(phone) { 
 var pattern = /^1[34578]\d{9}$/; 
 return pattern.test(phone); 
}
 
// 验证身份证 
function isCardNo(card) { 
 var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
 return pattern.test(card); 
} 

//验证卡号
function CheckBankNo(bankn) {
	var flag=true;
	 if(isNaN(bankn)) {
		 alertCheck("银行卡号必须全为数字!");
	     flag=false;
	   }
	
	var bankno = $.trim(bankn);
  　　if(bankno.length < 16 || bankno.length > 19) {
	 alertCheck("银行卡号长度必须在16到19之间!");
     flag=false;
   }
  
   //开头6位
   var strBin = "10,18,30,35,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,60,62,65,68,69,84,87,88,94,95,98,99";
   if(strBin.indexOf(bankno.substring(0, 2)) == -1) {
	 alertCheck("银行卡号开头6位不符合规范!");
	 flag=false;
   }
   
   return flag;
}
</script>