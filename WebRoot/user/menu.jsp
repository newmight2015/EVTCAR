<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<div id="user-card">
					<div class="inners clearfix without-side">
						<div class="avatar-unit" style="display:none">
							<div class="img"><img src="../pic/user1.jpg">
								<div class="change-avatar">
									<a class="btn wbtn btn12"><span class="text">更换头像</span></a>
									<div style="position: absolute; opacity: 0.01; overflow: hidden;">
										<iframe src="javascript:'<html></html>'" frameborder="no" border="0" name="IFrame_i8i1vmjl" id="IFrame_i8i1vmjl" style="display: none;">
										</iframe>
										<input type="file" name="file" size="1" style="position: absolute; top: 0px; left: 0px; border: 0px;">
									</div>
								</div>
							</div>
							<div class="counts clearfix">
								<a href="/yclovezyw/followers/" rel="nofollow" class="followers">
								<div class="num">0</div><div class="sub">粉丝</div></a>
								<a href="/yclovezyw/following/" class="follows">
								<div class="num">1</div><div class="sub">关注</div></a>
							</div>
						</div>
						<div class="user-inf">
							<div class="head-line"><div class="name">碎步行</div></div>
							<ul class="introduction">
								<li><i class="fa fa-location-arrow"></i>
								<em>来自北京</em></li>
								<li><i class="fa fa-suitcase"></i><em>电动车爱好者</em></li>
							</ul>
							<div class="about clearfix">自从用了乐充，充电从此无忧</div>
						</div>
						<script type="text/javascript">
						$(function(){ 
							 $(".user-inf .head-line .name").html(STATICINFO.USERINFO.name);
						})
						</script>
						<div class="bindings"> 
							<div class="fast-item">
									<a href="userInfMsg.jsp" class="btn">
											<div class="img"><i class="fa fa-calendar fa-3x"></i></div>消息提醒
									</a>
									<a href="userInfOrd.jsp" class="btn">
											<div class="img">	<i class="fa fa-shopping-cart fa-3x"></i></div>预约订单
									</a>
									<a href="" class="btn">
											<div class="img"><i class="fa fa-desktop fa-3x"></i></div>最新活动
									</a>
									<a href="" class="btn">
											<div class="img"><i class="fa fa-credit-card fa-3x"></i></div>我的收藏
									</a>
									
									<a href="userCsSubmit.jsp" class="btn">
											<div class="img"><i class="fa fa-comments fa-3x"></i></div>充电站分享
									</a>
									<a href="../user/UserInfManage.jsp" class="btn without-side">
											<div class="img"><i class="fa fa-info-circle fa-3x"></i></div>更新个人资料
									</a>
							</div>
							<div class="message">
								<ul class="clearfix">
								<!-- 
									<li><i class="fa fa-clock-o"></i>已预约时间：
									<span>80</span>小时
									</li> -->
									<li><i class="fa fa-question-circle"></i>充电地址分享：
									<span>0</span>条
									</li>
									<li><i class="fa fa-pencil"></i>金币：
									<span>80</span>枚
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="user-menu" style="display:none;">
						
						<div class="btn-group l">
							<a href="" class="dropdown-toggle  tab" data-toggle="dropdown" aria-expanded="false">个人信息 <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
							    <li><a href="">基本信息</a></li>
							    <li><a href="">我的订单</a></li>
							    <li><a href="">账户金额</a></li>
							    <li><a href="">充值提现</a></li>
							    <li><a href="">我的金币</a></li>
							 </ul>
						</div>
						<div class="btn-group l">
							<a href="" class="dropdown-toggle  tab" data-toggle="dropdown" aria-expanded="false">客户服务 <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
							    <li><a href="">投诉</a></li>
							    <li><a href="">申诉</a></li>
							    <li><a href="">消息</a></li>
							    <li><a href="">评价</a></li>
							 </ul>
						</div>
						
					</div>
				</div>
				<script>
					$(".fast-item a").click(function(){
						$(this).css("color","green");
					})
					
				</script>