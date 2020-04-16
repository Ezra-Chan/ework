<style type="text/css">
	.table>tbody>tr>td{
		padding: 15px;
	}
	.table{
		border: 0;
	}
</style>
<fieldset id="">
	<legend style="padding-left:5%;">基本信息</legend>
	<table class="table" border=""  style="width: 90%;margin: auto;margin-bottom: 20px;">
		<tr>
			<td class="text-right"  >姓名:</td>
			<td >	${d.userName}</td>
			<td rowspan="3" colspan="2">
				<div id="">
					<#if (imgpath)?? && (imgpath)!=''  >
						<img class="img-circle" src="/image/${(imgpath)}" style="width: 120px;height: 120px;border-radius: 50%;margin-left: 15%;"/>
					<#else>
						<img class="img-circle" src="images/timg.jpg" style="width: 120px;height: 120px;border-radius: 50%;margin-left: 15%;"/>
					</#if>
<#--					<img src="/image/${(imgpath)!'/timg.jpg'}" style="width: 120px;height: 120px;border-radius: 50%;margin-left: 15%;"/>-->
				</div>
			</td>
		</tr>
		<tr>
			<td class="text-right" >性别:</td>
			<td>	${(d.sex)!'空的'}</td>
		</tr>
		<tr>
			<td class="text-right" >电话:</td>
			<td>${(d.phoneNumber)!'空的'}</td>
		</tr>	
		<tr>
			<td class="text-right" width="15%">创建人:</td>
			<td class="text-left" width="35%" >
				<a style="color: #337ab7;" href="javascript:void(0);" class="usershow"
						title="${d.myuser.realName}"
						thisdept="${d.myuser.dept.deptName}" 
						thisrole="${d.myuser.role.roleName}" 
						thistel="${(d.myuser.userTel)!'空的'}"
						>${d.myuser.realName}</a>
			</td>
		</tr>
		<tr>
			<td class="text-right" >公司:</td>
			<td>${(d.companyname)!'空的'}</td>
			<td class="text-right">公司号码:</td>
			<td class="text-left">${(d.companyNumber)!''}</td>
		</tr>
		<tr>
			<td class="text-right">住址:</td>
			<td colspan="3">${(d.address)!'空的'}</td>
		</tr>
		<tr>
			<td class="text-right">备注:</td>
			<td colspan="3">${(d.remark)!'空的'}</td>
		</tr>
	</table>
	<div class="box-footer" style="padding-left:5%;">
		<a href="javascript:void(0);" class="label label-default returnoutaddress" style="padding: 5px;"> <i class="glyphicon glyphicon-chevron-left"></i> <span>返回</span>
		</a>
	</div>
</fieldset>
<script type="text/javascript" src="js/usershow.js"></script>