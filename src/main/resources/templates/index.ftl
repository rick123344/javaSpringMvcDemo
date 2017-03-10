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
			<h2>Hello Rick!</h2>
			<div>
				<input type='text' class='form-control col-md-3' ng-model='txt' />
				<button class='btn' ng-click='doAjax()'>DoAjax</button>
				<br>{{yes}}<br>
			</div>
			<br>
			${another}
			<br>
			<#if test='123456789'>abc</#if><br>
			<#if test='99999'>99999</#if><br>
			${test}<br>
			{{t}}
			<br>
			<#list lang as l>
				${l}<br>
			</#list>
			hihihi
		</div>
    </body>
	
	
	<script>
		console.log(location.href);
		var app = angular.module("app",[]);
		app.controller("demo",Demo);
		console.log("123");
		function Demo($scope,$http){
			$scope.t = "testMsg";
			$scope.option = {
				data:$scope.txt
			};
			$scope.doAjax = function(){
				$http({
					method:'POST',
					url:'<@spring.url "/test" />',
					data:$.param({data1:$scope.txt}),	//to serial data or must using file_get_contents to get post data
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				}).then(function success(msg){
					console.log(msg.data);
					$scope.yes = msg.data.data;
				},function error(err,status,headers,config){
					console.log(err);
				});
			}
		}
		
	</script>
	
</html>

