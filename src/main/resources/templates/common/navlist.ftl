<div class="col-md-12 green" >
	<!--导航栏左侧-->
	<div class="current-time" style="display: inline-block; text-align: center; font-size: 20px; height: 50px;line-height:50px; color: #fff;"></div>
	<!--右侧导航栏-->
	<ul class="nav navbar-nav navbar-right moredeep">
		<li>
			<a href="javascript:changepath('/infromlist');" class="green-none white">
				<span class="glyphicon glyphicon-bell"></span>
				<#if notice==0>
					<span class="badge blue-badge badge-notice"></span>
				<#else>
					<span class="badge blue-badge badge-notice">${(notice)!''}</span>
				</#if>
			</a>
		</li>

		<li><a href="javascript:changepath('/mytask');" class="green-none white"><span
				class="glyphicon glyphicon-flag"></span>
				<#if task==0>
					<span class="badge red-badge"></span>
				<#else>
					<span class="badge red-badge">${(task)!''}</span>
				</#if>
				</a>
		</li>
		<li class="dropdown">
		<!--设置导航栏头像面板--> 
		<a href="#" class="green-none white" data-toggle="dropdown">
			<#--用户头像-->
			<#if user.imgPath?? && user.imgPath!=''  >
			<#--如果用户上传过头像，则显示用户自己的头像-->
				<img class="user-image"
					 src="/image/${user.imgPath}" />
			<#else>
			<#--如果用户没有上传过头像，则显示默认头像-->
				<img class="user-image"
					 src="images/timg.jpg" alt="images"/>
			</#if>
			<span>${user.userName}</span>
		</a> <!--设置点击按钮弹出用户面板层-->
			<ul class="dropdown-menu" style="padding:0;">
				<li class="user-header green">
					<#--用户头像-->
					<#if user.imgPath?? && user.imgPath!=''  >
					<#--如果用户上传过头像，则显示用户自己的头像-->
						<img class="img-circle" src="/image/${user.imgPath}" style="width: 100px;height:100px;" alt="images" />
					<#else>
					<#--如果用户没有上传过头像，则显示默认头像-->
						<img class="img-circle" src="images/timg.jpg" style="width: 100px;height:100px;" alt="images"/>
					</#if>
					<p class="white" style="">
						<span>${user.dept.deptName} </span> / <span> ${user.role.roleName}</span><br> <small>${user.position.name}</small>
					</p></li>
				<li class="user-footer">
					<div class="pull-left">
						<a href="javascript:changepath('userpanel');" class="btn btn-default">用户面板</a>
					</div>
					<div class="pull-right">
						<a href="loginout" class="btn btn-danger">退出登录</a>
					</div>
				</li>
			</ul>
		</li>

<#--		<li style="position: relative;">-->
<#--			<a  id="history" class="green-none white" data-toggle="dropdown">-->
<#--				<span class="glyphicon glyphicon-time"></span>-->
<#--			</a>-->
<#--			<ul id="historypanel" class="dropdown-menu" style="position: absolute; background-color: #222d32;">-->
<#--				<#include "/user/userlog.ftl"/>-->
<#--			</ul>-->
<#--		</li>-->
</ul>
</div>
<script>

	//从右往左滑动效果
	$(function() {
		var num = 1;
		$("#history").click(function() {
			num++;
			if (num % 2 == 0) {
				$("#historypanel").css({ //从右边飞入，使用绝对定位来操作 
					"width" : "230px",
					"right" : "-230px"
				}).show().animate({
					"right" : "0"
				}, "fast");
			} else
				$("#historypanel").animate({
					"width" : "toggle"
				}, "slow");
			$('#historypanel').load('/userlogs');

		})
		/*获取当前时间并显示在导航栏  */
		var day = new Date();
		var week = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
		var s = day.getFullYear() + "年" + (day.getMonth()+1) + "月" + day.getDate() + "日," + week[day.getDay()];
		$(".current-time").text(s);
	})
</script>