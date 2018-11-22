<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>  
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
					<h2 class="tm-block-title d-inline-block">Read</h2>
				</div>
			</div>

			<!-- Read -->
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
					 <h2 class="tm-block-title d-inline-block">FileAttach</h2>
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
					 
					 <sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer}">
					<button type="submit" class="btn btn-small btn-primary">Modify</button>
				</c:if>
				</sec:authorize>
					<button id ="listBtn" type="submit" class="btn btn-small btn-primary">List</button>
				</form>
			</div>
			<!--end Read -->
		</div>
	</div>

	<!-- Reply -->
	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
		<div class="bg-white tm-block h-100">
			<div class="row">
				<div class="col-8">
					<h2 class="tm-block-title d-inline-block">Reply List</h2>

				</div>
				<div class="col-4 text-right">
					<sec:authorize access="isAuthenticated()">
					<button class="btn-yj" id="addReplyBtn">add reply</button>
					</sec:authorize>
				</div>
			</div>
			<ul id="chat"
				class="tm-list-group tm-list-group-alternate-color tm-list-group-pad-big col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<li>
					<div class="header"></div>
				</li>
			</ul>
			<div class="panel-footer">
			</div>
		</div>

	</div>
	<!--end Reply -->

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
				<div class="modal-body" id="mModal"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<!-- ReplyModal -->
	<div class="modal fade" id="replyModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">ReplyModal</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label>
						<input class="form-control" name="reply" value="New Reply!!!">
					</div>
					<div class="form-group">
						<label>Replyer</label>
						<sec:authorize access="isAuthenticated()">
						<input class="form-control" name="replyer" value='<sec:authentication property="principal.username"/>'>
						</sec:authorize>
					</div>
					<div class="form-group">
						<label>Reply Date</label>
						<input class="form-control" name="replydate" value="">
					</div>
				</div>
				<div class="modal-footer">
				
					<button id="modalModBtn" type="button" class="btn btn-danger">Modify</button>
					<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
					<button id="modalRegisterBtn" type="button" class="btn btn-danger">Register</button>
					<button id="modalCloseBtn" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.Replymodal -->
	
<form id="actionForm">
	<input type="hidden" name="page" value="${pageObj.page}">
	<input type="hidden" name="display" id="display" value="${pageObj.display}">
</form>		
	<%@include file="../includes/footer.jsp"%>
	
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
//read.js
$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	var replyUL = $("#chat");
	var actionForm = $("#actionForm");
	var result = '<c:out value="${result}"/>';
	var msg = $("#myModal");
	var bno = '<c:out value="${board.bno}"/>';
	
	var modal =$("#replyModal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replydate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	var replyer =null;
	
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	showList(1);
	
	//ajax spring security header
	$(document).ajaxSend(function(e, xhr, options){
		
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		
	});
		
	//댓글 추가
	$("#addReplyBtn").on("click",function(e){
		
		modal.find("input").val("");
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$("#replyModal").modal("show");
		
	});
	
	//모달 댓글 등록
	modalRegisterBtn.on("click",function(e){
		
		var reply ={
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
		};
		replyService.add(reply, function(result){
			
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			//showList(1);
			showList(-1);
		});
		
	});//end
	
	//댓글조회
	$("#chat").on("click","li",function(e){
		
		var rno = $(this).data("rno");
		
		replyService.get(rno, function(reply){
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
			modalInputReplyDate.val(replyService.displayTime(reply.replydate)).attr("readonly","readonly");
			modal.data("rno",reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$("#replyModal").modal("show");
			
		});
	});//end
	
	//replyModify
	modalModBtn.on("click",function(e){
		
		var reply = {
				rno:modal.data("rno"),
				reply:modalInputReply.val()
		};
		replyService.update(reply, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
		
	});//end
	
	//remove
	modalRemoveBtn.on("click",function(e){
		
		var rno = modal.data("rno");
		
		replyService.remove(rno, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
		
	});//end
	
	//showList
	function showList(page){
		
		replyService.getList({bno:bnoValue, page:page || 1},function(replyCount,list){
			
			console.log("replyCount: " + replyCount);
			console.log("list: " + list);
			console.log(list);
			
			if(page == -1){
				
				pageNum = Math.ceil(replyCount/10.0);
				showList(pageNum);
				return;
			}
			
			var str ="";
			
			if(list == null || list.length == 0){
				replyUL.html("");
				
				return;
			}
			for(var i =0, len = list.length || 0; i < len; i++){
				
				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replydate)+"</small></div>";
				str +="<p>"+list[i].reply+"</p></div></li>";
			}
			console.log("str:"+str);
			replyUL.html(str);
			showReplyPage(replyCount);
		});//end function
	}//end showList
	
	//show reply page
	function showReplyPage(replyCount){
		
		var endNum = Math.ceil(pageNum/10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCount){
			endNum = Math.ceil(replyCount/10.0);
		}
		
		if(endNum * 10 < replyCount){
			next = true;
		}
		
		var str ="<ul class='pagination pull-right'>";
		
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";	
		}
		
		for(var i = startNum; i <= endNum; i++){
			
			var active = pageNum ==i? "active":"";
			
			str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){			
			str +="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
		}
		
		str += "</ul></div>";
		console.log(str);
		
		replyPageFooter.html(str);
		
	}//end
	
	//페이지 클릭 처리
	replyPageFooter.on("click","li a",function(e){
		
		e.preventDefault();
		console.log("page Click..");
		
		var targetPageNum = $(this).attr("href");
		
		console.log("targetPageNum: " + targetPageNum);
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});//end
				
	$("#listBtn").on("click",function(e){
		e.preventDefault();
		actionForm.attr("action","/board/list").attr("method","get").submit();
	});
	
	$.getJSON("/board/getAttachList",{bno:bno}, function(arr){
		
		console.log(arr);
		
		var str = "";
		
		$(arr).each(function(i,attach){
			
			if(attach.fileType){
				
				var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid + "_" + attach.fileName);
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>"
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "<p><a href='#'>"+attach.fileName+"</a></p>";
				str += "<div>";
				str += "</li>";
			}else{
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>"
				str += "<img src='/resources/img/clip.png'></a>";
				str += "<p><a href='#'>"+attach.fileName+"</a></p>";
				str += "</div>";
				str += "</li>";
			}
			
		});
		console.log(str);
		$(".uploadResult ul").html(str);
		
	});// end JSON
	
	$(".uploadResult").on("click","li",function(e){
		
		console.log("view..");
		
		var liObj = $(this);
		
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		
		if(liObj.data("type")){
			
			showImage(path.replace(new RegExp(/\\/g),"/"));
			
		}
	});
	
$(".uploadResult").on("click","p a",function(e){
		e.preventDefault();
		e.stopPropagation();
		console.log("download..");
		
		var liObj = $(this).closest('li');
		var fileName=liObj.data("filename").replace(".","_");
		
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+fileName);
		console.log(path);
		var link ="/download?fileName="+path;
		
		self.location = link;
		
	});
	
	function showImage(fileCallPath){
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%',height:'100%'},1000);
		
	}
	
	$(".bigPictureWrapper").on("click",function(e){
		
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		},1000);
		
	});
	
	
	function checkModal(result){
				
		if(result === '' || history.state){
	 	return;	
		}
				
		if (result === 'SUCCESS') {
			$("#mModal").html("작업성공!");
			msg.modal('show');
				
		}
	}
	
	
	checkModal(result);
	history.replaceState({},null,null);
		 
});
</script>