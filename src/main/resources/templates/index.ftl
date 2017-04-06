<#import "/spring.ftl" as spring/>

<html ng-app='app'>
	<head>
		<title>Index Demo</title>
		<link href="/css/bootstrap.min.css" rel="stylesheet"/>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/angular1.5.8.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>
		<script src="/js/phaser.min.js"></script>
	</head>
    <body ng-controller='demo'>
		<div class='container'> 
		
			<div class='row'>
				<div id='myCarousel' class='carousel slide col-md-6' data-ride='carousel'>
					<ol class='carousel-indicators'>
						<li class='' data-target='#myCarousel' data-slide-to='0'></li>
						<li data-target='#myCarousel' data-slide-to='1'></li>
						<li data-target='#myCarousel' data-slide-to='2'></li>
					</ol>
					
					<div class='carousel-inner' role="listbox">
						<#list silder as s>
							<div class='item <#if s.tag=="silder1.jpg">active</#if>'>
								<img src="${s.path}" height='200px'>
								<div class='carousel-caption'>
									<h3>${s.tag}</h3>
									<p>${s.descript}</p>
								</div>
							</div>
						</#list>
					</div>
				</div>
				<div class='col-md-6' id='pharse-example'>
					
				</div>
			</div>
			
			<@spring.message "user.admin"/> <br>
			<@spring.messageText  "user.adb","Default" /> <br>
			<@spring.url "/index" /> <br>
			<@spring.message "user.hi"/> <br>
			<h2>Hello Rick!</h2>
			<div>
				<input type='text' class='form-control col-md-3' ng-model='txt' />
				<button class='btn' ng-click='doAjax()'>DoAjax</button>
				<button class='btn' ng-click='doAjax2()'>DoAjax2</button>
				<br>{{yes}}<br>
			</div>
			<br>
			${another}
			<br>
			${pub.toString()}
			
			<div>
				<form id='myform' action='<@spring.url "/test2" />' method='post'>
					<input type='text' name='id' ng-model='myform.id'/>
					<input type='text' name='name' ng-model='myform.user'/>
					<input type='text' name='age' ng-model='myform.age'/>
					<input type='text' name='links' value='TT1'>
					<input type='text' name='links' value='TT2'>
					<button type='submit' class='btn' name='submit'>submit</button>
				</form>
			</div>
			
			<div>
				<form id='myform' action='<@spring.url "/upload" />' method='post' enctype="multipart/form-data">
					<input type='file' name='atta' multiple>
					<button type='submit' class='btn' name='upload'>Upload</button>
				</form>
			</div>
			
			<#if test='123456789'>abc</#if><br>
			<#if test='99999'>99999</#if><br>
			${test}<br>
			{{t}}
			<br>
			<#list lang as l>
				${l}<br>
			</#list>
			hihihi
			<span>test</span>hihihi
			<br>
			
			<div class='row'>
				<#list files as file>
					<div class='col-md-3 thumbnail'>
						${file.getName()}
						<img src='/Upload/${file.getName()}'/>
					</div>
				</#list>
			</div>
			
		</div>
    </body>
	<style>
	.carousel-inner > .item > img {
		width:1000px;
		height:360px;
	}
	</style>
	<script>
		console.log("99dd");
		var app = angular.module("app",[]);
		app.controller("demo",Demo);
		
		function Demo($scope,$http){
			$scope.t = "testMsg";
			$scope.link = ["1","2","3","4","5"];
			$scope.myform = {
				id:"6",
				user:"abccc",
				age:"22",
			}
			pharseGame();
			$scope.doAjax = function(){
				$http({
					method:'POST',
					url:'<@spring.url "/test" />',
					data:$.param({tick:$scope.txt,id:"5"}),	//to serial data or must using file_get_contents to get post data
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				}).then(function success(msg){
					console.log(msg.data);
					$scope.yes = msg.data.data;
				},function error(err,status,headers,config){
					console.log(err);
				});
			}
			
			$scope.doAjax2 = function(){
				var test = {0:"5",1:"6"};
				$http({
					method:'POST',
					url:'<@spring.url "/testEntityModel" />',
					//why to bind viewmodel with java =>1. $("#myform").serialize(); 2. javascript object with param
					data:$.param({id:$scope.myform.id,name:$scope.myform.user,age:$scope.myform.age,links:test}),//$("#myform").serialize() //to serial data or must using file_get_contents to get post data
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}//{'Content-type': 'application/json'} //{'Content-Type': 'application/x-www-form-urlencoded'}
				}).then(function success(msg){
					console.log(msg.data);
					$scope.yes = msg.data.data;
				},function error(err,status,headers,config){
					console.log(err);
				});
			}
			
			
		}
		
		$.ajax({
			url:"/doajax",
			type:"post",
			data:{user:"uuuu"},
			success:function(msg){
				console.log(msg);
			},
			error:function(xhr,status,e){
				console.log(e);
			}
		})
		
		function pharseGame(){
			var sprite;
			var weapon;
			var cursors;
			var fireButton;
			var game = new Phaser.Game(800, 600, Phaser.CANVAS, 'phaser-example', {
				preload: preload,
				create: create,
				update:update,
				render:render
			});
			function preload() {
				//  載入一張圖片, 將名稱命名為 pikachu
				game.load.image('bullet', '/Phaser/sprites/bullet.png');
				game.load.image('ship', '/Phaser/sprites/shmup-ship.png');
			}
			
			function create() {
				//  加入一個 Sprite, 影像來源就是一開始載入的圖片
				weapon = game.add.weapon(30,'bullet');
				weapon.bulletKillType = Phaser.Weapon.KILL_WORLD_BOUNDS;//bullet killed when outside bounds
				weapon.bulletAngleOffset = 90;//rotation
				weapon.bulletSpeed = 400;//speed
				weapon.fireRate = 60;
				sprite = this.add.sprite(320,500,'ship');
				game.physics.arcade.enable(sprite);
				
				weapon.trackSprite(sprite, 14, 0);//bullet follow ship horizon 14px, 0 vertical
				cursors = this.input.keyboard.createCursorKeys();
				fireButton = this.input.keyboard.addKey(Phaser.KeyCode.SPACEBAR);
			}
			
			function update(){
				sprite.body.velocity.x = 0;
				if (cursors.left.isDown){
					sprite.body.velocity.x = -200;
				}else if (cursors.right.isDown){
					sprite.body.velocity.x = 200;
				}
				if (fireButton.isDown){
					weapon.fire();
				}
			}
			
			function render(){
				weapon.debug();
			}
			
		}
		
		
	</script>
	
</html>

