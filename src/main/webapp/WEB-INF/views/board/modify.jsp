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
		background-image: url("../resources/img/white.png");
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
				<form id='modifyForm' role="form" action="/board/modify" method="post" >
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
					<input type="hidden" name="bno" value="${board.bno}">
					<input type="hidden" name="page" value="${pageObj.page}">
					<input type="hidden" name="display" id="display" value="${pageObj.display}">
					<button id='modifyBtn'type="submit" data-oper="modify" class="btn btn-small btn-primary">Modify</button>
					<button id='listBtn'type="submit" data-oper="list" class="btn btn-small btn-primary">List</button>
					<button id='removeBtn' type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
				</form>
			</div>
		</div>
	</div>
</div>

<form id="actionForm">
	<input type="hidden" name="bno" value="${board.bno}">
	<input type="hidden" name="page" value="${pageObj.page}">
	<input type="hidden" name="display" id="display" value="${pageObj.display}">
</form>	

<%@include file="../includes/footer.jsp"%>

<script>

$(document).ready(function(){
	
	var actionForm = $("#actionForm");
	  //파일 타입
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	
	//파일 체크
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("파일을 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	

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
	
	$(".uploadResult").on("click","button",function(e){
		
		console.log("delete file");
		
		if(confirm("Remove this file?")){
			
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
		
	});
	
		
	//업로드 출력
	 function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
			
			if(obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				str += "<li data-path='"+obj.uploadPath+"'";
				str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>"
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='tm-trash-icon-cell'><i class='fas fa-trash-alt tm-trash-icon'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
			}else{
				//str += "<li>"+obj.fileName+"</li>"
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li ";
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='tm-trash-icon-cell'><i class='fas fa-trash-alt tm-trash-icon'></i></button><br>";
				str += "<img src='/resources/img/clip.png'></a>";
				str += "</div>";
				str += "</li>";
			}	
			
		});
		uploadUL.append(str);
		console.log(uploadResultArr);
	}	
		
		//
		$('button').on("click",function(e){
			var formObj ;
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
	
			if(operation === 'remove'){
				formObj=$("#removeBtn");
				console.log("submit remove....")
				actionForm.attr("action","/board/remove").attr("method","post").submit();	
				
			}else if(operation === 'list'){
				formObj=$("#listBtn");
				console.log("submit list....")
				actionForm.attr("action","/board/list").attr("method","get").submit();		
				
			}else if(operation === 'modify'){
				formObj=$("#modifyForm");
				console.log("submit modify....")
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i,obj){		
					var jobj= $(obj);
					console.dir(jobj);
					
					str +="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str +="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str +="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str +="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				formObj.append(str).submit();
				
			}
			formObj.submit();
		});	
		
		//파일 업로드
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
				
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size) ){
					return false;
				}
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				url:'/uploadAjaxAction',
				processData: false,
				contentType: false,
				data:formData,
				type:"POST",
				dataType:"JSON",
				success:function(result){
					console.log(result);
				showUploadResult(result);	
				}
			});//$.ajax

		});//input[type='file'] 

});

</script>