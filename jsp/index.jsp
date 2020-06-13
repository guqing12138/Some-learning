<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<head>
    <!-- Basic page needs
    ============================================ -->
    <title></title>
    <meta charset="utf-8">
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="Magentech">
    <meta name="robots" content="index, follow" />
   
    <!-- Mobile specific metas
    ============================================ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <!-- Favicon
    ============================================ -->
    <link rel="shortcut icon" type="image/png" href="ico/favicon-16x16.png">
  
   
    <!-- Libs CSS
    ============================================ -->
    <link rel="stylesheet" href="css/bootstrap/css/bootstrap.min.css">
    <link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="js/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="js/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="css/themecss/lib.css" rel="stylesheet">
    <link href="js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
    <link href="js/minicolors/miniColors.css" rel="stylesheet">
    
    <!-- Theme CSS
    ============================================ -->
    <link href="css/themecss/so_searchpro.css" rel="stylesheet">
    <link href="css/themecss/so_megamenu.css" rel="stylesheet">
    <link href="css/themecss/so-categories.css" rel="stylesheet">
    <link href="css/themecss/so-listing-tabs.css" rel="stylesheet">
    <link href="css/themecss/so-category-slider.css" rel="stylesheet">
    <link href="css/themecss/so-newletter-popup.css" rel="stylesheet">

    <link href="css/footer/footer1.css" rel="stylesheet">
    <link href="css/header/header1.css" rel="stylesheet">
    <link id="color_scheme" href="css/theme.css" rel="stylesheet"> 
    <link href="css/responsive.css" rel="stylesheet">

     <!-- Google web fonts
    ============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700' rel='stylesheet' type='text/css'>     
    <style type="text/css">
         body{font-family:'Poppins', sans-serif;}
    </style>
    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
    	function deletegoods(obj){
    		//alert(obj);
    		var url="DeleteGoodsNumber_ShoppingCarAction?gidto.goodsid="+obj;
    		$.ajax({
					type : 'get',
					url : 	url,
					success : function(data){
						/*var goodsid = "#goodsprice";
						var sc = JSON.parse(data);
						for(i=0;i<sc.length;i++){
							$(goodsid+i).html(sc[i].userGoodsNumber);
						};*/
						//alert(data);
						$().refreshShoppingCar();
					},
					error : function(){
						alert("服务器请求失败");
					}
				});
    	}
    	
    	$(function(){
    				//刷新购物车
		    		$.fn.refreshShoppingCar=function(){
					$.ajax({
					type : 'post',
					url : 	'ShoppongCarAction',
					dataType:"json",
					success : function(data){
						//alert("yes!!!");
						var sc = JSON.parse(data);
						var ht = "";
						$("#ShoppingCarList").html("");
						//alert(data);
						if(sc!=null){
						$("#checkshoppingcar").css("display","");
						for(i=0;i<sc.length;i++){
							ht = "";
							ht = ht + "<tr>";
							ht = ht + "<td class='text-center' style='width:70px'>";
							ht = ht + "<a href='ProductAction?gidto.goodsid="+sc[i].goodsid+"'><img src='"+sc[i].goodsPicture+"' style='width:70px'"+
							" alt='"+sc[i].goodsName+"' title='"+sc[i].goodsName+"' class='preview'></a>";
							ht = ht + "</td>";
							ht = ht + "<td class='text-left'> <a class='cart_product_name' "+
							"href='ProductAction?gidto.goodsid="+sc[i].goodsid+"'>"+sc[i].goodsName+"</a> </td>";
							ht = ht + "<td class='text-center' id='goodsprice"+i+"'>x1</td>";
							ht = ht + "<td class='text-center'>"+sc[i].goodsprice+"</td>";
							ht = ht + "<td class='text-right'><a href='ProductAction?gidto.goodsid="+sc[i].goodsid+"' class='fa fa-edit'></a>";
							ht = ht + "</td>";
							ht = ht + "<td class='text-right'><a onclick='deletegoods("+sc[i].goodsid+")' class='fa fa-times fa-delete' id='"+sc[i].goodsid+"'></a>";
							ht = ht + "</td></tr>";
							$("#ShoppingCarList").append(ht);
						}
						refreshgoodsnumber();
					}
					else{
						$("#checkshoppingcar").css("display","none");
						$("#ShoppingCarList").html("购物车为空");
					}
					},
					error:function(){
						alert("服务器请求失败");
					} 
				
				});
				};
				
			function refreshgoodsinfo(){
			$.ajax({
				type : 'post',
				url : 	'allGoodsreturnjison',
				dataType:"json",
				success : function(data){
					
					var sc = JSON.parse(data);
					//alert(sc[1].goodsnumber)
					for(i=0;i<sc.length;i++){
						//alert($(goodsid+i).html());
						
						$("#goodsnumber"+sc[i].goodsid).text(sc[i].goodsnumber)
						
						
					};
				},
				error : function(){
					alert("获取商品库存失败:服务器请求失败");
				}
				
			});
			
			
			};
			
    		function refreshgoodsnumber(){
    		refreshgoodsinfo();
    		//alert("进入函数");
			$.ajax({
				type : 'post',
				url : 	'SelectGoodsNumber_ShoppingCarAction',
				dataType:"json",
				success : function(data){
					//alert(data)
					var goodsid = "#goodsprice";
					var sc = JSON.parse(data);
					//alert(sc)
					for(i=0;i<sc.length;i++){
						//alert($(goodsid+i).html());
						$(goodsid+i).html(sc[i].userGoodsNumber);
						//alert($("#goodsnumber").text());
						
						
					};
				},
				error : function(){
					alert("获取商品数目失败:服务器请求失败");
				}
				
			});
			
			//alert("执行完毕");
		};
    	
    	});
    </script>
</head>


