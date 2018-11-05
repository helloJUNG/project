<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>

<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>

<style>
form {
	width: 100%;
}

.uploadResult{
		width:100%;
		background-color: gray;
	}
	
	.uploadResult ul{
		display:flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	.uploadResult ul li img{
		width: 100px;
		heigh: 100px;
	}
	.uploadResult ul li span{
		color:white;
	}
	.bigPictureWrapper{
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background:rgba(255,255,255,0.5);
	}
	.bigPicture{
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.bigPicture img{
		width: 600px;
	}


</style>

<!-- row -->
<div class="row tm-mt-big">
	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
		<div class="bg-white tm-block">
			<div class="row">
				<div class="col-12">
					<h2 class="tm-block-title d-inline-block">Read</h2>
				</div>
			</div>


			<div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<form>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Title </label> <input id="title" name="title" type="text"
							value="<c:out value="${board.title}"/>" readonly="readonly"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Writer </label> <input id="writer" name="writer" type="text"
							value="<c:out value="${board.writer}"/>" readonly="readonly"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 mb-2">Content</label>
						<textarea readonly="readonly"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							rows="3" name="content" required><c:out
								value="${board.content}" /></textarea>
					</div>
					<div class="form-group uploadDiv">
					<label>FileAttach </label>
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
				</form>
				<form role="form" action="/board/modify" method="get">
					 <input type="hidden" name="page" value="${pageObj.page}">
					 <input type="hidden" name="bno" value="${board.bno}">
					 <input type="hidden" name="display" id="display" value="${pageObj.display}">
					<button type="submit" class="btn btn-small btn-primary">Modify</button>
				</form>
				<form role="form" action="/board/list" method="get">
					<input type="hidden" name="page" value="${pageObj.page}">
					<input type="hidden" name="display" id="display" value="${pageObj.display}">
					<button type="submit" class="btn btn-small btn-primary">List
						Button</button>
				</form>

			</div>
		</div>
	</div>
</div>	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<%@include file="../includes/footer.jsp"%>
<script>
$(document).ready(function(){
		 

	var result = '<c:out value="${result}"/>';
	var msg = $("#myModal");
			
	checkModal(result);
	history.replaceState({},null,null);
	

	
	var bno = '<c:out value="${board.bno}"/>';
	
	$.getJSON("/board/getAttachList",{bno:bno}, function(arr){
		
		console.log(arr);
		
		var str = "";
		
		$(arr).each(function(i,attach){
			
			if(attach.fileType){
				
				var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid + "_" + attach.fileName);
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>"
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "<div>";
				str +  "</li>";
			}else{
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>"
				str += "<span>" +attach.fileName+"</span><br/>";
				str += "<img src='/resources/img/clip.png'></a>";
				str += "</div>";
				str +  "</li>";
			}
			
		});
		
		$("uploadResult ul").html(str);
		
	});// end JSON
	
	
	function checkModal(result){
				
		if(result === '' || history.state){
	 	return;	
		}
				
		if (result === 'SUCCESS') {
			$(".modal-body").html("작업성공!");
			msg.modal('show');
				
		}
	}
		 
});
</script>