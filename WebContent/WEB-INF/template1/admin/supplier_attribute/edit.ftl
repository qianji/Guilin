<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.supplierAttribute.edit")}</title>


<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $supplierAttributeTable = $("#supplierAttributeTable");
	var $addOptionButton = $("#addOptionButton");
	var $deleteOption = $("a.deleteOption");
	
	[@flash_message /]
	
	// 增加选项内容
	$addOptionButton.click(function() {
		addOption();
	});
		
	// 删除选项内容
	$deleteOption.live("click", function() {
		if ($supplierAttributeTable.find("tr.optionTr").size() <= 1) {
			$.message("warn", "${message("admin.common.deleteAllNotAllowed")}");
		} else {
			$(this).closest("tr").remove();
		}
	});
	
	// 增加选项内容
	function addOption() {
		[@compress single_line = true]
			var trHtml = 
			'<tr class="optionTr">
				<th>${message("MemberAttribute.options")}:<\/th>
				<td>
					<input type="text" name="options" class="text options" maxlength="200" \/>
					<a href="javascript:;" class="deleteOption">[${message("admin.common.delete")}]<\/a>
				<\/td>
			<\/tr>';
		[/@compress]
		$supplierAttributeTable.append(trHtml);
	}
	
	$.validator.addClassRules({
		options: {
			required: true
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			type: "required",
			name: "required",
			order: "digits"
		}
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.supplierAttribute.edit")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${supplierAttribute.id}" />
		<table id="supplierAttributeTable" class="input">
			<tr>
				<th>
					${message("MemberAttribute.type")}:
				</th>
				<td>
					${message("SupplierAttribute.Type." + supplierAttribute.type)}
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("SupplierAttribute.name")}:
				</th>
				<td>
					<input type="text" name="name" class="text" value="${supplierAttribute.name}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td>
					<input type="text" name="order" class="text" value="${supplierAttribute.order}" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.setting")}:
				</th>
				<td>
					<label>
						<input type="checkbox" name="isEnabled" value="true"[#if supplierAttribute.isEnabled] checked="checked"[/#if] />${message("SupplierAttribute.isEnabled")}
						<input type="hidden" name="_isEnabled" value="false" />
					</label>
					<label>
						<input type="checkbox" name="isRequired" value="true"[#if supplierAttribute.isRequired] checked="checked"[/#if] />${message("SupplierAttribute.isRequired")}
						<input type="hidden" name="_isRequired" value="false" />
					</label>
				</td>
			</tr>
			[#if supplierAttribute.type?? && (supplierAttribute.type == "select" || supplierAttribute.type == "checkbox")]
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<a href="javascript:;" id="addOptionButton" class="button">${message("admin.common.add")}</a>
					</td>
				</tr>
			[/#if]
			[#if (supplierAttribute.type == "select" || supplierAttribute.type == "checkbox")!]
				[#list supplierAttribute.options as option]
					<tr class="optionTr">
						<th>${message("SupplierAttribute.options")}:</th>
						<td>
							<input type="text" name="options" class="text options" value="${option}" maxlength="200" />
							<a href="javascript:;" class="deleteOption">[${message("admin.common.delete")}]</a>
						</td>
					</tr>
				[/#list]
			[/#if]
		</table>
		<table class="input">
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>