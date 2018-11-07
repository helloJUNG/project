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
					<h2 class="tm-block-title d-inline-block">Modify</h2>
				</div>
			</div>

			<div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<form role="form" action="/board/modify" method="post">
					 <input type="hidden" name="bno" value="${board.bno}">
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Title </label> <input id="title" name="title" type="text" required
							value="<c:out value="${board.title}"/>"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Writer </label> <input id="writer" name="writer" type="text" required
							value="<c:out value="${board.writer}"/>" readonly="readonly"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 mb-2">Content</label>
						<textarea
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							rows="3" name="content" required><c:out
								value="${board.content}" />"</textarea>
					</div>
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple="multiple"> 
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
					<button type="submit" class="btn btn-small btn-primary">Modify</button>
				</form>
			</div>
			<form role="form" action="/board/list" method="get">
				<input type="hidden" name="page" value="${pageObj.page}">
				<input type="hidden" name="display" id="display" value="${pageObj.display}">
				<button type="submit" class="btn btn-small btn-primary">List
					Button</button>
			</form>
			<form role="form" action="/board/remove" method="post">
				<input type="hidden" name="page" value="${pageObj.page}"> 
				<input type="hidden" name="bno" value="${pageObj.bno}">
				<input type="hidden" name="display" id="display" value="${pageObj.display}">
				<button type="sumbit" class="btn btn-danger">Remove</button>
			</form>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>

<script>

$(document).ready(function(){
	
	(function(){
		
		var bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList",{bno:bno}, function(arr){
			
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i,attach){
				
				if(attach.fileType){
					
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" +attach.uuid+ "_" +attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>"+attach.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='tm-trash-icon-cell'><i class='fas fa-trash-alt tm-trash-icon'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>"
					str += "</li>"
					
				}else{
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>" + attach.fileName+ "</span></br>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='tm-trash-icon-cell'><i class='fas fa-trash-alt tm-trash-icon'></i></button><br>";
					str += "<img src='/resources/img/clip.png'></a>";
					str += "</div>"
					str += "</li>"
					
				}	
			});
			$(".uploadResult ul").html(str);
			
		});//end JSON
		
	})();//end function
		
});

</script>