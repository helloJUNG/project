package org.jj.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.jj.domain.AttachFileDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());			
			return contentType.startsWith("image");
			
		} catch (IOException e) {
			
			e.printStackTrace();
		}				
		return false;
	}
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
				
		return str.replace("-", File.separator);
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax......");
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<AttachFileDTO> list = new ArrayList<>();
		
		String uploadFolder ="C:\\upload";
		String uploadFolderPath = getFolder();
		
		//make Folder
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		log.info("uploadPath: " + uploadPath);
	
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile:uploadFile) {
			
			log.info("-----------------------------------------");
			log.info("UploadFileName: " + multipartFile.getOriginalFilename());
			log.info("UploadFileSize: " + multipartFile.getSize());
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			attachDTO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			
			
			try {
				//File saveFile = new File(uploadFolder,uploadFileName);
				File saveFile = new File(uploadPath,uploadFileName);
				
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				
				//check image type
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
				}
				list.add(attachDTO);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}//end for
		log.info(list);
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName: " +fileName);
		File file = new File("c:\\upload\\"+fileName);
		
		log.info("file:" +file);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value= "/download", produces = {MediaType.APPLICATION_OCTET_STREAM_VALUE})
	@ResponseBody // byte 諛곗뿴�옄泥닿� �뜲�씠�꽣
	public ResponseEntity<byte[]> download(@RequestHeader("User-Agent")String userAgent, String fileName) {

		String fName = fileName.substring(0, fileName.lastIndexOf("_"));
		log.info("FName: " + fName);

		String ext = fileName.substring(fileName.lastIndexOf("_") + 1);
		log.info("ext: " + ext);

		String total = fName + "." + ext;
		
		int under = total.indexOf("_");
		
		String totalOrigin = total.substring(under+1);
		
		ResponseEntity<byte[]> result = null;

		try {
			File target = new File("C:\\upload\\" + total);

			String downName= new String(totalOrigin.getBytes("UTF-8"),"ISO-8859-1");
			
			HttpHeaders header = new HttpHeaders();
			
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downName = URLEncoder.encode(totalOrigin, "UTF-8").replaceAll("\\+"," ");
			
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downName = URLEncoder.encode(totalOrigin, "UTF-8");
			
			}else {
				log.info("Chrome browser");
				downName = new String(totalOrigin.getBytes("UTF-8"),"ISO-8859-1");
				
			}
			
			log.info("downName: " + downName);
			
			header.add("Content-Disposition","attachment; filename=" +downName);

			byte[] arr = FileCopyUtils.copyToByteArray(target);
			result = new ResponseEntity<>(arr,header,HttpStatus.OK);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("deleteFile: " + fileName);
		File file;
		
		try {
			file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				
				file.delete();
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
				
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
	

}
