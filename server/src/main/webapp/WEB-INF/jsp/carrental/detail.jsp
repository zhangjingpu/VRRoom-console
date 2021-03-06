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
    <title>Form Layouts</title>
    <style type="text/css">

        .border{
            background-color: #EEE;
            margin:20px 0px 20px 120px;
            width:500px;
            height:160px;
            border:1px solid #CCCCCC;
            -moz-border-radius: 15px;
            -webkit-border-radius: 15px;
            border-radius:15px;
            float: left;
        }
        .pl{
            margin-left: 20px;
            margin-top: 15px;
            font-size: 20px
        }
        .pr{
            margin-right: 20px;
            margin-top: 15px;
            font-size: 20px
        }


    </style>
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
                            订单处理
                        </header>
                        <div class="panel-body">
                            <form class="cmxform form-horizontal adminex-form" id="formId" method="post" >
                                <input id="id" name="id" type="hidden" value="">
                                <header class="panel-heading">
                                    出发信息
                                </header>
                                <div class="form-group" style="margin-top: 15px">
                                    <label for="city" class="col-sm-2 control-label">出发城市</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="city" name="city" value="${carRental.city.name}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="rentalWay" class="col-sm-2 control-label">包车方式</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="rentalWay" name="rentalWay" value="<c:if test="${carRental.rentalWay eq 0}">单程</c:if><c:if test="${carRental.rentalWay eq 1}">返程</c:if><c:if test="${carRental.rentalWay eq 2}">往返</c:if>" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="startPoint" class="col-sm-2 control-label">起点</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="startPoint" name="startPoint" value="${carRental.startPoint}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="endPoint" class="col-sm-2 control-label">终点</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="endPoint" name="endPoint" value="${carRental.endPoint}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="startDate" class="col-sm-2 control-label">出发时间</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="startDate" name="startDate" value="<date:date format='yyyy-MM-dd HH:mm:ss' value='${carRental.startDate}'></date:date>" class="form-control" disabled/>
                                    </div>
                                </div>
                                <c:if test="${carRental.rentalWay eq 2}">
                                    <div class="form-group">
                                        <label for="endDate" class="col-sm-2 control-label">回城时间</label>
                                        <div class="col-sm-6">
                                            <input type="text" id="endDate" name="endDate" value="<date:date format='yyyy-MM-dd HH:mm:ss' value='${carRental.endDate}'></date:date>" class="form-control" disabled/>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="form-group">
                                    <label for="carType" class="col-sm-2 control-label">车型</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="carType" name="carType" value="${carRental.carType.name}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="totalNumber" class="col-sm-2 control-label">总人数</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="totalNumber" name="totalNumber" value="${carRental.totalNumber}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="busNum" class="col-sm-2 control-label">车辆数</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="busNum" name="busNum" value="${carRental.busNum}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="invoice" class="col-sm-2 control-label">发票</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="invoice" name="invoice" value="<c:if test="${carRental.isInvoice eq 0}">无</c:if><c:if test="${carRental.isInvoice eq 1}">有(${carRental.invoice})</c:if>" class="form-control" disabled/>
                                    </div>
                                </div>
                                <header class="panel-heading">
                                    客人信息
                                </header>
                                <div class="form-group" style="margin-top: 15px">
                                    <label for="userName" class="col-sm-2 control-label">用车联系人</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="userName" name="userName" value="${carRental.order.userName}" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="mobile" class="col-sm-2 control-label">联系电话</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="mobile" name="mobile" value="${carRental.order.mobile}" class="form-control" disabled/>
                                    </div>
                                </div>

                                <c:if test="${carRental.order.status ne 0}">
                                    <header class="panel-heading">
                                        车辆信息
                                    </header>
                                    <div style="margin-top: 15px"></div>
                                        <div class="row">
                                            <c:forEach items="${busSend}" var="v">
                                                <div class="col-md-6">
                                                    <div class="border">
                                                        <div style="float: left">
                                                            <p class="pl">车牌号：${v.bus.carNo}</p>
                                                            <p class="pl">座位数：${v.bus.seatNum}</p>
                                                            <p class="pl">司机姓名：${v.bus.driverName}</p>
                                                            <p class="pl">性别：<c:if test="${v.bus.driverSex eq 0}">男</c:if><c:if test="${v.bus.driverSex eq 1}">女</c:if></p>
                                                        </div>
                                                        <div style="float: right">
                                                            <p class="pr">车型：${v.bus.modelNo}</p>
                                                            <p class="pr">品牌：${v.bus.brand}</p>
                                                            <p class="pr">身份证：${v.bus.driverIDCard}</p>
                                                            <p class="pr">联系方式：${v.bus.driverPhone}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    <header class="panel-heading">
                                        报价信息
                                    </header>
                                    <div style="margin-top: 15px"></div>
                                    <c:forEach var="v" items="${carRentalOffer}">
                                        <div class="form-group">
                                            <label for="mobile" class="col-sm-2 control-label">${v.name}</label>
                                            <div class="col-sm-6">
                                                <input type="text" id="offter" name="offter" value="${v.amount}" class="form-control" disabled/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${carRentalOffer ne null}">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">总金额</label>
                                            <div class="col-sm-6">
                                                <input type="text" id="totalAmount" name="totalAmount" value="${totalAmount}" class="form-control" disabled/>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${carRental.order.status eq 4}">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">取消原因</label>
                                            <div class="col-sm-6">
                                                <input type="text" id="unsubscribe" name="unsubscribe" value="${carRental.unsubscribe}" class="form-control" disabled/>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            <%--</div>--%>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"></label>
                                    <div class="col-sm-6">
                                        <button type="button" class="btn btn-primary" onclick="history.go(-1);">返回</button>
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
</section>
<%@ include file="../inc/new2/foot.jsp" %>
<script>
    $admin = {
        v: {
            list: [],
            chart: null,
            dTable: null
        },
        fn: {
            init: function () {
                $("#formId").validate();
            },
        }
    };
    $(function () {
        $admin.fn.init();
    })
</script>
</body>
</html>