<body class="common-home res layout-1">
<s:action name="GoodsIndexAction" executeResult="true"/>
	<s:if test="#session.Goods==null">
		<s:action name="GoodsIndexAction" executeResult="true"/>
	</s:if>
    <!-- Header Container  -->
    <header id="header" class=" typeheader-1">
        
        <!-- Header Top -->
        <div class="header-top hidden-compact">
            <div class="container">
                <div class="row">
                    <div class="header-top-left col-lg-7 col-md-8 col-sm-6 col-xs-4">
                        <div class="hidden-md hidden-sm hidden-xs welcome-msg"><font color="#FF0000">欢迎来到万药斋网上药店！</font><span>提前预祝2020年新年快乐~！</span> </div>
                        <ul class="top-link list-inline hidden-lg ">
                            <li class="account" id="my_account">
                                <a href="#" title="账号 " class="btn-xs dropdown-toggle" data-toggle="dropdown"> <span class="hidden-xs">账号 </span>  <span class="fa fa-caret-down"></span>
                                </a>
                                <ul class="dropdown-menu ">
                                    <li><a href="Register.jsp"><i class="fa fa-user"></i> 注册</a></li>
                                    <li><a href="UserLogin.jsp"><i class="fa fa-pencil-square-o"></i> 登录</a></li>
                                </ul>
                            </li>
                        </ul>            
                    </div>
                    <div class="header-top-right collapsed-block col-lg-5 col-md-4 col-sm-6 col-xs-8">
                        <ul class="top-link list-inline lang-curr">
                            <li class="currency">
                                <div class="btn-group currencies-block">
                            </li>   
                            <li class="language">
                                <div class="btn-group languages-block ">
                                    <form action="index.jsp" method="post" enctype="multipart/form-data" id="bt-language">
                                        <a class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                            <img src="image/catalog/flags/gb.png" alt="English" title="English">
                                            <span class="">Chinese</span>
                                            <span class="fa fa-angle-down"></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a href="index.jsp"><img class="image_flag" src="image/catalog/flags/gb.png" alt="English" title="English" /> Chinese </a></li>
                                           
                                        </ul>
                                    </form>
                                </div>
                                
                            </li>
                        </ul>
                        

                        
                    </div>
                </div>
            </div>
        </div>
        <!-- //Header Top -->

        <!-- Header center -->
        <div class="header-middle">
            <div class="container">
                <div class="row">
                    <!-- Logo -->
                    <div class="navbar-logo col-lg-2 col-md-3 col-sm-4 col-xs-12">
                        <div class="logo"><a href="index.jsp"><img src="image/catalog/logo.png" title="Your Store" alt="Your Store" /></a></div>
                    </div>
                    <!-- //end Logo -->

                    
                    <!-- Search -->
                    <div class="col-lg-7 col-md-6 col-sm-5">
                        <div class="search-header-w">
                            <div class="icon-search hidden-lg hidden-md hidden-sm"><i class="fa fa-search"></i></div>                                
                              
                            <div id="sosearchpro" class="sosearchpro-wrapper so-search ">
                                <form method="GET" action="index.jsp">
                                    <div id="search0" class="search input-group form-group">
                                        <div class="select_category filter_type  icon-select hidden-sm hidden-xs">
                                            <select class="no-border" name="category_id" id="category_id">
                                                <option value="">所有产品分类 </option>
                                                <option value="78">中西药品</option>
                                                <option value="77">营养保健</option>
                                                <option value="82">维生素钙</option>
                                                <option value="80">隐形眼镜</option>
                                                <option value="81">医疗器械、健康电器</option>
                                                <option value="79">美妆护肤</option>
                                                <option value="20">成人用品</option>
                                                <option value="76">母婴专区</option>
                                                <option value="26">参茸花茶</option>
                                                <option value="27">体检、口腔诊疗</option>
                                            </select>
                                        </div>

                                        <input id="keyValue" class="autosearch-input form-control" type="text" value="" size="50" autocomplete="off" placeholder="搜索..." name="search">
                                
                                        <button type="button" class="button-search btn" name="submit_search" id="search"><i class="fa fa-search" ></i></button>
                                    
                                    </div>
                                    <input type="hidden" name="route" value="product/search" />
                                </form>
                            </div>
                        </div>  
                    </div>
                    
                    <!-- 搜索商品表单 -->
                    <form action="GoToSelectGoods" id="searchGoods">
                    	<input type="hidden" value="" name="category_id" id="category_id_submit">
                    	<input type="hidden" value="" name="keyValue" id="keyValue_submit">
                    	<input type="hidden" value="" name="sort" id="sort">
                    	<input type="hidden" value="1" name="startPage" id="startPage">
                    	<input type="hidden" value="5" name="PageSize" id="PageSize">
                    </form>
                    
                    <!-- //end Search -->
                                      <!-- 购物车 -->
                    <div class="middle-right col-lg-3 col-md-3 col-sm-3">                  
                        <!--cart-->
                        <div class="shopping_cart">
                            <div id="cart" class="btn-shopping-cart">

                                <a data-loading-text="Loading... " class="btn-group top_cart dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                    <div class="shopcart">
                                        <span class="icon-c">
                                <i class="fa fa-shopping-bag"></i>
                              </span>
                                        <div class="shopcart-inner">
                                            <p class="text-shopping-cart">
                                                购物车
                                            </p>

                                            <span class="total-shopping-cart cart-total-full">
                                   <span class="items_cart">02</span><span class="items_cart2"> item(s)</span><span class="items_carts">(888元 )</span>
                                            </span>
                                        </div>
                                    </div>
                                </a>
								
                                <ul class="dropdown-menu pull-right shoppingcart-box" role="menu">
                                <s:if test="#session.user==null">
									<li><p><a class="btn" href="UserLogin.jsp"><i></i>请先登录!!!</a></p></li>
								</s:if>
								<s:else>
                                    <li>
                                        <table class="table table-striped">
                                            <tbody id="ShoppingCarList">
                                                <tr>
                                                    <td class="text-center" style="width:70px">
                                                        <a href="product.html">
                                                            <img src="image/catalog/demo/product/80/1.jpg" style="width:70px" alt="Yutculpa ullamcon" title="Yutculpa ullamco" class="preview">
                                                        </a>
                                                    </td>
                                                    <td class="text-left"> <a class="cart_product_name" href="product.html">猴头菇提取物颗粒（无糖）</a> 
                                                    </td>
                                                    <td class="text-center">x1</td>
                                                    <td class="text-center">￥39.00</td>
                                                    <td class="text-right">
                                                        <a href="product.html" class="fa fa-edit"></a>
                                                    </td>
                                                    <td class="text-right">
                                                        <a onclick="cart.remove('2');" class="fa fa-times fa-delete"></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-center" style="width:70px">
                                                        <a href="product.html">
                                                            <img src="image/catalog/demo/product/80/3.jpg" style="width:70px" alt="Xancetta bresao" title="Xancetta bresao" class="preview">
                                                        </a>
                                                    </td>
                                                    <td class="text-left"> <a class="cart_product_name" href="product.html">硝苯地平控释片</a> 
                                                    </td>
                                                    <td class="text-center">x1</td>
                                                    <td class="text-center">￥49.00</td>
                                                    <td class="text-right">
                                                        <a href="product.html" class="fa fa-edit"></a>
                                                    </td>
                                                    <td class="text-right">
                                                        <a onclick="cart.remove('1');" class="fa fa-times fa-delete"></a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </li>
                                    <li>
                                       <!-- 无图片 --> <div>
                                            <!--  <table class="table table-bordered">
                                                <tbody>
                                                    <tr>
                                                        <td class="text-left"><strong>感冒灵胶囊</strong>
                                                        </td>
                                                        <td class="text-right">￥22.00</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left"><strong>复方氨酚烷胺片</strong>
                                                        </td>
                                                        <td class="text-right">￥15.00</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left"><strong>布洛芬缓释胶囊</strong>
                                                        </td>
                                                        <td class="text-right">￥24.00</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left"><strong>抗病毒口服液</strong>
                                                        </td>
                                                        <td class="text-right">￥23.00</td>
                                                    </tr>
                                                </tbody>
                                            </table>-->
                                        
                                            <p class="text-right" id="checkshoppingcar"> <a class="btn view-cart" href="myinfo.jsp">个人中心</a> <a class="btn view-cart" href="ShoppingCarListAction"><i class="fa fa-shopping-cart"></i>查看购物车</a>
                                            </p>
                                        </div>
                                    </li>
                                    </s:else>
                                </ul> 
                            </div>

                        </div>
                        <!--//cart-->

                        <ul class="wishlist-comp hidden-md hidden-sm hidden-xs">
                            <li class="compare hidden-xs"><a href="#" class="top-link-compare" title="商品比较 "><i class="fa fa-refresh"></i></a>
                            </li>
                            <li class="wishlist hidden-xs"><a href="#" id="wishlist-total" class="top-link-wishlist" title="愿望清单 "><i class="fa fa-heart"></i></a>
                            </li>
                        </ul>

                                            
                        
                    </div>
                
                </div>

            </div>
        </div>
        <!-- //Header center -->

        <!-- Header Bottom -->
       <div class="header-bottom hidden-compact">
            <div class="container">
                <div class="row">
                    
                    <div class="bottom1 menu-vertical col-lg-2 col-md-3 col-sm-3">
                        <div class="responsive so-megamenu megamenu-style-dev ">
                            <div class="so-vertical-menu ">
                                <nav class="navbar-default">    
                                    
                                    <div class="container-megamenu vertical">
                                        <div id="menuHeading">
                                            <div class="megamenuToogle-wrapper">
                                                <div class="megamenuToogle-pattern">
                                                    <div class="container">
                                                        <div>
                                                            <span></span>
                                                            <span></span>
                                                            <span></span>
                                                        </div>
                                                        所有类别                          
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                     
                                        <div class="navbar-header">
                                            <button type="button" id="show-verticalmenu" data-toggle="collapse" class="navbar-toggle">      
                                                <i class="fa fa-bars"></i>
                                                <span>  All Categories     </span>
                                            </button>
                                        </div>
                                        <div class="vertical-wrapper" >
                                            <span id="remove-verticalmenu" class="fa fa-times"></span>
                                            <div class="megamenu-pattern">
                                                <div class="container-mega">
                                                    <ul class="megamenu">
                                                        <li class="item-vertical  with-sub-menu hover">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                <img src="image/catalog/menu/icons/ico10.png" alt="icon">
                                                                <span>中医药品</span>
                                                                <b class="fa-angle-right"></b>
                                                            </a>
                                                            <div class="sub-menu" data-subwidth="60"  >
                                                                <div class="content" >
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="row">
                                                                                <div class="col-md-4 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li>
                                                                                                <a href="#"  class="main-menu">男科疾病</a>
                                                                                                <ul>
                                                                                                    <li><a href="#" >阳痿早泄</a></li>
                                                                                                    <li><a href="#" >男性不育症</a></li>
                                                                                                    <li><a  href="#" >前列腺炎</a></li>
                                                                                                    <li><a href="#" > 肾病</a></li>
                                                                                                    <li><a href="#" >泌尿系统疾病</a></li>
                                                                                                    <li><a href="#" >补肾</a></li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#"  class="main-menu">滋补调养</a>
                                                                                                <ul>
                                                                                                    <li><a href="#" >补血补气</a></li>
                                                                                                    <li><a href="#" >补肾壮阳</a></li>
                                                                                                    <li><a href="#" >减肥瘦身</a></li>
						    <li><a href="#" >增强抵抗力</a></li>
						    <li><a href="#" >安神助眠</a></li>
                                                                                                    <li><a href="#" >免疫调节</a></li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-4 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li>
                                                                                                <a href="#"  class="main-menu">心脑血管</a>
                                                                                                <ul>
                                                                                                    <li><a href="#" >高血压</a></li>
                                                                                                    <li><a href="#" >脑血管病</a></li>
                                                                                                    <li><a href="#" >冠心病</a></li>
                                                                                                     <li><a href="#" >高血脂</a></li>
                                                                                                    <li><a href="#" >静脉曲张</a></li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#" class="main-menu">神经系统</a>
                                                                                                <ul>
                                                                                                    <li><a href="#" >抑郁症</a></li>
                                                                                                    <li><a href="#" >癫痫</a></li>
                                                                                                    <li><a href="#" >帕金森</a></li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-4 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li>
                                                                                                 <a href="#"  class="main-menu">肝胆科</a>
                                                                                                <ul>
                                                                                                    <li><a href="#" onclick="window.location ='18_46';">乙肝</a></li>
                                                                                                    <li><a href="#" onclick="window.location ='24_64';">保肝护肝</a></li>
                                                                                                    <li><a href="#" onclick="window.location = '18_45';">胆结石</a></li>
                                                                                                    <li><a href="#" onclick="window.location = '18_30';">免疫调节</a></li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="item-vertical">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                <img src="image/catalog/menu/icons/ico1.png" alt="icon">
                                                                <span>隐形眼镜</span>
                                                                
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical  style1 with-sub-menu hover">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                <span class="label"></span>
                                                                <img src="image/catalog/menu/icons/ico9.png" alt="icon">
                                                                <span>营养保健</span>
                                                                 
                                                                <b class="fa-angle-right"></b>
                                                            </a>
                                                            <div class="sub-menu" data-subwidth="40" >
                                                                <div class="content">
                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <div class="row">
                                                                                <div class="col-md-12 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li><a href="#" class="main-menu">维生素</a>
                                                                                                <ul>
                                                                                                    <li><a href="#">阿胶</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">软骨素</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">益生菌</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">辅酶Q10</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">蛋白粉</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li><a href="#" class="main-menu">妇婴保健</a>
                                                                                                <ul>
                                                                                                    <li><a href="#">鱼肝油</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">奶粉</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">儿童钙片</a>
                                                                                                    </li>
                                                                                                    <li><a href="#">备孕食品</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="row banner">
                                                                                <a href="#">
                                                                                    <img src="image/catalog/menu/megabanner/vbanner1.jpg" alt="banner1">
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        <li class="item-vertical with-sub-menu hover">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico7.png" alt="icon">
                                                                <span>维生素钙</span>
                                                                <b class="fa-angle-right"></b>
                                                            </a>
                                                            <div class="sub-menu" data-subwidth="60" >
                                                                <div class="content" >
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <div class="row">
                                                                                <div class="col-md-4 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li>
                                                                                               <a href="#" class="main-menu">维生素</a>
                                                                                                <ul>
                                                                                                    <li><a href="#" >维生素E</a></li>
                                                                                                    <li><a href="#" >复合维生素</a></li>
                                                                                                    <li><a href="#" >维生素B</a></li>
                                                                                                    <li><a href="#" >孕妇维生素</a></li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="24" onclick="window.location = '24';" class="main-menu">钙剂</a>
                                                                                                <ul>
                                                                                                    <li>
                                                                                                        <a href="#" >碳酸钙</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >复合钙</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >氨糖钙</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#">液体钙</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-4 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li>
                                                                                                <a href="#"  class="main-menu">热销品牌</a>
                                                                                                <ul>
                                                                                                    <li>
                                                                                                        <a href="#">钙尔奇</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >汤臣倍健</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >善存</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#">斯利安</a>
                                                                                                    </li><li>
                                                                                                        <a href="#" >Swisse</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >金施尔康</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li>
                                                                                                 <a href="#"  class="main-menu">常见症状</a>
                                                                                                <ul>
                                                                                                    <li>
                                                                                                        <a href="#" >骨质疏松</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >小儿挑食</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >预防感冒</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >提高免疫</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >孕期补充</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-4 static-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                            <li>
                                                                                              <a href="#" class="main-menu">热销商家</a>
                                                                                                <ul>
                                                                                                    <li>
                                                                                                        <a href="#" >恩百官方旗舰店</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >汤臣倍健官方旗舰店</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >海倍全球购</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >香港益安宁海外旗舰店</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#" class="main-menu">矿物质</a>
                                                                                                <ul>
                                                                                                    <li>
                                                                                                        <a href="#" >锌&amp;铁</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >镁&amp;硒</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" >复合矿物质</a>
                                                                                                    </li>
                                                                                                    <li>
                                                                                                        <a href="#" > 进口矿物质</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="item-vertical css-menu with-sub-menu hover">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                
                                                                 <img src="image/catalog/menu/icons/ico6.png" alt="icon">
                                                                <span>医疗器械</span>
                                                                <b class="fa-angle-right"></b>
                                                            </a>
                                                            <div class="sub-menu" data-subwidth="20">
                                                                <div class="content" >
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="row">
                                                                                <div class="col-sm-12 hover-menu">
                                                                                    <div class="menu">
                                                                                        <ul>
                                                                                           <li>
                                                                                                <a href="#" class="main-menu">检测器材</a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#" class="main-menu">家庭常备药</a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#" class="main-menu">康复理疗仪</a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#" class="main-menu">呼吸道用具</a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="#" class="main-menu">辅助器材</a>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="item-vertical">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico5.png" alt="icon">
                                                                <span>美妆护肤</span>
                                                                
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico4.png" alt="icon">
                                                                <span>成人用品</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico3.png" alt="icon">
                                                                <span>母婴专区</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical" >
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                <img src="image/catalog/menu/icons/ico2.png" alt="icon">
                                                                <span>参茸花茶</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical" >
                                                            <p class="close-menu"></p>
                                                            
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico1.png" alt="icon">
                                                                <span>休闲零食</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical" style="display: none;">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico11.png" alt="icon">
                                                                <span>体检诊疗</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical" style="display: none;">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico12.png" alt="icon">
                                                                <span>健康电器</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical" style="display: none;">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico9.png" alt="icon">
                                                                <span>口腔诊疗</span>
                                                            </a>
                                                        </li>
                                                        <li class="item-vertical" style="display: none;">
                                                            <p class="close-menu"></p>
                                                            <a href="#" class="clearfix">
                                                                 <img src="image/catalog/menu/icons/ico6.png" alt="icon">
                                                                <span>热销产品</span>
                                                            </a>
                                                        </li>
                                                       
                                                        <li class="loadmore">
                                                            <i class="fa fa-plus-square-o"></i>
                                                            <span class="more-view">推荐</span>
                                                        </li>
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </nav>
                            </div>
                        </div>

                    </div>
                    
                    <!-- Main menu -->
                    <div class="main-menu-w col-lg-10 col-md-9">
                        <div class="responsive so-megamenu megamenu-style-dev">
                            <nav class="navbar-default">
                                <div class=" container-megamenu  horizontal open ">
                                    <div class="navbar-header">
                                        <button type="button" id="show-megamenu" data-toggle="collapse" class="navbar-toggle">
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                        </button>
                                    </div>
                                    
                                    <div class="megamenu-wrapper">
                                        <span id="remove-megamenu" class="fa fa-times"></span>
                                        <div class="megamenu-pattern">
                                            <div class="container-mega">
                                                <ul class="megamenu" data-transition="slide" data-animationtime="250">
                                                    <li class="home hover">
                                                        <a href="index.jsp">主页<b class="caret"></b></a>
                                                        <div class="sub-menu" style="width:100%;" >
                                                            <div class="content" >
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <a href="index.jsp" class="image-link"> 
                                                                            <span class="thumbnail">
                                                                                <img class="img-responsive img-border" src="image/catalog/menu/home-1.jpg" alt="">
                                                                                
                                                                            </span> 
                                                                            <h3 class="figcaption">默认主页布局</h3> 
                                                                        </a> 
                                                                        
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <a href="#" class="image-link"> 
                                                                            <span class="thumbnail">
                                                                                <img class="img-responsive img-border" src="image/catalog/menu/home-2.jpg" alt="">
                                                                               
                                                                            </span> 
                                                                            <h3 class="figcaption">主页布局2</h3> 
                                                                        </a> 
                                                                        
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <a href="#" class="image-link"> 
                                                                            <span class="thumbnail">
                                                                                <img class="img-responsive img-border" src="image/catalog/menu/home-3.jpg" alt="">
                                                                               
                                                                            </span> 
                                                                            <h3 class="figcaption">主页布局3</h3> 
                                                                        </a> 
                                                                        
                                                                    </div>
                                                                  
                                                                    
                                                                    <!-- <div class="col-md-15">
                                                                        <a href="#" class="image-link"> 
                                                                            <span class="thumbnail">
                                                                                <img class="img-responsive img-border" src="image/demo/feature/comming-soon.png" alt="">
                                                                                
                                                                            </span> 
                                                                            <h3 class="figcaption">Comming soon</h3> 
                                                                        </a> 
                                                                        
                                                                    </div> -->
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="with-sub-menu hover">
                                                        <p class="close-menu"></p>
                                                        <a href="#" class="clearfix">
                                                            <strong>今日限时购</strong>
                                                            <img class="label-hot" src="image/catalog/menu/new-icon.png" alt="icon items">
                                                            <b class="caret"></b>
                                                        </a>
                                                        <div class="sub-menu" style="width: 100%; right: auto;">
                                                            <div class="content" >
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <div class="column">
                                                                           <a href="#" class="title-submenu">家庭常备药</a>
                                                                            <div>
                                                                                <ul class="row-list">
                                                                                    <li><a href="GoToSelectGoods?category_id=感冒发烧">感冒发烧</a></li>
                                                                                    <li><a href="#">皮炎藓症</a></li>
                                                                                    <li><a href="#">腹泻</a></li>
                                                                                    <li><a href="#">胃炎</a></li>
                                                                                    <li><a href="#">鼻炎</a></li>
                                                                                    <li><a href="#">保肝护肝</a></li>
                                                                                </ul>
                                                                                
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <div class="column">
                                                                            <a href="#" class="title-submenu">专科用药</a>
                                                                            <div>
                                                                                <ul class="row-list">
                                                                                    <li><a href="product.html">风湿类风湿</a></li>
                                                                                    <li><a href="#">高血压</a></li>
                                                                                    <li><a href="#">哮喘</a></li>
                                                                                    <li><a href="#">糖尿病</a></li>
                                                                                    <li><a href="#">关节炎</a></li>
                                                                                    <!-- <li><a href="product-v3.html">Image size - small</a></li> -->
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <div class="column">
                                                                            <a href="#" class="title-submenu">滋补保健</a>
                                                                            <div>
                                                                                <ul class="row-list">
                                                                                    <li><a href="#">改善睡眠</a></li>
                                                                                    <li><a href="#">蛋白质粉</a></li>
                                                                                    <li><a href="#">氨糖钙片</a></li>
                                                                                    <li><a href="#">成人益生菌</a></li>
                                                                                
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <div class="column">
                                                                            <a href="#" class="title-submenu">维生素钙</a>
                                                                            <div>
                                                                                <ul class="row-list">
                                                                                    <li><a href="#">维生素B</a></li>
                                                                                    <li><a href="#">叶酸</a></li>
                                                                                    <li><a href="#">复合维生素</a></li>
                                                                                    <li><a href="#">复合矿物质</a></li>
                                                                                    <li><a href="#">钙剂</a></li>
                                                                                    <li><a href="#">维生素AD</a></li>
                                                                                    <li><a href="#">维生素E</a></li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="with-sub-menu hover">
                                                        <p class="close-menu"></p>
                                                        <a href="#" class="clearfix">
                                                            <strong>在线咨询</strong>
                                                            <b class="caret"></b>
                                                        </a>
                                                        <div class="sub-menu" style="width: 40%; ">
                                                            <div class="content" >
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <ul class="row-list">
                                                                            <li><a class="subcategory_item" href="#">心脑血管</a></li>
                                                                            <li><a class="subcategory_item" href="#">皮肤性病</a></li>
                                                                            <li><a class="subcategory_item" href="#">滋补保健</a></li>
                                                                            <li><a class="subcategory_item" href="#">消化科</a></li>
                                                                            <li><a class="subcategory_item" href="#">肝胆科</a></li>
                                                                            <li><a class="subcategory_item" href="#">男科</a></li>
                                                                            <li><a class="subcategory_item" href="#">妇科</a></li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <ul class="row-list">
                                                                            <li><a class="subcategory_item" href="#">风湿骨科</a></li>
                                                                            <li><a class="subcategory_item" href="#">神经科</a></li>
                                                                            <li><a class="subcategory_item" href="about-us-3.html">糖尿病</a></li>
                                                                            <li><a class="subcategory_item" href="about-us-4.html">消化科</a></li>
                                                                            <li><a class="subcategory_item" href="#">耳鼻喉科</a></li>
                                                                            <li><a class="subcategory_item" href="#">呼吸科</a></li>
                                                                            <li><a class="subcategory_item" href="#">散光验配</a></li>
                                                                            <li><a class="subcategory_item" href="#">医疗器械</a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="with-sub-menu hover">
                                                        <p class="close-menu"></p>
                                                        <a href="#" class="clearfix">
                                                            <strong>热门推荐</strong>
                                                            <img class="label-hot" src="image/catalog/menu/hot-icon.png" alt="icon items">
                                                  
                                                            <b class="caret"></b>
                                                        </a>
                                                        <div class="sub-menu" style="width: 100%; display: none;">
                                                            <div class="content">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <div class="row">
                                                                            <div class="col-md-3 img img1">
                                                                                <a href="#"><img src="image/catalog/menu/megabanner/image-1.jpg" alt="banner1"></a>
                                                                            </div>
                                                                            <div class="col-md-3 img img2">
                                                                                <a href="#"><img src="image/catalog/menu/megabanner/image-2.jpg" alt="banner2"></a>
                                                                            </div>
                                                                            <div class="col-md-3 img img3">
                                                                                <a href="#"><img src="image/catalog/menu/megabanner/image-3.jpg" alt="banner3"></a>
                                                                            </div>
                                                                            <div class="col-md-3 img img4">
                                                                                <a href="#"><img src="image/catalog/menu/megabanner/image-4.jpg" alt="banner4"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <a href="#" class="title-submenu">医疗器械</a>
                                                                        <div class="row">
                                                                            <div class="col-md-12 hover-menu">
                                                                                <div class="menu">
                                                                                    <ul>
                                                                                        <li><a href="#"  class="main-menu">拜耳血糖仪试纸</a></li>
                                                                                        <li><a href="#"  class="main-menu">强生血糖试纸</a></li>
                                                                                        <li><a href="#"  class="main-menu">诺斯清鼻腔喷雾</a></li>
                                                                                        <li><a href="#"  class="main-menu"> 小林退热贴</a></li>
                                                                                        <li><a href="#"  class="main-menu"> 颈椎治疗仪</a></li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <a href="#" class="title-submenu">母婴专区</a>
                                                                        <div class="row">
                                                                            <div class="col-md-12 hover-menu">
                                                                                <div class="menu">
                                                                                    <ul>
                                                                                        <li><a href="#"  class="main-menu">合生元</a></li>
                                                                                        <li><a href="#"  class="main-menu">纽曼思</a></li>
                                                                                        <li><a href="#"  class="main-menu">澳臻</a></li>
                                                                                        <li><a href="#"  class="main-menu">喜宝</a></li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <a href="#" class="title-submenu">维生素钙</a>
                                                                        <div class="row">
                                                                            <div class="col-md-12 hover-menu">
                                                                                <div class="menu">
                                                                                    <ul>
                                                                                        <li><a href="#"  class="main-menu">钙尔奇</a></li>
                                                                                        <li><a href="#"  class="main-menu">爱乐维</a></li>
                                                                                        <li><a href="#"  class="main-menu">金施尔康</a></li>
                                                                                        <li><a href="#"  class="main-menu">养生堂</a></li>
                                                                                        <li><a href="#"  class="main-menu">哈药</a></li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <a href="#" class="title-submenu">营养保健</a>
                                                                        <div class="row">
                                                                            <div class="col-md-12 hover-menu">
                                                                                <div class="menu">
                                                                                    <ul>
                                                                                        <li><a href="#"  class="main-menu">汤臣倍健</a></li>
                                                                                        <li><a href="#"  class="main-menu">同仁堂</a></li>
                                                                                        <li><a href="#"  class="main-menu">康恩贝</a></li>
                                                                                        <li><a href="#"  class="main-menu">合生元</a></li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    
                                                    <li class="">
                                                        <p class="close-menu"></p>
                                                        <a href="#" class="clearfix">
                                                            <strong>附件</strong>
                                         
                                                        </a>
                                            
                                                    </li>
                                                    <li class="">
                                                        <p class="close-menu"></p>
                                                        <a href="other/single.html" class="clearfix">
                                                            <strong>药品小视频</strong>
                                                            <span class="label"></span>
                                                        </a>
                                                    </li>
                                                </ul>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </div>
                    </div>
                    <!-- //end Main menu -->
                                      
                    <div class="bottom3">                        
                        <div class="telephone hidden-xs hidden-sm hidden-md">
                            <ul class="blank"> 
                               <li><a href="myorder.jsp"><i class="fa fa-truck"></i>跟踪你的订单</a></li> 
                               <li><a href="#"><i class="fa fa-phone-square"></i>热线电话：12345</a></li> 
                            </ul>
                        </div>  
                        <div class="signin-w hidden-md hidden-sm hidden-xs">
                        <s:if test="#session.user==null">
                            <ul id="login_index" class="signin-link blank" >                            
                                <li class="log login"><i class="fa fa-lock"></i> <a class="link-lg" href="UserLogin.jsp" id="mylogin">登录 </a> or <a href="Register.jsp" id="myregist">注册</a></li>                                
                            </ul>
                         </s:if>
                         <s:else>            
                              	欢迎登录,<s:property value="#session.user.userAccount"/>    <a id="userexit" href="ExitAction">退出 </a>                         
                          </s:else>                     
                        </div>                 
                    </div>
                    
                </div>
            </div>

        </div>
    </header>
    <!-- //Header Container  -->
    
   
