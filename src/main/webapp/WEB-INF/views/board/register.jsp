<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

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
					<h2 class="tm-block-title d-inline-block">Register</h2>
				</div>
			</div>


			<div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<form role="form" action="/board/register" method="post">

					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Title </label> <input id="title" name="title" type="text" required
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Writer </label> <input id="writer" name="writer" type="text" required
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 mb-2">Content</label>
						<textarea
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							rows="3" name="content" required></textarea>
					</div>

					<div class="form-group">
						<div class="ml-auto col-xl-8 col-lg-8 col-md-8 col-sm-7 pl-0">
							<button type="submit" class="btn btn-small btn-primary">Register</button>
						</div>
					</div>
				</form>			
			</div>
			  <div>
					<div class="form-group uploadDiv">
					<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">FileAttach </label>
							<input id="uploadFile" name="uploadFile" type="file" multiple class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"/> 
					</div>
					<div class="uploadResult">
						<ul>

						</ul>
					</div>
			  </div>
		</div>
	</div>

	
</div>


<%@include file="../includes/footer.jsp"%>

<script>

	$(document).ready(function(e){
		
		var formObj = $("form[role='role']");
		$("button[type='submit']").on("click",function(e){
			
			e.preventDefault();
			
			console.log("submit clicked");
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		
		function checkExtention(fileName, fileSize){
			
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
		
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
				
				if(!checkExtension(files[i].name,files[i].size)){
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
		
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length == 0){return; }
			
			var uploadUL = $(".uploadResult ul");
			
			var str = "";
			
			$(uploadResultArr).each(function(i,obj){
				
				if(obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					str += "<li><div>";
					str += "<span>"+obj.fileName+"</span>";
					str += "<button type='button' class='tm-trash-icon-cell'><i class='fas fa-trash-alt tm-trash-icon'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
				}else{
					//str += "<li>"+obj.fileName+"</li>"
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li><div>";
					str += "<span>"+obj.fileName+"</span>";
					str += "<button type='button' class='tm-trash-icon-cell'><i class='fas fa-trash-alt tm-trash-icon'></i></button><br>";
					str += "<img src='/resources/img/clip.png'></a>";
					str += "</div>";
					str += "</li>";
				}	
				
			})
			
		}
		
		
	});

</script>