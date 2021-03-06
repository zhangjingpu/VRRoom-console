<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="#" type="image/png">
    <title>编辑楼层类型</title>
    <%@ include file="../inc/new2/css.jsp" %>
</head>

<body class="sticky-header">

<section>
    <%@ include file="../inc/new2/menu.jsp" %>
    <!-- main content start-->
    <div class="main-content">
        <%@ include file="../inc/new2/header.jsp" %>
        <!--body wrapper start-->

        <section class="wrapper">
            <!-- page start-->

            <div class="row">
                <div class="col-lg-12">
                    <section class="panel">

                        <header class="panel-heading">
                            楼层类型
                        </header>
                        <div class="panel-body">
                            <form class="cmxform form-horizontal adminex-form">
                                <input name="id" type="hidden" value="${enterprise.id}">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <button type="button" onclick="$houseFloor.fn.addFloorType()" class="btn btn-primary"><i class="fa fa-plus"></i> 新增楼层类型</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>

            <div id="floorDiv">

            </div>

            <div class="row">
                <div class="col-lg-12">
                    <section class="panel">

                        <div class="panel-body">
                            <form class="cmxform form-horizontal adminex-form">

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <button type="button" onclick="$houseFloor.fn.save()" class="btn btn-primary">保存</button>
                                        <button type="button" onclick="history.go(-1);" class="btn btn-primary">返回</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>

        </section>

    </div>
    <!-- main content end-->

    <!-- 楼层类型template -->
    <div class="row" style="display: none;" id="floorTypeTemplate">
        <div class="col-lg-12">
            <section class="panel">

                <header class="panel-heading">
                    <label>楼层类型</label>
                            <span class="tools pull-right">
                                <a href="javascript:;" class="fa fa-chevron-down"></a>
                                <a href="javascript:;" class="fa fa-times"></a>
                            </span>
                </header>
                <div class="panel-body">
                    <form class="cmxform form-horizontal adminex-form">

                        <div class="form-group">
                            <label class="col-sm-1 control-label">楼层横切面图：</label>
                            <div class="col-sm-6">
                                <button type="button" onclick="$houseFloor.fn.addTransverse()" class="btn btn-primary"><i class="fa fa-pencil-square-o"></i> 新增横切面</button>
                            </div>
                        </div>

                        <div id="transverseDiv_" name="transverseDiv">

                        </div>

                    </form>
                </div>
            </section>
        </div>
    </div>

    <!-- 横切面template -->
    <input type="hidden" id="currentTransverseId" value="">
    <div class="form-group" style="display: none;" id="transverseTemplate" name="transverseGroup">

        <%--<label class="col-sm-1 control-label">横切面1：</label>--%>

        <label class="col-sm-1 control-label">上传横切面图：</label>
        <div class="col-sm-2">
            <input type="hidden" name="transverseImageId" value="">
            <a href="javascript:void(0);" onclick="$houseFloor.fn.AddTempImg(this)">
                <img src="${contextPath}/static/images/add.jpg" style="height: 150px; width: 200px; display: inline; margin-bottom: 5px;" border="1"/>
            </a>
            <a href="javascript:void(0)" target="_blank" class="btn btn-primary btn-sm" role="button" style="color: white; display: none;margin-bottom: 5px;">添加锚点</a>
        </div>

        <label class="col-sm-1 control-label">选择户型：</label>
        <input type="hidden" name="unitId" value="">
        <div class="col-sm-2">
            <a href="javascript:void(0);" onclick="$houseFloor.fn.openModal(this)">
                <img name="unitImg" src="${contextPath}/static/images/add.jpg" style="height: 150px; width: 150px; display: inline; margin-bottom: 5px;" border="1"/>
            </a>
        </div>
        <div class="col-sm-2">
            <div class="form-group" name="unitName">
                户型名称：
            </div>
            <div class="form-group" name="unitArea">
                建筑面积：
            </div>
            <div class="form-group" name="unitPrice">
                参考总价：
            </div>
        </div>

        <label class="col-sm-1 control-label">选择房间号：</label>
        <div class="col-sm-1">
            <select class="form-control" name="roomNo">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>

        <div class="col-sm-2">
            <button type="button" class="btn btn-primary" onclick="$houseFloor.fn.removeTransverse(this)"><i class="fa fa-minus"></i> 移除</button>
        </div>

    </div>

    <form id="tempImageForm" method="post" action="${contextPath}/common/file/addTempImage" enctype="multipart/form-data" class="form-horizontal" role="form">
        <input type="file" name="tempImage" id="tempImage" data-rule="required" style="display:none;" onchange="$houseFloor.fn.saveTempImage()"/>
    </form>


    <!-- 选择户型弹出框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="pwdModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">选择户型</h4>
                </div>
                <div class="modal-body">
                    <form class="cmxform form-horizontal adminex-form" id="unitForm" enctype="multipart/form-data">
                        <input type="hidden" id="currentUnitId" value="">

                        <div id="unitDiv">

                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" onclick="$houseFloor.fn.selectUnit()" class="btn btn-primary">确定</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <!-- 户型 template -->
    <div class="form-group" style="display: none;" id="unitTemplate">
        <div class="col-sm-1">
            <input type="radio" name="unitRadio">
        </div>
        <label class="col-sm-2 control-label">户型：</label>
        <div class="col-sm-5">
            <img src="" style="height: 200px; width: 200px; display: inline; margin-bottom: 5px;" border="1"/>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                户型名称：
            </div>
            <div class="form-group">
                建筑面积：
            </div>
            <div class="form-group">
                参考总价：
            </div>
        </div>
    </div>

