<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 첨부파일 등록 -->
<script>
	$(function(){
		
		// 파일 업로드 유효성 검사
		//const regex = new RegExp('(.*?)\.(exe|sh|zip|alz)$');
		const regex = new RegExp('(.*?)\.(jpg|jpeg|png|gif)$', 'i');
		const maxSize = 5242880;  // 5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert('파일 사이즈 초과');
				return false;
			}
			
			if(!regex.test(fileName)){
				alert('해당 종류의 파일은 업로드할 수 없습니다.');
				return false;
			}
			
			return true;
		}
		
		// <input type="file">의 내용이 변경되는 것을 감지
		$('input[type="file"]').change(function(e){			
			const formData = new FormData();
			const inputFile = $('input[name="uploadFile"]');
			let files = inputFile[0].files;

			for(let i=0; i<files.length; i++){
				console.log(i)
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
				formData.append('uploadFile', files[i]);
			}			
			
			$.ajax({
				url: '/uploadAjaxAction',
				type: 'post',
				processData: false,
				contentType: false,
				data: formData,
				dataType: 'json',
				success: function(result){
					console.log(result);
					showUploadResult(result); // 업로드 결과 처리 함수 호출
				}
			});
		});
		
		// 업로드된 결과를 화면에 섬네일 등을 만들어서 처리하는 부분
		function showUploadResult(uploadResultArr) {
			if(!uploadResultArr || uploadResultArr.length == 0){return;}
			
			const uploadUL = $('.uploadResult ul');
			
			let str = '';
				console.log("uploadResultArr : "+uploadResultArr)
			
			$(uploadResultArr).each(function(i, obj){
				console.log("fileType:" + obj.fileType)
				// image type
				if(obj.fileType){
					let fileCallPath = encodeURIComponent(obj.uploadPath + '/s_' 
							+ obj.uuid + '_' + obj.fileName);
					
					str += '<li data-path="'+ obj.uploadPath +'" data-uuid="'+ obj.uuid;
					str += '" data-filename="'+ obj.fileName +'" data-type="'+ obj.fileType +'"><div>';
					str += '<span>'+ obj.fileName + '</span>';
					str += '<button type="button" data-file="'+ fileCallPath +'" data-type="image"';
					str += 'class="btn btn-sm btn-danger btn-circle m-2">';
					str += '<i class="bi bi-x"></i></button><br>';
					str += '<img src="/display?fileName='+ fileCallPath +'">';
					str += '</div></li>';
				}else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + '/' 
							+ obj.uuid + '_' + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g), '/');
					
					str += '<li data-path="'+ obj.uploadPath +'" data-uuid="'+ obj.uuid;
					str += '" data-filename="'+ obj.fileName +'" data-type="'+ obj.fileType +'"><div>';
					str += '<span>'+ obj.fileName + '</span>';
					str += '<button type="button" data-file="'+ fileCallPath +'" data-type="file"';
					str += 'class="btn btn-sm btn-danger btn-circle m-2">';
					str += '<i class="bi bi-x"></i></button><br>';
					str += '<img src="/resources/img/attach.png">';
					str += '</div></li>';
				}
			});
			
			uploadUL.append(str);
		}
		
		// 첨부파일 삭제
		$('.uploadResult').on('click','button', function(e){
			console.log('delete file');
			
			let targetFile = $(this).data('file');
			let type = $(this).data('type');
			let targetLi = $(this).closest('li');
			
			$.ajax({
				url: '/deleteFile',
				type: 'post',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
			});
		});
				
		// 섬네일 삭제
		$('.uploadResult').on('click', 'span', function(e){
			let targetFile = $(this).data('file');
			let type = $(this).data('type');
			console.log(targetFile);
			
			$.ajax({
				url: '/deleteFile',
				type: 'post',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				success: function(result){
					alert(result);
				}
			});
		});
	});
</script>