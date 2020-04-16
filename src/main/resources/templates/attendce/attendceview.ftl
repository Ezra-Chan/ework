<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title></title>
<#include "/common/commoncss.ftl">
<link href="css/common/checkbox.css" rel="stylesheet" />
<style type="text/css">
a {
	color: black;
}

a:hover {
	text-decoration: none;
}

.box-body {
	cursor: pointer;
}

.table {
	padding: 0 0 0 0 !important;
}

.table tr {
	background-color: white !important;
	border-bottom: 1px solid dashed !important;
}

.table .table-header {
	border-bottom: 1px solid dashed !important;
}

.box-header b:hover {
	background-color: #E7E7E7;
}

.box-header a {
	padding: 5px;
}

.box-body {
	padding: 0 0 0 0 !important;
}

.active {
	color: #000000;
}

.box-body .table-header .status {
	color: #72afd2;
}

.box-body  .table-header  .type {
	color: #72afd2;
}

.box-body .table-header span {
	width: 2px !important;
	height: 2px !important;
}

.paixu :hover{
color:blue;
}

.box {
	margin-top: 10px !important;
}
</style>
</head>

<body style="background-color: #ecf0f5;">
	<div class="row" style="padding-top:10px">
		<div class="col-md-2">
			<h1 style="font-size: 24px; margin: 0;" class="">考勤管理</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12 thistable">
			<!--id="container"-->
			<#include "attendcetable.ftl">
		</div>
	</div>
</body>


</html>