<#include "/common/commoncss.ftl">
<#include "/common/modalTip.ftl"/> 
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
		<h1 style="font-size: 24px; margin: 0;" class="">部门管理</h1>
	</div>
</div>
<div class="row" style="padding-top: 15px;">
	<div class="col-md-12">
		<!--id="container"-->
		<div class="bgc-w box box-primary">
			<!--盒子头-->
			<div class="box-header">
				<h3 class="box-title">
					<a href="deptedit" class="label label-success" style="padding: 5px;">
						<span class="glyphicon glyphicon-plus"></span> 新增
					</a>
				</h3>
			</div>
			<!--盒子身体-->
			<div class="box-body no-padding">
				<div class="table-responsive">
					<table class="table table-hover table-striped">
						<tr>
							<th scope="col">名称</th>
							<th scope="col">电话</th>
							<th scope="col">传真</th>
							<th scope="col">地址</th>
							<th scope="col">操作</th>
						</tr>
						<#list depts as dept>
							<tr>
								<td><span>${dept.deptName}</span></td>
								<td><span>${dept.deptTel}</span></td>
								<td><span>${(dept.deptFax)!''}</span></td>
								<td><span>${dept.deptAddr}</span></td>
								<td>
									<a href="deptedit?dept=${dept.deptId}" class="label xiugai">
									<span class="glyphicon glyphicon-edit"></span> 修改</a> 
									<a href="readdept?deptid=${dept.deptId}" class="label xiugai">
										<span class="glyphicon glyphicon-search"></span> 人事调动
									</a>
									<a href="readdept?deptid=${dept.deptId}" class="label shanchu">
										<span class="glyphicon glyphicon-remove"></span> 删除
									</a>
								</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