<!-- Main Container  -->
<div class="main-container container">
    <div id="content">
        <div class="content-top-w">
            
            <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 main-left">
                <div class="module col1 hidden-sm hidden-xs"></div>
            </div>    
            <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 main-right">
                <div class="slider-container row"> 
                                
                    <div class="col-lg-9 col-md-12 col-sm-12 col-xs-12 col2">
                        <div class="module sohomepage-slider ">
                            <div class="yt-content-slider"  data-rtl="yes" data-autoplay="no" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1"  data-items_column3="1" data-items_column4="1" data-arrows="no" data-pagination="yes" data-lazyload="yes" data-loop="no" data-hoverpause="yes">
                                <div class="yt-content-slide">
                                    <a href="#"><img src="image/catalog/slideshow/home1/slider-1.jpg" alt="slider1" class="img-responsive"></a>
                                </div>
                                <div class="yt-content-slide">
                                    <a href="#"><img src="image/catalog/slideshow/home1/slider-2.jpg" alt="slider2" class="img-responsive"></a>
                                </div>
                                <div class="yt-content-slide">
                                    <a href="#"><img src="image/catalog/slideshow/home1/slider-3.jpg" alt="slider3" class="img-responsive"></a>
                                </div>
                            </div>
                            
                            <div class="loadeding"></div>
                        </div>
                        
                    </div>

                    
                    <div class="col-lg-3 col-md-12 col-sm-12 col-xs-12 col3">
                        <div class="module product-simple extra-layout1">
                            <h3 class="modtitle">
                                <span>畅销</span>
                            </h3>
                            <div class="modcontent">
                                <div id="so_extra_slider_1" class="so-extraslider" >
                                    <!-- Begin extraslider-inner -->
                                    <div class="yt-content-slider extraslider-inner" data-rtl="yes" data-pagination="yes" data-autoplay="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1" data-items_column3="1" data-items_column4="1" data-arrows="no" data-lazyload="yes" data-loop="no" data-buttonpage="top">
                                        <div class="item ">
                                        	<s:iterator value="#session['Goods']" var="goods" status="st" begin="0" end="3">
                                        		<div class="product-layout item-inner style1 ">
                                                <div class="item-image">
                                                    <div class="item-img-info">
                                                        <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="${goods.goodsName} ">
                                                            <img src=${goods.goodsPicture} alt="Mandouille short">
                                                            </a>
                                                    </div>
                                                    
                                                </div>
                                                <div class="item-info">
                                                    <div class="item-title">
                                                        <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="${goods.goodsName} ">${goods.goodsName}</a>
                                                    </div>
                                                    <div class="rating">
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                    </div>
                                                    <div class="content_price price">
                                                        <span class="price-new product-price">${goods.goodsprice}</span>&nbsp;&nbsp;

                                                        <span class="price-old">${goods.goodsprice}</span>&nbsp;

                                                    </div>
                                                </div>
                                               </div>
                                        	</s:iterator> 
                                        </div>
                                        
                                        <div class="item ">
                                            <s:iterator value="#session['Goods']" var="goods" status="st" begin="4" end="6">
                                        		<div class="product-layout item-inner style1 ">
                                                <div class="item-image">
                                                    <div class="item-img-info">
                                                        <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="${goods.goodsName} ">
                                                            <img src=${goods.goodsPicture} alt="Mandouille short">
                                                            </a>
                                                    </div>
                                                    
                                                </div>
                                                <div class="item-info">
                                                    <div class="item-title">
                                                        <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="${goods.goodsName} ">${goods.goodsName}</a>
                                                    </div>
                                                    <div class="rating">
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                    </div>
                                                    <div class="content_price price">
                                                        <span class="price-new product-price">${goods.goodsprice}</span>&nbsp;&nbsp;

                                                        <span class="price-old">${goods.goodsprice}</span>&nbsp;

                                                    </div>
                                                </div>
                                               </div>
                                        	</s:iterator>
                                                
                                            <!-- End item-wrap -->
                                        </div>
                                    </div>
                                    <!--End extraslider-inner -->
                                </div>
                            </div>
                        </div>
                    </div>                
                </div>
            </div>                                        
        </div>
        <div class="row content-main-w">
            
            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 main-left">
                
                <div class="module">
                    <div class="banners banners2">
                        <div class="banner">
                            <a href="#"><img src="image/catalog/banners/banner1.jpg" alt="image"></a>
                        </div>
                    </div>
                </div>

                <div class="module product-simple extra-layout1">
                    <h3 class="modtitle">
                        <span>最新上架</span>
                    </h3>
                    <div class="modcontent">
                        <div id="so_extra_slider_1" class="so-extraslider" >
                            <!-- Begin extraslider-inner -->
                            <div class="yt-content-slider extraslider-inner" data-rtl="yes" data-pagination="yes" data-autoplay="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1" data-items_column3="1" data-items_column4="1" data-arrows="no" data-lazyload="yes" data-loop="no" data-buttonpage="top">
                                <div class="item ">
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="product.html" target="_self" title="Mandouille short "><img src="image/catalog/demo/product/80/5.jpg" alt="Mandouille short"></a>
                                            </div>                                        
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="product.html" target="_self" title="Mandouille short">Mandouille short </a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price-new product-price">$55.00 </span>&nbsp;&nbsp;

                                                <span class="price-old">$76.00 </span>&nbsp;

                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="product.html" target="_self" title="Xancetta bresao "><img src="image/catalog/demo/product/80/3.jpg" alt="Xancetta bresao"></a>
                                            </div>
                                            
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="product.html" target="_self" title="Xancetta bresao">Xancetta bresao</a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price-new product-price">$80.00 </span>&nbsp;&nbsp;

                                                <span class="price-old">$89.00 </span>&nbsp;



                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="product.html" target="_self" title="Sausage cowbee "><img src="image/catalog/demo/product/80/4.jpg" alt="Sausage cowbee"></a>
                                            </div>
                                           
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="product.html" target="_self" title="Sausage cowbee">Sausage cowbee</a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                            </div>
                                           
                                            <div class="content_price price">
                                                <span class="price product-price">$66.00</span>
                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="product.html" target="_self" title="Chicken swinesha "><img src="image/catalog/demo/product/80/7.jpg" alt="Chicken swinesha"></a>
                                            </div>
                                           
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="product.html" target="_self" title="Chicken swinesha">
                                                            Chicken swinesha 
                                                        </a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack">
                                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                                </span>
                                                <span class="fa fa-stack">
                                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                                </span>
                                                <span class="fa fa-stack">
                                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                                </span>
                                                <span class="fa fa-stack">
                                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                                </span>
                                                <span class="fa fa-stack">
                                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                                </span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price-new product-price">$45.00 </span>&nbsp;&nbsp;

                                                <span class="price-old">$56.00 </span>&nbsp;



                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                </div>
                                <div class="item ">
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="#" target="_self" title="Qeserunt shortloin ">
                                                <img src="${session.Goods[5].goodsPicture}" alt="Qeserunt shortloin">
                                                </a>
                                            </div>
                                           
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="#" target="_self" title="Qeserunt shortloin">
                                        ${session.Goods[5].goodsName}
                                    </a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack">
                                        <i class="fa fa-star fa-stack-2x"></i>
                                    </span>
                                                <span class="fa fa-stack">
                                        <i class="fa fa-star fa-stack-2x"></i>
                                    </span>
                                                <span class="fa fa-stack">
                                        <i class="fa fa-star fa-stack-2x"></i>
                                    </span>
                                                <span class="fa fa-stack">
                                        <i class="fa fa-star fa-stack-2x"></i>
                                    </span>
                                                <span class="fa fa-stack">
                                        <i class="fa fa-star fa-stack-2x"></i>
                                    </span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price product-price">
                                            ${session.Goods[5].goodsprice}
                                        </span>
                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="#" target="_self" title="Consecte quichuck ">
                                                <img src="image/catalog/demo/product/80/3.jpg" alt="Consecte quichuck">
                                                </a>
                                            </div>
                                            
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="#" target="_self" title="Consecte quichuck">
                                        Consecte quichuck 
                                    </a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack">
                                            <i class="fa fa-star fa-stack-2x"></i>
                                        </span>
                                                <span class="fa fa-stack">
                                            <i class="fa fa-star fa-stack-2x"></i>
                                        </span>
                                                <span class="fa fa-stack">
                                            <i class="fa fa-star fa-stack-2x"></i>
                                        </span>
                                                <span class="fa fa-stack">
                                            <i class="fa fa-star fa-stack-2x"></i>
                                        </span>
                                                <span class="fa fa-stack">
                                            <i class="fa fa-star fa-stack-2x"></i>
                                        </span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price-new product-price">$55.00 </span>&nbsp;&nbsp;

                                                <span class="price-old">$61.00 </span>&nbsp;



                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="#" target="_self" title="Neatball bresaola ">
                                            <img src="image/catalog/demo/product/80/6.jpg" alt="Neatball bresaola">
                                            </a>
                                            </div>
                                            
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="#" target="_self" title="Neatball bresaola">
                                        Neatball bresaola 
                                    </a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack">
                                                <i class="fa fa-star fa-stack-2x"></i>
                                            </span>
                                                <span class="fa fa-stack">
                                                <i class="fa fa-star fa-stack-2x"></i>
                                            </span>
                                                <span class="fa fa-stack">
                                                <i class="fa fa-star fa-stack-2x"></i>
                                            </span>
                                                <span class="fa fa-stack">
                                                <i class="fa fa-star fa-stack-2x"></i>
                                            </span>
                                                <span class="fa fa-stack">
                                                <i class="fa fa-star fa-stack-2x"></i>
                                            </span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price-new product-price">$65.00 </span>&nbsp;&nbsp;

                                                <span class="price-old">$71.00 </span>&nbsp;



                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                    <div class="product-layout item-inner style1 ">
                                        <div class="item-image">
                                            <div class="item-img-info">
                                                <a href="#" target="_self" title="Yutculpa ullamco ">
                                                <img src="image/catalog/demo/product/80/8.jpg" alt="Yutculpa ullamco">
                                                </a>
                                            </div>
                                            
                                        </div>
                                        <div class="item-info">
                                            <div class="item-title">
                                                <a href="#" target="_self" title="Yutculpa ullamco">
                                                    Yutculpa ullamco 
                                                </a>
                                            </div>
                                            <div class="rating">
                                                <span class="fa fa-stack">
                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                </span>
                                                <span class="fa fa-stack">
                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                </span>
                                                <span class="fa fa-stack">
                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                </span>
                                                <span class="fa fa-stack">
                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                </span>
                                                <span class="fa fa-stack">
                                                    <i class="fa fa-star fa-stack-2x"></i>
                                                </span>
                                            </div>
                                            <div class="content_price price">
                                                <span class="price-new product-price">$60.00 </span>&nbsp;&nbsp;

                                                <span class="price-old">$77.00 </span>&nbsp;



                                            </div>
                                        </div>
                                        <!-- End item-info -->
                                        <!-- End item-wrap-inner -->
                                    </div>
                                    <!-- End item-wrap -->
                                </div>
                            </div>
                            <!--End extraslider-inner -->
                        </div>
                    </div>
                </div>

                <div class="module">
                    <div class="policy-w">
                        <a href="#"><img src="image/catalog/banners/call-us.jpg" alt="image"></a>
                        <ul class="block-infos">
                            <li class="info1">
                              <div class="inner">
                              <i class="fa fa-file-text-o"></i>
                              <div class="info-cont">
                              <a href="#">免费送货y</a>
                              <p>订单满10元</p>
                              </div>
                              </div>
                            </li>
                            <li class="info2">
                              <div class="inner">
                              <i class="fa fa-shield"></i>
                              <div class="info-cont">
                              <a href="#">订单保护</a>
                              <p>安全信息</p>
                              </div>
                              </div>
                            </li>
                            <li class="info3">
                              <div class="inner">
                              <i class="fa fa-gift"></i>
                              <div class="info-cont">
                              <a href="#">促销礼品</a>
                              <p>特别优惠</p>
                              </div>
                              </div>
                            </li>
                            <li class="info4">
                              <div class="inner">
                              <i class="fa fa-money"></i>
                              <div class="info-cont">
                              <a href="#">退款</a>
                              <p>30天内退货</p>
                              </div>
                              </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="module extra">
                    <h3 class="modtitle">
                        <span>推荐</span>
                    </h3>
                    <div class="modcontent">
                        <div id="so_extra_slider_1" class="so-extraslider" >
                            <!-- Begin extraslider-inner -->
                            <div class="products-list yt-content-slider extraslider-inner" data-rtl="yes" data-pagination="yes" data-autoplay="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1" data-items_column3="1" data-items_column4="1" data-arrows="no" data-lazyload="yes" data-loop="no" data-buttonpage="top">
                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                
                                                <div class="product-image-container second_img">
                                                    <a href="product.html" target="_self" title="Duis aute irure ">
                                                        <img src="image/catalog/demo/product/270/e10.jpg" class="img-1 img-responsive" alt="image1">
                                                        <img src="image/catalog/demo/product/270/e7.jpg" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="#" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="cart.add('60 ');">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                <div class="caption hide-cont">
                                                    <div class="rating">    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">Duis aute irure </a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">$48.00</span>

                                                </p>
                                            </div>

                                            
                                        </div>
                                    </div>      
                                </div>

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                
                                                <div class="product-image-container second_img">
                                                    <a href="product.html" target="_self" title="Excepteur sint occ">
                                                        <img src="image/catalog/demo/product/270/f5.jpg" class="img-1 img-responsive" alt="image1">
                                                        <img src="image/catalog/demo/product/270/f6.jpg" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="#" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="cart.add('60 ');">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                <div class="caption hide-cont">
                                                    <div class="rating">    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">Excepteur sint occ</a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">$90.00</span>
                                        
                                                </p>
                                            </div>

                                        </div>
                                    </div>      
                                </div>

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                               
                                                <div class="product-image-container second_img">
                                                    <a href="product.html" target="_self" title="Cenison meatloa">
                                                        <img src="image/catalog/demo/product/270/e3.jpg" class="img-1 img-responsive" alt="image1">
                                                        <img src="image/catalog/demo/product/270/e4.jpg" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="#" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="cart.add('60 ');">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                <div class="caption hide-cont">
                                                    <div class="rating">    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">Cenison meatloa</a></h4>
                                                    
                                                </div>
                                                <p class="price">$42.00</p>
                                            </div>
                                           
                                        </div>
                                    </div>      
                                </div>
                            </div>
                            <!--End extraslider-inner -->
                        </div>
                    </div>
                </div>

                <div class="module so-latest-blog blog-sidebar">

                    <h3 class="modtitle"><span>最新上架</span></h3>
                    <div class="modcontent clearfix">

                        <div class="so-blog-external buttom-type1 button-type1">
                            <div class="blog-external-simple">
                                <div class="cat-wrap">
                                    <div class="media">

                                        <div class="item item-1">
                                            <div class="media-left">
                                                <a href="#" target="_self">
                                                <img src="image/catalog/blog/1.jpg" alt="Biten demons lector in henderit in vulp" class="media-object">
                                                </a>
                                            </div>
                                            <div class="media-body">
                                                <h4 class="media-heading">
                                                <a href="#" title="Biten demons lector in henderit in vulp" target="_self">丹参酮胶囊</a>
                                                </h4>
                                                <div class="media-content">
                                                    <div class="media-date-added"><i class="fa fa-calendar"></i> December 4th, 2017</div>         
                                                    <div class="media-subcontent">
                                                    <span class="media-comment"><i class="fa fa-comments"></i>0  Comment</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                         
                                <div class="cat-wrap">
                                    <div class="media">

                                        <div class="item item-2">
                                            <div class="media-left">
                                                <a href="#" target="_self">
                                                    <img src="image/catalog/blog/2.jpg" alt="Commodo laoreet semper tincidun sit" class="media-object">
                                                </a>
                                            </div>
                                            <div class="media-body">
                                                <h4 class="media-heading">
                                                <a href="#" title="Commodo laoreet semper tincidun sit" target="_self">丹参酮胶囊2</a>
                                                </h4>
                                                <div class="media-content">
                                                    <div class="media-date-added"><i class="fa fa-calendar"></i> November 15th, 2017</div>          
                                                    <div class="media-subcontent">
                                                        <span class="media-comment"><i class="fa fa-comments"></i>0  Comment</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                          
                            </div>
                        </div>

                    </div>
                </div>
                
                <div class="module testimonials">
                    <h3 class="modtitle"><span>专家</span></h3>
                    <div class="slider-testimonials">
                        <div class="yt-content-slider contentslider" data-rtl="no" data-loop="yes" data-autoplay="no" data-autoheight="no" data-autowidth="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="1" data-items_column0="1" data-items_column1="1" data-items_column2="1" data-items_column3="1" data-items_column4="1" data-arrows="no" data-pagination="yes" data-lazyload="yes" data-hoverpause="yes">
                            <div class="item">
                                <div class="img"><img src="image/catalog/demo/client/user-1.jpg" alt="Image"></div>
                                <div class="name">秋季养生</div>
                                <p>“使志安宁，以缓秋刑，收敛神气，使秋气平，无外其志，使肺气清，此秋气之应，此养收之道也。”</p>          
                            </div>
                            <div class="item">
                                <div class="img"><img src="image/catalog/demo/client/user-2.jpg" alt="Image"></div>
                                <div class="name">春季养生</div>
                                <p>“一日之计在于晨,一年之计在于春”,春季,生机蓬勃,是人体机能、新陈代谢最活跃的时期。所以,春季也是一年中的“养生黄金期”</p>          
                            </div>
                            <div class="item">
                                <div class="img"><img src="image/catalog/demo/client/user-3.jpg" alt="Image"></div>
                                <div class="name">夏季养生</div>
                                <p>“夏季是阳气最盛的季节,气候炎热而生机旺盛。此时是新陈代谢的时期,阳气外发,伏阴在内,气血运行亦相应地旺盛起来,活跃于机体表面”</p>          
                            </div>
                        </div>
                    </div>
                </div>
                

                <div class="module">
                    <div class="banners banners5">
                        <div class="banner">
                          <a href="#"><img src="image/catalog/banners/banner2.jpg" alt="image"></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-10 col-md-9 col-sm-8 col-xs-12 main-right">
                

                <div class="static-cates">
                    <ul>
                        <li>
                            <a href="#"><img src="image/catalog/banners/cat1.jpg" alt="image"></a>
                        </li>
                        <li>
                            <a href="#"><img src="image/catalog/banners/cat2.jpg" alt="image"></a>
                        </li>
                        <li>
                            <a href="#"><img src="image/catalog/banners/cat3.jpg" alt="image"></a>
                        </li>
                        <li>
                            <a href="#"><img src="image/catalog/banners/cat4.jpg" alt="image"></a>
                        </li>
                        <li>
                            <a href="#"><img src="image/catalog/banners/cat5.jpg" alt="image"></a>
                        </li>
                    </ul>
                </div>

                <!-- Deals -->
                <div class="module deals-layout1">
                    <div class="head-title">
                        <div class="modtitle">
                            <span>抢购</span>
                            <div class="cslider-item-timer">
                              <div class="product_time_maxprice">
                                
                                <div class="item-time">
                                  <div class="item-timer">
                                    <div class="defaultCountdown-30"></div>
                                  </div>
                                </div>
                              </div>
                            </div>
                              
                              <a class="viewall" href="�route=product�special.html">View All</a>
                            
                        </div>    
                    </div>
                    <div class="modcontent">
                        <div id="so_deal_1" class="so-deal style1">
                            <div class="extraslider-inner products-list yt-content-slider" data-rtl="yes" data-autoplay="no" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="30" data-items_column00="6" data-items_column0="5" data-items_column1="3" data-items_column2="2"  data-items_column3="2" data-items_column4="1" data-arrows="yes" data-pagination="no" data-lazyload="yes" data-loop="yes" data-hoverpause="yes">
                            <s:iterator value="#session['Goods']" var="goods" status="st" begin="0" end="10">

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                <div class="box-label">
                                                    <span class="label-product label-sale" id="goodsnumber${goods.goodsid}">${goods.goodsnumber}</span>
                                                    
                                                </div>
                                                <div class="product-image-container second_img">
                                               
                                                    <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="Pastrami bacon">
                                                        <img src="${goods.goodsPicture}" class="img-1 img-responsive" alt="image1">
                                                        <img src="${goods.goodsPicture}" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="ProductAction?gidto.goodsid=${goods.goodsid}" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="addcart(${goods.goodsid})">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                
                                                <div class="caption hide-cont">
                                                    <div class="ratings">
                                                        <div class="rating-box">
                                                        
                                                        
														   
														   <s:iterator begin="1" end="#goods.goodsremark" status="st">
														   <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>   
														   </s:iterator>
														   <s:iterator begin="#goods.goodsremark" end="4" status="st">	  
														   <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>  
														   </s:iterator>
														
                                                          
                                                          
                                                           
                                                        </div>
                                                        <span class="rating-num"><s:property value="#goods.goodsremark"/></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">${goods.goodsName}</a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">${goods.goodsprice}</span>
                                                  <s:set value="#goods.goodsprice" var="arc"></s:set>
                                                  <span class="price-old" ></span>
                                                </p>
                                            </div>

                                            <div class="item-available">
                                                <div class="available">
                                                  <span class="color_width" data-title="77%" data-toggle='tooltip' style="width: 77%"></span>
                                                </div>                          
                                                <p class="a2">Sold: <b>${goods.goodsSale}</b>  </p>
                                            </div>
                                        </div>
                                    </div>      
                                </div>
                                </s:iterator>

                               

                            </div>
                        </div>
                      </div>
                </div>
                <!-- End Deals -->

                <!-- Banners -->
                <div class="banners3 banners">
                    <div class="item1">
                        <a href="#"><img src="image/catalog/banners/banner3.jpg" alt="image"></a>
                    </div>
                    <div class="item2">
                        <a href="#"><img src="image/catalog/banners/banner4.jpg" alt="image"></a>
                    </div>
                    <div class="item3">
                        <a href="#"><img src="image/catalog/banners/banner5.jpg" alt="image"></a>
                    </div>
                </div>
                <!-- end Banners -->

                <!-- Category Slider 1 -->
                <div id="so_category_slider_1" class="so-category-slider container-slider module cateslider1">
                    <div class="modcontent">                                                                
                        <div class="page-top">
                            <div class="page-title-categoryslider">家庭常备</div>
                            <div class="item-sub-cat">
                                <ul>
                                    <li><a href="#" title="补血补气" target="_self">补气血</a></li>
                                    <li><a href="#" title="感冒发烧" target="_self">感冒发烧</a></li>
                                    <li><a href="#" title="减肥瘦身" target="_self">减肥</a></li>
                                    <li><a href="#" title="鼻炎" target="_self">鼻炎</a></li>
                                    <li><a href="#" title="胃炎" target="_self">胃炎</a></li>
                                    <li><a href="#" title="青春痘" target="_self">青春痘</a></li>
                                    <li><a href="#" title="眼干眼涩" target="_self">眼干</a></li>
                                    <li><a href="#" title="腹泻" target="_self">腹泻</a></li>
                                    <li><a href="#" title="避孕" target="_self">避孕</a></li>
                                </ul>
                            </div> 
                        </div>

                        <div class="categoryslider-content">
                            <div class="item-cat-image" style="min-height: 351px;">
                                <a href="#" title="Technology" target="_self">
                                  <img class="categories-loadimage" alt="Technology" src="image/catalog/demo/category/tab1.jpg">
                                </a>
                            </div>
                            <div class="slider category-slider-inner products-list yt-content-slider" data-rtl="yes" data-autoplay="no" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="30" data-items_column00="4" data-items_column0="4" data-items_column1="2" data-items_column2="1"  data-items_column3="2" data-items_column4="1" data-arrows="yes" data-pagination="no" data-lazyload="yes" data-loop="yes" data-hoverpause="yes">

                                     <s:iterator value="#session['Goods']" var="goods" status="st" begin="0" end="10">

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                <div class="box-label">
                                                    <span class="label-product label-sale" id="goodsnumber${goods.goodsid}">${goods.goodsnumber}</span>
                                                    
                                                </div>
                                                <div class="product-image-container second_img">
                                               
                                                    <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="Pastrami bacon">
                                                        <img src="${goods.goodsPicture}" class="img-1 img-responsive" alt="image1">
                                                        <img src="${goods.goodsPicture}" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="ProductAction?gidto.goodsid=${goods.goodsid}" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="addcart(${goods.goodsid})">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                
                                                <div class="caption hide-cont">
                                                    <div class="ratings">
                                                        <div class="rating-box">
                                                        
                                                        
														   
														   <s:iterator begin="1" end="#goods.goodsremark" status="st">
														   
														  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span> 
														   
														     
														   </s:iterator>
														   <s:iterator begin="#goods.goodsremark" end="4" status="st">
														   
														  
														   <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>  
														     
														   </s:iterator>
														
                                                           
                                                        </div>
                                                        <span class="rating-num"><s:property value="#goods.goodsremark"/></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">${goods.goodsName}</a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">${goods.goodsprice}</span>
                                                  <s:set value="#goods.goodsprice" var="arc"></s:set>
                                                  <span class="price-old" ></span>
                                                </p>
                                            </div>

                                            <div class="item-available">
                                                <div class="available">
                                                  <span class="color_width" data-title="77%" data-toggle='tooltip' style="width: 77%"></span>
                                                </div>                          
                                                <p class="a2">Sold: <b>${goods.goodsSale}</b>  </p>
                                            </div>
                                        </div>
                                    </div>      
                                </div>
                                </s:iterator>

                                    
                               
                            </div>
                        </div>
                    </div>
                </div>

                <!-- end Category Slider 1 -->

                <!-- Category Slider 2 -->
                <div id="so_category_slider_1" class="so-category-slider container-slider module cateslider2">
                    <div class="modcontent">                                                                
                        <div class="page-top">
                             <div class="page-title-categoryslider">专科用药</div>
                            <div class="item-sub-cat">
                                <ul>
                                    <li><a href="#" title="Smartphone" target="_self">风湿</a></li>
                                    <li><a href="#" title="Tablets" target="_self">抑郁症</a></li>
                                    <li><a href="#" title="Computer" target="_self">冠心病</a></li>
                                    <li><a href="#" title="Accessories" target="_self">乙肝</a></li>
                                    <li><a href="#" title="Hitech" target="_self">高血压</a></li>

                                    <li><a href="#" title="Tablets" target="_self">哮喘</a></li>
                                    <li><a href="#" title="Computer" target="_self">糖尿病</a></li>
                                    <li><a href="#" title="Accessories" target="_self">关节炎</a></li>
                                    <li><a href="#" title="Hitech" target="_self">脱发</a></li>
                                </ul>
                            </div> 
                        </div>

                        <div class="categoryslider-content">
                            <div class="item-cat-image" style="min-height: 351px;">
                                <a href="#" title="Funiture & Decor" target="_self">
                                  <img class="categories-loadimage" alt="Funiture & Decor" src="image/catalog/demo/category/tab2.jpg">
                                </a>
                            </div>
                            <div class="slider category-slider-inner products-list yt-content-slider" data-rtl="yes" data-autoplay="no" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="30" data-items_column00="4" data-items_column0="4" data-items_column1="2" data-items_column2="1"  data-items_column3="2" data-items_column4="1" data-arrows="yes" data-pagination="no" data-lazyload="yes" data-loop="yes" data-hoverpause="yes">

                                     <s:iterator value="#session['Goods']" var="goods" status="st" begin="0" end="10">

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                <div class="box-label">
                                                    <span class="label-product label-sale" id="goodsnumber${goods.goodsid}">${goods.goodsnumber}</span>
                                                    
                                                </div>
                                                <div class="product-image-container second_img">
                                               
                                                    <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="Pastrami bacon">
                                                        <img src="${goods.goodsPicture}" class="img-1 img-responsive" alt="image1">
                                                        <img src="${goods.goodsPicture}" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="ProductAction?gidto.goodsid=${goods.goodsid}" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="addcart(${goods.goodsid})">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                
                                                <div class="caption hide-cont">
                                                    <div class="ratings">
                                                        <div class="rating-box">
                                                        
                                                        
														   
														   <s:iterator begin="1" end="#goods.goodsremark" status="st">
														   
														  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span> 
														   
														     
														   </s:iterator>
														   <s:iterator begin="#goods.goodsremark" end="4" status="st">
														   
														  
														   <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>  
														     
														   </s:iterator>
														
                                                           
                                                        </div>
                                                        <span class="rating-num"><s:property value="#goods.goodsremark"/></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">${goods.goodsName}</a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">${goods.goodsprice}</span>
                                                  <s:set value="#goods.goodsprice" var="arc"></s:set>
                                                  <span class="price-old" ></span>
                                                </p>
                                            </div>

                                            <div class="item-available">
                                                <div class="available">
                                                  <span class="color_width" data-title="77%" data-toggle='tooltip' style="width: 77%"></span>
                                                </div>                          
                                                <p class="a2">Sold: <b>${goods.goodsSale}</b>  </p>
                                            </div>
                                        </div>
                                    </div>      
                                </div>
                                </s:iterator>

                                    
                               
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end Category Slider 2 -->

                <!-- Category Slider 3 -->
                <div id="so_category_slider_1" class="so-category-slider container-slider module cateslider1">
                    <div class="modcontent">                                                                
                        <div class="page-top">
                            <div class="page-title-categoryslider">营养保健</div>
                            <div class="item-sub-cat">
                                <ul>
                                    <li><a href="#" title="Smartphone" target="_self">男性保健</a></li>
                                    <li><a href="#" title="Tablets" target="_self">改善睡眠</a></li>
                                    <li><a href="#" title="Computer" target="_self">保肝护肝</a></li>
                                    <li><a href="#" title="Accessories" target="_self">减肥瘦身</a></li>
                                    <li><a href="#" title="Hitech" target="_self">钙片</a></li>
                                    <li><a href="#" title="Computer" target="_self">维生素</a></li>
                                    <li><a href="#" title="Hitech" target="_self">蛋白质粉</a></li>
                                </ul>
                            </div> 
                        </div>
                        <div class="categoryslider-content">
                            <div class="item-cat-image" style="min-height: 351px;">
                                <a href="#" title="Fashion & Accessories" target="_self">
                                  <img class="categories-loadimage" alt="Fashion & Accessories" src="image/catalog/demo/category/tab3.jpg">
                                </a>
                            </div>
                            <div class="slider category-slider-inner products-list yt-content-slider" data-rtl="yes" data-autoplay="no" data-autoheight="no" data-delay="4" data-speed="0.6" data-margin="30" data-items_column00="4" data-items_column0="4" data-items_column1="2" data-items_column2="1"  data-items_column3="2" data-items_column4="1" data-arrows="yes" data-pagination="no" data-lazyload="yes" data-loop="yes" data-hoverpause="yes">

                                    <s:iterator value="#session['Goods']" var="goods" status="st" begin="0" end="10">

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                <div class="box-label">
                                                    <span class="label-product label-sale" id="goodsnumber${goods.goodsid}">${goods.goodsnumber}</span>
                                                    
                                                </div>
                                                <div class="product-image-container second_img">
                                               
                                                    <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="Pastrami bacon">
                                                        <img src="${goods.goodsPicture}" class="img-1 img-responsive" alt="image1">
                                                        <img src="${goods.goodsPicture}" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="ProductAction?gidto.goodsid=${goods.goodsid}" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="addcart(${goods.goodsid})">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                
                                                <div class="caption hide-cont">
                                                    <div class="ratings">
                                                        <div class="rating-box">
                                                        
                                                        
														   
														   <s:iterator begin="1" end="#goods.goodsremark" status="st">
														   
														  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span> 
														   
														     
														   </s:iterator>
														   <s:iterator begin="#goods.goodsremark" end="4" status="st">
														   
														  
														   <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>  
														     
														   </s:iterator>
														
                                                           
                                                        </div>
                                                        <span class="rating-num"><s:property value="#goods.goodsremark"/></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">${goods.goodsName}</a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">${goods.goodsprice}</span>
                                                  <s:set value="#goods.goodsprice" var="arc"></s:set>
                                                  <span class="price-old" ></span>
                                                </p>
                                            </div>

                                            <div class="item-available">
                                                <div class="available">
                                                  <span class="color_width" data-title="77%" data-toggle='tooltip' style="width: 77%"></span>
                                                </div>                          
                                                <p class="a2">Sold: <b>${goods.goodsSale}</b>  </p>
                                            </div>
                                        </div>
                                    </div>      
                                </div>
                                </s:iterator>
                               
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end Category Slider 3 -->

                <!-- Banners -->
                <div class="banners4 banners">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <a href="#"><img src="image/catalog/banners/bn1.jpg" alt="image"></a>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <a href="#"><img src="image/catalog/banners/bn2.jpg" alt="image"></a>
                        </div>
                    </div>
                </div>
                <!-- end Banners -->

                <!-- Listing tabs -->
                <div class="module listingtab-layout1">
                    
                    <div id="so_listing_tabs_1" class="so-listing-tabs first-load">
                        <div class="loadeding"></div>
                        <div class="ltabs-wrap">
                            <div class="ltabs-tabs-container" data-delay="300" data-duration="600" data-effect="starwars" data-ajaxurl="" data-type_source="0" data-lg="5" data-md="3" data-sm="2" data-xs="1" data-margin="30">
                                <!--Begin Tabs-->
                                <div class="ltabs-tabs-wrap"> 
                                <span class="ltabs-tab-selected">医疗机械、健康电器</span> <span class="ltabs-tab-arrow">▼</span>
                                    <div class="item-sub-cat">
                                        <ul class="ltabs-tabs cf">
                                            <li class="ltabs-tab tab-sel" data-category-id="20" data-active-content=".items-category-20"> <span class="ltabs-tab-label">畅销</span> </li>
                                            <li class="ltabs-tab " data-category-id="18" data-active-content=".items-category-18"> <span class="ltabs-tab-label">新产品</span> </li>
                                            <li class="ltabs-tab " data-category-id="25" data-active-content=".items-category-25"> <span class="ltabs-tab-label">高评分</span> </li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- End Tabs-->
                            </div>
                        
                            <div class="ltabs-items-container products-list grid">
                                <!--Begin Items-->
                                <div class="ltabs-items ltabs-items-selected items-category-20" data-total="16">
                                    <div class="ltabs-items-inner ltabs-slider">
                                        <s:iterator value="#session['Goods']" var="goods" status="st" begin="0" end="10">

                                <div class="item">         
                                    <div class="item-inner product-layout transition product-grid">
                                        <div class="product-item-container">
                                            <div class="left-block left-b">
                                                <div class="box-label">
                                                    <span class="label-product label-sale" id="goodsnumber${goods.goodsid}">${goods.goodsnumber}</span>
                                                    
                                                </div>
                                                <div class="product-image-container second_img">
                                               
                                                    <a href="ProductAction?gidto.goodsid=${goods.goodsid}" target="_self" title="Pastrami bacon">
                                                        <img src="${goods.goodsPicture}" class="img-1 img-responsive" alt="image1">
                                                        <img src="${goods.goodsPicture}" class="img-2 img-responsive" alt="image2">
                                                    </a>
                                                </div>
                                                <!--quickview--> 
                                                <div class="so-quickview">
                                                  <a class="iframe-link btn-button quickview quickview_handler visible-lg" href="ProductAction?gidto.goodsid=${goods.goodsid}" title="Quick view" data-fancybox-type="iframe"><i class="fa fa-eye"></i><span>Quick view</span></a>
                                                </div>                                                     
                                                <!--end quickview-->

                                                
                                            </div>
                                            <div class="right-block">
                                                <div class="button-group so-quickview cartinfo--left">
                                                    <button type="button" class="addToCart" title="Add to cart" onclick="addcart(${goods.goodsid})">
                                                        <span>Add to cart </span>   
                                                    </button>
                                                    <button type="button" class="wishlist btn-button" title="Add to Wish List" onclick="wishlist.add('60');"><i class="fa fa-heart-o"></i><span>Add to Wish List</span>
                                                    </button>
                                                    <button type="button" class="compare btn-button" title="Compare this Product " onclick="compare.add('60');"><i class="fa fa-retweet"></i><span>Compare this Product</span>
                                                    </button>
                                                    
                                                </div>
                                                
                                                <div class="caption hide-cont">
                                                    <div class="ratings">
                                                        <div class="rating-box">
                                                        
                                                        
														   
														   <s:iterator begin="1" end="#goods.goodsremark" status="st">
														   
														  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span> 
														   
														     
														   </s:iterator>
														   <s:iterator begin="#goods.goodsremark" end="4" status="st">
														   
														  
														   <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>  
														     
														   </s:iterator>
														
                                                           
                                                        </div>
                                                        <span class="rating-num"><s:property value="#goods.goodsremark"/></span>
                                                    </div>
                                                    <h4><a href="product.html" title="Pastrami bacon" target="_self">${goods.goodsName}</a></h4>
                                                    
                                                </div>
                                                <p class="price">
                                                  <span class="price-new">${goods.goodsprice}</span>
                                                  <s:set value="#goods.goodsprice" var="arc"></s:set>
                                                  <span class="price-old" ></span>
                                                </p>
                                            </div>

                                            <div class="item-available">
                                                <div class="available">
                                                  <span class="color_width" data-title="77%" data-toggle='tooltip' style="width: 77%"></span>
                                                </div>                          
                                                <p class="a2">Sold: <b>${goods.goodsSale}</b>  </p>
                                            </div>
                                        </div>
                                    </div>      
                                </div>
                                </s:iterator>
                                    </div>
                                    
                                </div>
                                <div class="ltabs-items items-category-18 grid" data-total="16">
                                    <div class="ltabs-loading"></div>
                                    
                                </div>
                                <div class="ltabs-items  items-category-25 grid" data-total="16">
                                    <div class="ltabs-loading"></div>
                                </div>
                                <!--End Items-->
                            </div>
                            
                        </div>   
                    </div>
                </div>
                <!-- end Listing tabs -->
                
                <!-- Slider Brands -->
                <div class="slider-brands col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="yt-content-slider contentslider" data-autoplay="no" data-delay="4" data-speed="0.6" data-margin="0" data-items_column00="7" data-items_column0="7" data-items_column1="5" data-items_column2="3" data-items_column3="2" data-items_column4="1" data-arrows="yes"
                            data-pagination="no" data-lazyload="yes" data-loop="yes">
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b1.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b2.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b3.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b4.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b5.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b6.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b4.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b5.png" alt="brand">
                            </a>
                        </div>
                        <div class="item">
                            <a href="#">
                                <img src="image/catalog/brands/b6.png" alt="brand">
                            </a>
                        </div>
                    </div>
                </div> 
                <!-- Slider Brands -->


            </div>
            
        </div>
        
    </div>
