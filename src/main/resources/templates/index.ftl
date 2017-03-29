<#import "/spring.ftl" as spring/>

<html ng-app='app'>
	<head>
		<title>Index Demo</title>
		<link href="/css/bootstrap.min.css" rel="stylesheet"/>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/angular1.5.8.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>
	</head>
    <body ng-controller='demo'>
		<div class='container'> 
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
		</div>
    </body>
	
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
		
		
		
	</script>
	
</html>

