<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

        <!-- row -->
        <div class="row tm-mt-big">
            <div class="col-xl-8 col-lg-10 col-md-12 col-sm-12">
                <div class="bg-white tm-block">
                    <div class="row">
                        <div class="col-12">
                            <h2 class="tm-block-title d-inline-block">Register</h2>
                        </div>
                    </div>
                    
                   
                    <div class="row mt-4 tm-edit-product-row">
                     <form role="form" action="/board/list" method="post" class="tm-edit-product-form">
                        <div class="col-xl-7 col-lg-7 col-md-12">
                                <div class="form-group">
                                    <label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
                                    	title
                                    </label>
                                    <input id="title" name="title" type="text" class="form-control validate col-xl-9 col-lg-8 col-md-8 col-sm-7">
                                </div>
                                 <div class="form-group">
                                    <label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
                                        Writer
                                    </label>
                                    <input id="writer" name="writer" type="text" class="form-control validate col-xl-9 col-lg-8 col-md-8 col-sm-7"
                                        data-large-mode="true">
                                </div>
                                <div class="form-group">
                                    <label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 mb-2">Content</label>
                                    <textarea class="form-control validate col-xl-9 col-lg-8 col-md-8 col-sm-7" rows="3" required></textarea>
                                </div>
                           
                                <div class="form-group">
                                    <div class="ml-auto col-xl-8 col-lg-8 col-md-8 col-sm-7 pl-0">
                                        <button type="submit" class="btn btn-default">Register
                                        </button>
                                    </div>
                                </div>
                        </div>
                         </form>
                        <div class="col-xl-4 col-lg-4 col-md-12 mx-auto mb-4">
                            <div class="tm-product-img-dummy mx-auto">
                                <i class="fas fa-5x fa-cloud-upload-alt" onclick="document.getElementById('fileInput').click();"></i>
                            </div>
                            <div class="custom-file mt-3 mb-3">
                                <input id="fileInput" type="file" style="display:none;"/>
                                <input type="button" class="btn btn-primary d-block mx-auto" value="Upload ..." onclick="document.getElementById('fileInput').click();"
                                />
                            </div>
                        </div>
                    </div>
                   
                </div>
            </div>
        </div>
<%@include file="../includes/footer.jsp"%>