</div>
<!-- //Main Container -->
   
   

    <!-- Footer Container -->
    <footer class="footer-container typefooter-1">
        <!-- Footer Top Container -->
 
            <div class="container">
                <div class="row footer-top">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <div class="socials-w">
                          <h2>Follow socials</h2>
                          <ul class="socials">
                            <li class="facebook"><a href="#" target="_blank"><i class="fa fa-facebook"></i><span>Facebook</span></a></li>
                            <li class="twitter"><a href="#" target="_blank"><i class="fa fa-twitter"></i><span>Twitter</span></a></li>
                            <li class="google_plus"><a href="#" target="_blank"><i class="fa fa-google-plus"></i><span>Google Plus</span></a></li>
                            <li class="pinterest"><a href="#" target="_blank"><i class="fa fa-pinterest"></i><span>Pinterest</span></a></li>
                            <li class="youtube"><a href="#" target="_blank"><i class="fa fa-youtube-play"></i><span>Youtube</span></a></li>
                            <li class="linkedin"><a href="#" target="_blank"><i class="fa fa-linkedin"></i><span>linkedin</span></a></li>
                            <li class="skype"><a href="#" target="_blank"><i class="fa fa-skype"></i><span>skype</span></a></li>
                          </ul>
                        </div>
                        




                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <div class="module newsletter-footer1">
                            <div class="newsletter">

                                <div class="title-block">
                                    <div class="page-heading font-title">
                                        Signup for Newsletter
                                    </div>
                                    
                                </div>

                                <div class="block_content">
                                    <form method="post" id="signup" name="signup" class="form-group form-inline signup send-mail">
                                        <div class="form-group">
                                            <div class="input-box">
                                                <input type="email" placeholder="Your email address..." value="" class="form-control" id="txtemail" name="txtemail" size="55">
                                            </div>
                                            <div class="subcribe">
                                                <button class="btn btn-primary btn-default font-title" type="submit" onclick="return subscribe_newsletter();" name="submit">
                                            Subscribe
                                        </button>
                                            </div>
                                        </div>
                                    </form>


                                </div>
                                <!--/.modcontent-->

                            </div>

                        </div>
                    </div>
                </div>
            </div>
      
        <!-- /Footer Top Container -->
        
        <div class="footer-middle ">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 col-infos">
                        <div class="infos-footer">
                            <a href="#"><img src="image/catalog/logo-footer.png" alt="image"></a>
                            <ul class="menu">
                                <li class="地址">
                                                   中国，湖南省，长沙市，含浦区。
                                </li>
                                <li class="phone">
                                    (+0734)0 155 166 177 - (+0734)177 188 199
                                </li>
                                <li class="邮箱">
                                    <a href="mailto:@445462336qq.com">contact@445462336qq.com</a>
                                </li>
                                <li class="开发时间以及关闭时间是">
                                                           早上8:00-晚上21:00
                                </li>
                            </ul>
                        </div>


                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 col-style">
                        <div class="box-information box-footer">
                            <div class="module clearfix">
                                <h3 class="modtitle">更多</h3>
                                <div class="modcontent">
                                    <ul class="menu">
                                        <li><a href="#">关于我们</a></li>
                                        <li><a href="#">保修和服务</a></li>
                                        <li><a href="#">随时在线</a></li>
                                        <li><a href="#">商品注册</a></li>
                                        <li><a href="#">商品产家</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 col-style">
                        <div class="box-account box-footer">
                            <div class="module clearfix">
                                <h3 class="modtitle">我的账号</h3>
                                <div class="modcontent">
                                    <ul class="menu">
                                        <li><a href="#">品牌</a></li>
                                        <li><a href="#">购物券</a></li>
                                        <li><a href="#">合作商</a></li>
                                        <li><a href="#">特惠商品</a></li>
                                        <li><a href="#">链接</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 col-clear">
                        <div class="box-service box-footer">
                          <div class="module clearfix">
                            <h3 class="modtitle">种类</h3>
                            <div class="modcontent">
                              <ul class="menu">
                                <li><a href="#">中西药品</a></li>
                                <li><a href="#">营养保健</a></li>
                                <li><a href="#">维生素</a></li>
                                <li><a href="#">医疗器械</a></li>
                                <li><a href="#">美妆护肤</a></li>
                                <li><a href="#">母婴专区</a></li>
                              </ul>
                            </div>
                          </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 col-style">
                        <div class="box-service box-footer">
                            <div class="module clearfix">
                                <h3 class="modtitle">服务</h3>
                                <div class="modcontent">
                                    <ul class="menu">
                                        <li><a href="#">联系我们</a></li>
                                        <li><a href="#">返回</a></li>
                                        <li><a href="#">支持</a></li>
                                        <li><a href="#">网页地图</a></li>
                                        <li><a href="#">链接</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 col-style">
                        <div class="box-service box-footer">
                          <div class="module clearfix">
                            <h3 class="modtitle">种类</h3>
                            <div class="modcontent">
                              <ul class="menu">
                                <li><a href="#">中西药品</a></li>
                                <li><a href="#">营养保健</a></li>
                                <li><a href="#">维生素</a></li>
                                <li><a href="#">医疗器械</a></li>
                                <li><a href="#">美妆护肤</a></li>
                                <li><a href="#">母婴专区</a></li>
                              </ul>
                            </div>
                          </div>
                        </div>
                    </div>


                    
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                        <div class="footer-b">
                            <div class="bottom-cont">
                                <a href="#"><img src="image/catalog/demo/payment/pay1.jpg" alt="image"></a>
                                <ul class="footer-links">
                                    <li><a href="#">关于我们</a></li>
                                    <li><a href="#">服务</a></li>
                                    <li><a href="#">私人联系</a></li>
                                    <li><a href="#">地图</a></li>
                                    <li><a href="#">返回</a></li>
                                    <li><a href="#">联系团队</a></li>
                                </ul>  
      
                            </div>
                        </div>
            </div>
        </div>
        <!-- Footer Bottom Container -->
        <div class="footer-bottom">
            <div class="container">
                <div class="col-lg-12 col-xs-12 payment-w">
                <img src="image/catalog/demo/payment/payment.png" alt="imgpayment">
                </div>
            </div>
            <div class="copyright-w">
                <div class="container">
                    <div class="copyright">
                    Copyright &copy; 2018.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
                    </div>
                </div>
            </div>            
        </div>
        <!-- /Footer Bottom Container -->
        
        
            <!--Back To Top-->
        <div class="back-to-top"><i class="fa fa-angle-up"></i></div>
    </footer>
    <!-- //end Footer Container -->

    </div>
   

