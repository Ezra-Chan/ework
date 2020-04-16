<div class="bgc-w box box-primary">
	<!--盒子头-->
	<div class="box-header">
		<h3 class="box-title">
			<a href="useredit" class="label label-success" style="padding: 5px;">
				<span class="glyphicon glyphicon-plus"></span> 新增
			</a>
			&nbsp;&nbsp;
			<a href="getLockedUsers" class="label label-success" style="padding: 5px;">
				 查看锁定账户
			</a>
		</h3>
		<div class="box-tools">
			<div class="input-group" style="width: 150px;">
				<input type="text" class="form-control input-sm usersearch"
					placeholder="查找..." />
				<div class="input-group-btn">
					<a class="btn btn-sm btn-default">
						<span class="glyphicon glyphicon-search usersearchgo"></span>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!--盒子身体-->
	<div class="box-body no-padding">
		<div class="table-responsive">
			<table class="table table-hover table-striped">
				<tr>
					<th scope="col">&nbsp;</th>
					<th scope="col">部门</th>
					<th scope="col">真实姓名</th>
					<th scope="col">用户名</th>
					<th scope="col">角色</th>
					<th scope="col">职位</th>
					<th scope="col">电话</th>
					<th scope="col">工资</th>
					<th scope="col">操作</th>
				</tr>
				<#list users as user>
					<tr>
						<td>
							<#if user.imgPath?? && user.imgPath!=''  >
								<img style="width: 25px;height: 25px;"
									class="profile-user-img img-responsive img-circle"
									src="/image/${user.imgPath}" />
								<#else>
								<img style="width: 25px;height: 25px;"
									class="profile-user-img img-responsive img-circle"
									src="images/timg.jpg" alt="images"/>
							</#if>
						</td>
						<td><span>${(user.dept.deptName)!''}</span></td>
						<td><span>${(user.realName)!''}</span></td>
						<td><span>${(user.userName)!''}</span></td>
						<td><span>${(user.role.roleName)!''}</span></td>
						<td><span>${(user.position.name)!''}</span></td>
						<td><span>${(user.userTel)!''}</span></td>
						<td><span>${(user.salary)!''}</span></td>
						<td>
							<a href="useredit?userid=${user.userId}" class="label xiugai">
								<span class="glyphicon glyphicon-edit"></span> 修改
							</a>
							<a onclick="{return confirm('删除该记录将锁定该账户，确定删除吗？');};"
							   href="deleteuser?userid=${user.userId}" class="label shanchu">
								<span class="glyphicon glyphicon-remove"></span> 删除
							</a>
						</td>
					</tr>
				
				</#list>
				
			</table>
		</div>
	</div>
	<!--盒子尾-->
	<#include "/common/paging.ftl"/>
</div>
