<div class="row">
	<div class="col-xs-12">
		<div class="box">
		<div class="box-header">
			<h3 class="box-title">邮件列表</h3>
		</div>
        <div class="box-body">
        	<div class="clearfix">
	        	<div class="col-md-4">
			        <div class="input-group date ">
						<div class="input-group-addon">
	                    	<i class="fa fa-calendar"></i>
	                  	</div>
	                  	<input type="text" class="form-control pull-right" id="tableParam">
	                </div>
	        	</div>
	        	<div class="col-md-4">
	        		<div class="input-group">
		                <span class="input-group-addon"><i class="fa fa-search"></i></span>
		                <input type="text" class="form-control" id="search">
		            </div>
	        	</div>
	        	<div class="col-md-4">
	        		<button type="submit" id="submitExample4" class="btn btn-primary">Submit</button>
	        	</div>
        	</div>
        	
			<table id="emailInfo_tab" class="table table-bordered table-striped" >
		        <thead>
		            <tr>
		                <th>序号</th>
		                <th>发件人</th>
		                <th>收件人</th>
		                <th>主题</th>
		                <th>发送时间</th>
		                <th>操作</th>
		            </tr>
		        </thead>
		    </table>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deleteUser">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
				<h4 class="modal-title">提示</h4>
			</div>
			<div class="modal-body">
				<p>确认删除？</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">确认</button>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
  
<script>
$(function () {
    //Date picker
    $('#tableParam').datepicker({
      autoclose: true
    });
    
	//初始化表格
	var No=0;
     var emailInfo_tab = $('#emailInfo_tab').DataTable( {
        "dom": 'itflp',
        "processing": true,
		"searching": false,
        "serverSide": true,   //启用服务器端分页
		"bInfo": false,  
        "language": {
            "url": "plugins/datatables/language.json"
        },
        "ajax": {"url": "${ctx}/admin/emailInfo/page", "type":"post"},
        "columns": [
            { "data": null },
            { "data": "fromUser" },
            { "data": "toUser" },
            { "data": "subject" },
            { "data": null },
            { "data": null }
        ],
        "columnDefs": [
						{
						    targets: 0,
						    data: null,
						    render: function (data) {
						    	No=No+1;
						        return No;
						    }
						},
                       {
                           targets: 4,
                           data: "createTime",
                           render: function (data) {
                        	   var newDate = new Date();
                        	   newDate.setTime(data.createTime * 1000);
                               return newDate.toLocaleString();
                           }
                       },
               {
            "targets": 5,
            "data": null,
            "render": function(data){
				console.log(data);
				return '<a class="btn btn-xs btn-primary" target="modal" modal="lg" href="${ctx}/admin/emailInfo/view?id='+data.id+'">查看</a> &nbsp;<a class="btn btn-xs btn-default" data-body="确认要删除吗？" target="ajaxTodo" href="${ctx}/admin/emailInfo/delete?id='+ data.id + '">删除</a>'
			}
        } ]
    } ).on('preXhr.dt', function ( e, settings, data ) {
		No=0;
    } );

	//点击删除确认后，删除并刷新
	$(".btn-del").click(function(){
		reloadTable(emailInfo_tab);
	});
});
</script>