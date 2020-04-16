<!-- <div class="container-fluid" style="padding: 0;">
	<div class="row"> -->
		<div class="col-md-12" id="ss" style="background: white; padding: 15px; position: absolute; bottom: 0;height:50px;">
			<strong> Copyright © 2020 <a href="https://blog.csdn.net/qq_41065415">Chen Xin</a>.
			</strong> All rights reserved.
		</div>
	<!-- </div>
</div> -->
<script type="text/javascript">
	$(function() {
		/*通过改变iframe来改变里面的内容块  */
		function changepath(path) {
			$('iframe').attr('src', path);
		}
		$('.open-menu').on('click', function() {
			$('.glyphicon-menu-down').each(function() {
				$(this).removeClass('glyphicon-menu-down').addClass("glyphicon-menu-left");
			});
			if($(this).children('.pull-right').hasClass('glyphicon-menu-left')){
				$(this).children('.pull-right').removeClass('glyphicon-menu-left').addClass("glyphicon-menu-down");
			}
			else{
				$(this).children('.pull-right').removeClass('glyphicon-menu-down').addClass("glyphicon-menu-left");
			}

			$('.open-menu').each(function() {
				$(this).css("border-left", "3px solid transparent");
			});
			$(this).css("border-left", "3px solid #00a65a");
		});

		$('.right-btn-group').on('click', 'a', function() {

			var gly = $(this).children('button').children().hasClass('glyphicon-minus');
			var child = $(this).children('button').children('.glyphicon');
			if(gly) {
				child.removeClass('glyphicon-minus').addClass('glyphicon-plus');
			} else {
				child.removeClass('glyphicon-plus').addClass('glyphicon-minus');
			}
		});

		//获取右侧内容板的高度；设置面板的高度
		if(window.screen.height<800){
			$('.list-left').height(850);
			$('.list-right').height(850);
		}else{
			$('.list-left').height(window.screen.height-50);
			$('.list-right').height(window.screen.height-50);
		}

		//点击按钮，左侧菜单栏收缩，右侧拉伸过去
		$('.navbar-left li').on('click', function() {

			if($('#smallDiv').css('display') == "none") {
				$('.col-md-2').css('display', 'none');
				$('.col-md-10').removeClass('col-md-10').addClass('col-md-11');
				$('.col-md-11').css('width', '97%');
				$('#smallDiv').css({
					'display': 'block',
					'width': '3%'
				});
				$('.list-left').height($('.list-right').height());
			} else {
				$('#smallDiv').css('display', 'none');
				$('.col-md-2').css('display', 'block');
				$('.col-md-11').removeClass('col-md-11').addClass('col-md-10');
				$('.col-md-10').css('width', '');
				$('.list-left').height($('.list-right').height());
			}
		});
	});
</script>