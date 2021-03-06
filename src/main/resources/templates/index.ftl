<#import "/spring.ftl" as spring/>

<html ng-app='app'>
	<head>
		<title>Index Demo</title>
		<link href="/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="/css/loading-bar.css" rel="stylesheet"/>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/angular1.5.8.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>
		<script src="/js/phaser.min.js"></script>
		<script src="/js/loading-bar.js"></script>
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
								<img src="${s.path}" height='200px' class=''>
								<div class='carousel-caption'>
									<h3>${s.tag}</h3>
									<p>${s.descript}</p>
								</div>
							</div>
						</#list>
					</div>
				</div>
				<div class='col-md-6' id='phaser-example'>
					
				</div>
			</div>
			
			<br>
			<div class='row'>
				<ul class="nav nav-tabs">
					<li class="active"><a href="#home" data-toggle="tab">Home</a></li>
					<li><a href="#main1" data-toggle="tab">Menu 1</a></li>
					<li><a href="#main2" data-toggle="tab">Menu 2</a></li>
				</ul>
				<div class="tab-content">
					<div id="home" class="tab-pane fade in active">
						<h2>Hello Rick!</h2>
						<h4><a href='<@spring.url "/annotation"/>'>myAnnotation</a></h4>
						<div class='col-md-4'>
							<input type='text' class='form-control col-md-3' ng-model='txt' />
							<button class='btn' ng-click='doAjax()'>DoAjax</button>
							<button class='btn' ng-click='doAjax2()'>DoAjax2</button>
							<br>{{yes}}
							<br>${pub.toString()}
						</div>
						<div class='col-md-6'>
							Properties (user.admin):<@spring.message "user.admin"/> <br>
							Properties (user.adb)<@spring.messageText  "user.adb","Default" /> <br>
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
						</div>
					</div>
					<div id="main1" class="tab-pane fade">
						<div class='row'>
							<input type='button' class='btn' ng-click="getDB()" value='getDB'>
						</div>
						<br>
						<div>
							<div class='' id='progress'><div id='msg'></div></div>
						</div>
						<br>
						<div class='row'>
							<div ng-repeat="(fname,fs) in allDb" class='thumbnail' >
								<h3>{{fname}}:</h3><br>
								<table class='table' name='{{fname}}'>
									<thead>
										<tr>
											<th ng-repeat="(hkey,hvalue) in fs[0]">
												{{hkey}}
											</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="(fkey,fval) in fs">
											<td ng-repeat="(key,value) in fval" class='edit' table-name="{{fname}}" table-id="{{fs[fkey].id}}" column-name="{{key}}" ng-dblclick="inlineEdit($event,fname,fs[fkey].id,key)">
												{{value}}
											</td>
											<td>
												<a class='remove' ng-click="Remove(fval.id)" name="{{fval.id}}"><span class="glyphicon glyphicon-remove"></span></a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div id="main2" class="tab-pane fade">
						<h3>Files</h3>
						<!--<div>
							<form id='myform' action='<@spring.url "/upload" />' method='post' enctype="multipart/form-data">
								<input type='file' name='atta' multiple>
								<button type='submit' class='btn' name='upload'>Upload</button>
							</form>
						</div>-->
						<div class='row'>
							<#list files as file>
								<div class="col-xs-6 col-md-3">
									<a href="#" class="thumbnail sameSize">
										${file.getName()}
										<img src='/Upload/${file.getName()}'/>
									</a>
								</div>
							</#list>
						</div>
					</div>
				</div>
			</div>
			
		</div>
    </body>
	<style>
	.carousel-inner > .item > img {
		width:1000px;
		height:360px;
	}
	.sameSize img{
		width:200px;
		height:150px;
		display:block;
	}
	#loading-bar .bar {
		position: relative;
		height:20px;
	}
	#loading-bar-spinner{
		position: relative;
	}
	</style>
	<script>
		
		var app = angular.module("app",['cfp.loadingBar']);
		app.controller("demo",Demo);
		//config for progress bar
		app.config(function(cfpLoadingBarProvider){
			cfpLoadingBarProvider.parentSelector = '#progress';
			cfpLoadingBarProvider.autoIncrement = false;
		});
		app.directive("compile",['$compile',function($compile){
			return function(scope,element,attrs){
				scope.$watch(
					function(scope){
						return scope.$eval(attrs.compile);
					},
					function(value){
						element.html(value);
						$compile(element.contents())(scope);
					},true
				);
			};
		}]);
		function Demo($scope,$http,$injector,$compile,$window,$timeout,$interval,cfpLoadingBar){
			
			$scope.progressBar = cfpLoadingBar;
			$scope.timer = null;
			$scope.link = ["1","2","3","4","5"];
			$scope.allDb = [];
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
			
			$scope.getDB = function(){
				$scope.barStart($scope.progressBar);
				$http({
					method:'POST',
					url:'<@spring.url "/getDbData" />',
					//why to bind viewmodel with java =>1. $("#myform").serialize(); 2. javascript object with param
					data:$.param({id:""}),//$("#myform").serialize() //to serial data or must using file_get_contents to get post data
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}//{'Content-type': 'application/json'} //{'Content-Type': 'application/x-www-form-urlencoded'}
				}).then(function success(msg){
					//console.log(msg.data);
					$scope.allDb = msg.data;
					$scope.barComplete($scope.progressBar);
				},function error(err,status,headers,config){
					console.log(err);
				});
			}
			
			$scope.barStart = function(bar){
				bar.start();
				$scope.timer = $interval(function() {
					$scope.getProgress(bar);
				}, 500,null,false);

			}
			
			$scope.barComplete = function(bar){
				bar.complete();
				if (angular.isDefined($scope.timer)) {
                    $interval.cancel($scope.timer);
                }
				var status = Math.round(bar.status()*100+"%");
				$("#msg").html(status);
			}
			
			$scope.getProgress = function(bar){
				$http({
					method:'POST',
					url:'<@spring.url "/progress" />',
					//why to bind viewmodel with java =>1. $("#myform").serialize(); 2. javascript object with param
					data:$.param({id:""}),//$("#myform").serialize() //to serial data or must using file_get_contents to get post data
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}//{'Content-type': 'application/json'} //{'Content-Type': 'application/x-www-form-urlencoded'}
				}).then(function success(msg){
					//console.log(msg.data);
					bar.set(msg.data*1);
					var status = Math.round(bar.status()*100);
					$("#msg").html(status + "%");
				},function error(err,status,headers,config){
					console.log(err);
				});
			}
			
			$scope.Remove = function(id=""){
				console.log(id);
			}
			
			$scope.inlineEdit = function(event,tableName,id,column){
				if(column=='id'){
					return;
				}
				var dom = angular.element(event.target);
				var val = dom.text().trim();
				var template = "<input type='text' class='form-control' id='inlineText' ng-blur=doEdit($event,tableName,id,column) value='"+val+"'/>";
				//compile in javascript
				$injector.invoke(function($compile){
					var i = $compile(template);
					var content = i($scope);
					dom.html(content);
				});
				//focus column
				var nelem = $window.document.getElementById('inlineText');
				nelem.focus();
			}
			
			$scope.doEdit = function(event,tableName,id,column){
				var text = angular.element(event.target);
				var dom  = text.parent(".edit");
				dom.html(text.val());
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
			var hero;
			var aliens;
			var bullets;
			var enemyBullets;
			var explosions;
			var weapon;
			var cursors;
			var starfield;
			var fireButton;
			var scoreText;
			var bulletTime;
			var score = 0;
			var scoreString = 'Score : ';
			var firingTimer;
			var livingEnemies = [];
			var game = new Phaser.Game(500,360, Phaser.CANVAS, 'phaser-example', {
				preload: preload,
				create: create,
				update:update,
				render:render
			});
			function preload() {
				//  載入一張圖片, 將名稱命名為 pikachu
				game.load.spritesheet('bullet', '/Phaser/sprites/rgblaser.png',4,4);
				game.load.image('ship', '/Phaser/sprites/shmup-ship.png');
				game.load.spritesheet('enemy1', '/Phaser/sprites/invader32x32x4.png',32,32);
				game.load.image('enemy2', '/Phaser/sprites/space-baddie-purple.png');
				game.load.image('enemyBullet', '/Phaser/sprites/enemy-bullet.png');
				game.load.spritesheet('kaboom', '/Phaser/sprites/explosion.png',64,64);
				game.load.image('background', '/Phaser/sprites/starfield.png');
				
			}
			
			function create() {
				//  加入一個 Sprite, 影像來源就是一開始載入的圖片
				bulletTime = game.time.now;
				firingTimer = game.time.now;
				starfield = game.add.tileSprite(0, 0, 800, 600, 'background');
				/*bullets = game.add.group();
				bullets.enableBody = true;
				bullets.pyhsicsBodyType = Phaser.Physics.ARCADE;
				bullets.createMultiple(30,'bullet');
				bullets.setAll('anchor.x',0.5);
				bullets.setAll('anchor.y',1);
				bullets.setAll('outOfBoundsKill',true);
				bullets.setAll('checkWorldBounds',true);*/
				
				enemyBullets = game.add.group();
				enemyBullets.enableBody = true;
				enemyBullets.pyhsicsBodyType = Phaser.Physics.ARCADE;
				enemyBullets.createMultiple(30,'enemyBullet');
				enemyBullets.setAll('anchor.x',0.5);
				enemyBullets.setAll('anchor.y',1);
				enemyBullets.setAll('outOfBoundsKill',true);
				enemyBullets.setAll('checkWorldBounds',true);
				
				hero = this.add.sprite(0,300,'ship');
				hero.anchor.setTo(0,0);//偏移
				game.physics.enable(hero,Phaser.Physics.ARCADE);
				
				aliens = game.add.group();
				aliens.enableBody = true;
				aliens.physicsBodyType = Phaser.Physics.ARCADE;
				aliens.setAll('outOfBoundsKill',true);
				aliens.setAll('checkWorldBounds',true);
				
				explosions = game.add.group();
				explosions.createMultiple(30, 'kaboom');
				explosions.forEach(setupInvader, this);
				
				createFixAliens();
				createMoveAliens();
				
				scoreText = game.add.text(10, 10, scoreString + score, { font: '34px Arial', fill: '#fff' });
				
				weapon = game.add.weapon(30,'bullet');  
				weapon.setBulletFrames(0, 80, true);				
				weapon.bulletKillType = Phaser.Weapon.KILL_WORLD_BOUNDS;//bullet killed when outside bounds
				weapon.bulletAngleOffset = 90;//rotation
				weapon.bulletSpeed = 400;//speed
				weapon.fireRate = 60;
				
				weapon.trackSprite(hero, 14, 0);//bullet follow ship horizon 14px, 0 vertical
				cursors = this.input.keyboard.createCursorKeys();
				fireButton = this.input.keyboard.addKey(Phaser.KeyCode.SPACEBAR);
			}
			
			function update(){
				starfield.tilePosition.y += 2;
				hero.body.velocity.x = 0;
				hero.body.velocity.y = 0;
				if (cursors.left.isDown){
					hero.body.velocity.x = -200;
				}else if (cursors.right.isDown){
					hero.body.velocity.x = 200;
				}else if (cursors.up.isDown){
					hero.body.velocity.y = -200;
				}else if (cursors.down.isDown){
					hero.body.velocity.y = 200;
				}
				if (fireButton.isDown){
					weapon.fire();
				}
				if(game.time.now>firingTimer){
					enemyFire();
				}
				game.physics.arcade.overlap(weapon.bullets,aliens,collisionHandler,null,this);
				game.physics.arcade.overlap(enemyBullets,hero,enemyHits,null,this);
				
			}
			function enemyFire(){
				enemyBullet = enemyBullets.getFirstExists(false);
				livingEnemies.length = 0;
				aliens.forEachAlive(function(alien){
					livingEnemies.push(alien);
				});
				
				if(enemyBullet && livingEnemies.length>0){
					var random = game.rnd.integerInRange(0,livingEnemies.length-1);
					var shooter = livingEnemies[random];
					enemyBullet.reset(shooter.body.x,shooter.body.y+20);
					game.physics.arcade.moveToObject(enemyBullet,hero,120);
					firingTimer = game.time.now+1000;
				}
				
			}
			function render(){
				//weapon.debug();
			}
			function setupInvader (invader) {

				invader.anchor.x = 0.5;
				invader.anchor.y = 0.5;
				invader.animations.add('kaboom');

			}
			function createMoveAliens () {
				//moveTox, speed, 
				var alien = aliens.create( game.world.randomX, game.world.randomY, 'enemy2');
				game.time.events.loop(1500,function(){
					game.add.tween(alien).to(
						{
							x:game.world.randomX,
							y:game.world.randomY
						},
						2000,
						Phaser.Easing.Quadratic.InOut,
						true
					);
				},this);
			}
			function createFixAliens(){
				var alien = aliens.create(0, 0, 'enemy1');
				alien.anchor.setTo(0.5, 0.5);
				alien.animations.add('fly',[ 0, 1, 2, 3 ], 20, true);
				alien.play('fly');
				alien.body.moves = false;
				
				aliens.x = 100;
				aliens.y = 50;

				//  All this does is basically start the invaders moving. Notice we're moving the Group they belong to, rather than the invaders directly.
				var tween = game.add.tween(alien).to( { x: 400 }, 2000, Phaser.Easing.Linear.None, true, 0, 1000, true);
			}
			function collisionHandler(bullet,alien){
				bullet.kill();
				alien.kill();
				var explosion = explosions.getFirstExists(false);
				explosion.reset(alien.body.x,alien.body.y);
				explosion.play('kaboom',30,false,true);
				var r = Math.floor((Math.random() * 10)+1);
				//console.log(r);
				(r>4)?createFixAliens():createMoveAliens();
				score+=10;
				scoreText.text = scoreString + score;
			}
			function enemyHits(hero,enemyBullet){
				enemyBullet.kill();
				var explosion = explosions.getFirstExists(false);
				explosion.reset(hero.body.x,hero.body.y);
				explosion.play('kaboom',30,false,true);
				score-=10;
				scoreText.text = scoreString + score;
			}
		}
		
		
	</script>
	
</html>