</section>
<%@ include file="../inc/new2/foot.jsp" %>
<script>
    $houseFloor = {
        v: {
            list: [],
            chart: null,
            dTable: null,
            tempTransverseId : null,
            tempFloorId : null,
        },
        fn: {
            init: function () {

                $houseFloor.v.tempTransverseId = 0;
                $houseFloor.v.tempFloorId = 0;

                //初始化加载楼层类型列表
                $houseFloor.fn.initFloorList();

                //初始化加载弹出框的户型列表
                $houseFloor.fn.initUnitList();
            },
            /* 楼层 */
            initFloorList:function(){
                $.post("${contextPath}/admin/house/floor/list",{'houseId':"${houseId}"},function(result){
                    if(result.status == 0){
                        var list = result.data.object.list;
                        for(var i=0; i < list.length; i++){
                            $houseFloor.fn.addFloorType();

                            var typeUnitList = list[i].typeUnitList;
                            for(var j=0; j<typeUnitList.length; j++){
                                var curTempTransverseId = $houseFloor.fn.addTransverse(i);//新增一个横切面和户型关系
                                $houseFloor.fn.setTransverse(curTempTransverseId, typeUnitList[j]);//给该行数据赋值
                            }
                        }
                    }
                });
            },
            //新增楼层类型
            addFloorType:function(){
                var template = $("#floorTypeTemplate").clone().removeAttr("id");
                template.find("header label").text("楼层类型"+($houseFloor.v.tempFloorId+1));
                template.find("[name=transverseDiv]").attr("id","transverseDiv_"+$houseFloor.v.tempFloorId);
                template.find("button").attr("onclick","$houseFloor.fn.addTransverse("+$houseFloor.v.tempFloorId+")");

                template.show();
                $("#floorDiv").append(template);

                //初始化楼层右上角的收缩和删除楼层块的事件
                var obj = $("#transverseDiv_"+$houseFloor.v.tempFloorId).parents(".row");
                obj.find('.panel .tools .fa-times').click(function () {
                    $(this).parents(".panel").parent().remove();
                });

                obj.find('.panel .tools .fa').click(function () {
                    var el = $(this).parents(".panel").children(".panel-body");
                    if ($(this).hasClass("fa-chevron-down")) {
                        $(this).removeClass("fa-chevron-down").addClass("fa-chevron-up");
                        el.slideUp(200);
                    } else {
                        $(this).removeClass("fa-chevron-up").addClass("fa-chevron-down");
                        el.slideDown(200); }
                });

                $houseFloor.v.tempFloorId++;

            },
            //初始化弹出框的户型列表
            initUnitList : function(){
                $("#unitDiv").empty();
                $.post("${contextPath}/admin/house/unit/list",{'houseId':"${houseId}"},function(result){
                    if(result.status == 0){
                        var list = result.data.object.list;
                        for(var i=0; i < list.length; i++){
                            var unitTemplate = $("#unitTemplate").clone().removeAttr("id");
                            unitTemplate.find("label").text("户型"+(i+1)+"：");
                            unitTemplate.find("img").prop("src",list[i].planeImage.path);
                            unitTemplate.find(".form-group").eq(0).text("户型名称："+list[i].name);
                            unitTemplate.find(".form-group").eq(1).text("建筑面积："+list[i].totalArea);
                            unitTemplate.find(".form-group").eq(2).text("参考总价："+list[i].totalPrice);
                            unitTemplate.find("input[type=radio]").val(list[i].id);
                            unitTemplate.show();
                            $("#unitDiv").append(unitTemplate);

                        }
                    }
                });
            },
            //打开选择户型对话框
            openModal : function (self){
                $("#myModal").modal("show");
                $("#currentUnitId").val($(self).parents(".form-group").find("[name=unitId]").attr("id"));
            },
            //选择户型
            selectUnit : function (){
                var unitObj = $("[name=unitRadio]:checked");

                var divObj = $("#"+$("#currentUnitId").val()).parents(".form-group");

                divObj.find("[name=unitId]").val(unitObj.val());
                divObj.find("[name=unitImg]").attr("src",unitObj.parents(".form-group").find("img").attr("src"));
                divObj.find("[name=unitName]").text(unitObj.parents(".form-group").find(".col-sm-3 .form-group").eq(0).text());
                divObj.find("[name=unitArea]").text(unitObj.parents(".form-group").find(".col-sm-3 .form-group").eq(1).text());
                divObj.find("[name=unitPrice]").text(unitObj.parents(".form-group").find(".col-sm-3 .form-group").eq(2).text());

                $("#myModal").modal("hide");
            },
            //新增横切面
            addTransverse : function (tempFloorId){
                var curTempTransverseId = $houseFloor.v.tempTransverseId;
                var template = $("#transverseTemplate").clone().removeAttr("id");
                template.attr("val",curTempTransverseId);
                template.find("[name=unitId]").attr("id","unitId_"+curTempTransverseId);
                template.show();
                $("#transverseDiv_"+tempFloorId).append(template);

                //给第一张图片加锚点
                if($("#transverseDiv_"+tempFloorId).find("[name=transverseGroup]").length == 1){
                    template.find(".btn-sm").attr("onclick","$houseFloor.fn.editLabel(this)");
                    template.find(".btn-sm").show();
                }

                $houseFloor.v.tempTransverseId++;

                return curTempTransverseId;
            },
            //给当前横切面赋值
            setTransverse : function (curTempTransverseId, typeUnit){
                var obj = $("[name=transverseGroup][val="+curTempTransverseId+"]");

                obj.find("[name=transverseImageId]").val(typeUnit.transverseImage.id);
                obj.find("img").eq(0).attr("src",typeUnit.transverseImage.path);
                obj.find("[name=unitId]").val(typeUnit.unit.id);
                obj.find("[name=unitImg]").attr("src", typeUnit.unit.planeImage.path);
                obj.find("[name=unitName]").text("户型名称："+typeUnit.unit.name);
                obj.find("[name=unitArea]").text("建筑面积："+typeUnit.unit.totalArea);
                obj.find("[name=unitPrice]").text("参考总价："+typeUnit.unit.totalPrice);
                obj.find("select option[value="+typeUnit.roomNo+"]").attr("selected",true);
            },
            //删除横切面
            removeTransverse : function(self){
                $(self).parents(".form-group").remove();
            },
            /* 图片 */
            AddTempImg: function (self) {
                $('#tempImage').click();
                $("#currentTransverseId").val($(self).parents(".form-group").attr("val"));
            },
            //上传图片
            saveTempImage: function () {
                $("#tempImageForm").ajaxSubmit({
                    dataType: "json",
                    success: function (data) {
                        if (null != data.path && data.path != '') {
                            var obj = $("div.form-group[val="+$("#currentTransverseId").val()+"]");
                            obj.find("img").eq(0).attr("src",data.path);
                            obj.find("[name=transverseImageId]").val(data.id);
                        } else {
                            $leoman.alertMsg("上传错误");
                        }
                    }
                });
            },
            //保存
            save : function() {

                var data = [];

                var floorArr = $("#floorDiv .row");
                for(var i=0; i<floorArr.length; i++){

                    var floorJson = {
                        houseId : "${houseId}",
                        name : "楼层类型"+(i+1),
                        tranArr : []
                    };

                    var transverseArr = $(floorArr[i]).find("[name=transverseGroup]");
                    for(var j=0; j<transverseArr.length; j++){
                        var imageId = $(transverseArr[j]).find("[name=transverseImageId]").val();
                        var unitId = $(transverseArr[j]).find("[name=unitId]").val();
                        var roomNo = $(transverseArr[j]).find("[name=roomNo]").val();
                        var transverseJson = {
                            imageId : imageId,
                            unitId : unitId,
                            roomNo : roomNo
                        };
                        floorJson.tranArr.push(transverseJson);
                    }

                    data.push(floorJson);
                }

                $.post("${contextPath}/admin/house/floor/save",{'data':JSON.stringify(data)},function(result){
                    if(result.status == 0){
                        <%--window.location.href = "${contextPath}/admin/house/index";--%>
                    }else{
                        $leoman.alertMsg(result.msg);
                    }
                });
            },
            //添加锚点
            editLabel : function(self){
                var imageId = $(self).parent().find("[name=transverseImageId]").val();
                window.location.href = "${contextPath}/admin/label/edit/${houseId}_"+imageId;
            },
            back : function(){
                window.location.href = "${contextPath}/admin/house/index";
            }
        }
    }
    $(function () {
        $houseFloor.fn.init();
    })
</script>
</body>
</html>