<!-- End Color Scheme
============================================ -->



<!-- Include Libs & Plugins
============================================ -->
<!-- Placed at the end of the document so the pages load faster -->

<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/owl-carousel/owl.carousel.js"></script>
<script type="text/javascript" src="js/slick-slider/slick.js"></script>
<script type="text/javascript" src="js/themejs/libs.js"></script>
<script type="text/javascript" src="js/unveil/jquery.unveil.js"></script>
<script type="text/javascript" src="js/countdown/jquery.countdown.min.js"></script>
<script type="text/javascript" src="js/dcjqaccordion/jquery.dcjqaccordion.2.8.min.js"></script>
<script type="text/javascript" src="js/datetimepicker/moment.js"></script>
<script type="text/javascript" src="js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/modernizr/modernizr-2.6.2.min.js"></script>
<script type="text/javascript" src="js/minicolors/jquery.miniColors.min.js"></script>

<!-- Theme files
============================================ -->

<script type="text/javascript" src="js/themejs/application.js"></script>

<script type="text/javascript" src="js/themejs/homepage.js"></script>

<script type="text/javascript" src="js/themejs/toppanel.js"></script>
<script type="text/javascript" src="js/themejs/so_megamenu.js"></script>
<script type="text/javascript" src="js/themejs/addtocart.js"></script>  

