<link rel="stylesheet" type="text/css" href="css/sharemess.css" />
<div class="box-header">
	<h3 class="box-title">共享与我</h3>
	<a class="btn btn-sm btn-default thisrefresh" href="javascript:void(0);" title="刷新" style="padding: 5px;margin-top: -8px;">
		<span class="glyphicon glyphicon-refresh"></span>
	</a>
	<div class="box-tools">
		<div class="input-group" style="width: 150px;">
			<input type="text" class="form-control input-sm searchbaseKey" placeholder="查找..." value="${(baseKey)!''}"/>
			<div class="input-group-btn">
				<a class="btn btn-sm btn-default searchbaseKeySumbit"> 
					<span class="glyphicon glyphicon-search"></span>
				</a>
			</div>
		</div>
	</div>
</div>
<div class="thissharemess" style="margin-bottom:20px;">
	<#if dus?size gt 0>
	<#list dus as du>
	<div class="sharemess">
		<p>${du.sharetime}</p>
		<div class="sharecontent">
			<div>
				<div class="sharecontent-left">
					<div class="share-top">
						<a href="javascript:void(0);" 
						class="usershow"
						title="${du.shareuser.realName}"
						thisdept="${du.shareuser.dept.deptName}"
						thisrole="${du.shareuser.role.roleName}"
						thistel="${(du.shareuser.userTel)!'空的'}"
						>
							<#if du.shareuser.imgPath?? && du.shareuser.imgPath!=''  >
								<img class="img-circle" src="/image/${du.shareuser.imgPath}"/>
							<#else>
								<img class="img-circle" src="images/timg.jpg" alt="images"/>
							</#if>
							<span> ${du.shareuser.realName}</span></a>共享了以下联系人给你:
					</div>
					<div class="share-bottom">
						<a href="javascript:void(0);" 
						class="othershow"
						title="${du.director.userName}" 
						thistel="${du.director.phoneNumber}" 
						thissex="${du.director.sex}" 
						thiscompany="${(du.director.companyname)!'空的'}" style="margin-left: 100px;">
							<#if du.director.imgPath?? && du.director.imgPath!=''  >
								<img class="img-circle" src="/image/${du.director.imgPath}"/>
							<#else>
								<img class="img-circle" src="images/timg.jpg" alt="images"/>
							</#if>
<#--							<img src="/image/${(du.director.imagePath)!'timg.jpg'}" class="img-circle" /> -->
							${du.director.userName}
						</a>,${du.director.phoneNumber}
					</div>
				</div>
				<div class="share-right">
					<div class="share-choose">
						<div class="pull-right">
							<span> 选择分类： </span> 
							<#if du.handle==false>
								<select name="" class="form-control thishandleselect">
							<#else>
								<select name="" class="form-control" disabled>
								<#if du.catalogName?? & du.catalogName!=''>
									<option value="${du.catalogName}">${du.catalogName}</option>
								<#else>
									<option value=" ">外部通讯录</option>
								</#if>
							</#if>
							<option value="">外部通讯录</option>
							<#list catalogs as ca>
								<option value="${ca}">${ca}</option>
							</#list>
							</select>
						</div>
					</div>
					<div class="share-button">
						<#if du.handle==false>
							<button class="btn btn-primary nothandle" duid="${du.directorUserId}">确定</button>
						<#else>
							<button class="btn btn-primary" style="background: #ccc;border:none;" disabled>已处理</button>
						</#if>
					</div>
				</div>
			</div>
		</div>
	</div>
	</#list>
	<#else>
	<table class="table table-hover table-striped">
		<tr>
			<td colspan="7" style="text-align: center;background: #eee;">没能找到相关消息~~~</td>
		</tr>
	</table>
</#if>
</div>
<#include "/common/paging.ftl"/>
<script>
/* 未处理的共享联系人的controller */
$('.nothandle').on('click',function(){
	var catalog=$(this).parents('.share-right').find('.thishandleselect').val();
	var duid=$(this).attr('duid');
	$('.thistable').load('sharemess',{catalog:catalog,duid:duid},function(){
		modalShow(1);	
	});
	var count=parseInt($('.showcount').text())-1;
	if($('.nothandle').length>1){
		var count=parseInt($('.showcount').text())-1;
		$('.showcount').text(count);
	}else{
		$('.showcount').text("");
	}
	
})
/* 模糊查询 */
$('.searchbaseKeySumbit').on('click', function() {
	var baseKey = $('.searchbaseKey').val();
	$('.thistable').load('${url}?baseKey='+baseKey+'${(catalog)!''}');
});
</script>
<script type="text/javascript" src="js/usershow.js"></script>