<!-- 购物车json数据传输 -->
<script type="text/javascript">
		//刷新购物车
		function refreshShoppingCar(){
			$.ajax({
			type : 'post',
			url : 	'ShoppongCarAction',
			dataType:"json",
			success : function(data){
				alert("yes!!!");
				var sc = JSON.parse(data);
				var ht = "";
				$("#ShoppingCarList").html("");
				//alert(data);
				if(sc!=null){
				$("#checkshoppingcar").css("display","");
				for(i=0;i<sc.length;i++){
					ht = "";
					ht = ht + "<tr>";
					ht = ht + "<td class='text-center' style='width:70px'>";
					ht = ht + "<a href='ProductAction?gidto.goodsid="+sc[i].goodsid+"'><img src='"+sc[i].goodsPicture+"' style='width:70px'"+
					" alt='"+sc[i].goodsName+"' title='"+sc[i].goodsName+"' class='preview'></a>";
					ht = ht + "</td>";
					ht = ht + "<td class='text-left'> <a class='cart_product_name' "+
					"href='ProductAction?gidto.goodsid="+sc[i].goodsid+"'>"+sc[i].goodsName+"</a> </td>";
					ht = ht + "<td class='text-center' id='goodsprice"+i+"'>x1</td>";
					ht = ht + "<td class='text-center'>"+sc[i].goodsprice+"</td>";
					ht = ht + "<td class='text-right'><a href='ProductAction?gidto.goodsid="+sc[i].goodsid+"' class='fa fa-edit'></a>";
					ht = ht + "</td>";
					ht = ht + "<td class='text-right'><a onclick='deletegoods("+sc[i].goodsid+")' class='fa fa-times fa-delete' id='"+sc[i].goodsid+"'></a>";
					ht = ht + "</td></tr>";
					$("#ShoppingCarList").append(ht);
				}
				refreshgoodsnumber();
			}
			else{
				$("#checkshoppingcar").css("display","none");
				$("#ShoppingCarList").html("购物车为空");
			}
			},
			error:function(){
				alert("服务器请求失败");
			} 
		
		});
		}
		
		//加入购物车
		function addcart(obj){
			var action_url="AddGoodIntoShoppingCarAction?gidto.goodsnumber=1&gidto.goodsid="+obj;
			$.ajax({
				type : 'get',
				url : 	action_url,
				success : function(data){
					alert(data);
					if(data=="加入购物车成功"){
						//alert("更新购物车");
						$().refreshShoppingCar();		
						//alert("更新完成");
					}
				},
				error : function(){
					alert("服务器请求失败");
				}
			});
    	}
    	
	$(document).ready(function(){
	
		$.ajax({
			type : 'post',
			url : 	'ShoppongCarAction',
			dataType:"json",
			success : function(data){
				//alert("yes!!!");
				var sc = JSON.parse(data);
				var ht = "";
				$("#ShoppingCarList").html("");
				//alert(data);
				if(sc!=null){
				$("#checkshoppingcar").css("display","");
				for(i=0;i<sc.length;i++){
					ht = "";
					ht = ht + "<tr>";
					ht = ht + "<td class='text-center' style='width:70px'>";
					ht = ht + "<a href='ProductAction?gidto.goodsid="+sc[i].goodsid+"'><img src='"+sc[i].goodsPicture+"' style='width:70px'"+
					" alt='"+sc[i].goodsName+"' title='"+sc[i].goodsName+"' class='preview'></a>";
					ht = ht + "</td>";
					ht = ht + "<td class='text-left'> <a class='cart_product_name' "+
					"href='ProductAction?gidto.goodsid="+sc[i].goodsid+"'>"+sc[i].goodsName+"</a> </td>";
					ht = ht + "<td class='text-center' id='goodsprice"+i+"'>x1</td>";
					ht = ht + "<td class='text-center'>"+sc[i].goodsprice+"</td>";
					ht = ht + "<td class='text-right'><a href='ProductAction?gidto.goodsid="+sc[i].goodsid+"' class='fa fa-edit'></a>";
					ht = ht + "</td>";
					ht = ht + "<td class='text-right'><a  onclick='deletegoods("+sc[i].goodsid+")' name='deletegoods' class='fa fa-times fa-delete' id='"+sc[i].goodsid+"'></a>";
					ht = ht + "</td></tr>";
					$("#ShoppingCarList").append(ht);
				}
				refreshgoodsnumber();
			}
			else{
				$("#checkshoppingcar").css("display","none");
				$("#ShoppingCarList").html("购物车为空");
			}
			},
			error:function(){
				alert("载入购物车服务器请求失败");
			} 
		
		});
		
		function refreshgoodsnumber(){
			$.ajax({
				type : 'post',
				url : 	'SelectGoodsNumber_ShoppingCarAction',
				dataType:"json",
				success : function(data){
					var goodsid = "#goodsprice";
					var sc = JSON.parse(data);
					//alert(sc)
					for(i=0;i<sc.length;i++){
						//alert($(goodsid+i).html());
						$(goodsid+i).html("X"+sc[i].userGoodsNumber);
					};
				},
				error : function(){
					alert("获取商品数目失败:服务器请求失败");
				}
			});
			
		};
		
		//搜索商品功能
		$("#search").click(function(){
			//alert("yes!!!");//测试
			var keyValue=$("#keyValue").val();//关键词
			var category_id=$("#category_id").val();//搜索类型
			$("#category_id_submit").val(category_id);
			$("#keyValue_submit").val(keyValue);
			$("#searchGoods").submit();
		});
});
</script>
</body>
