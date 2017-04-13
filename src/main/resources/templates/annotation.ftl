<#import "/spring.ftl" as spring/>

<html ng-app='app'>
	<head>
		<title>Annotation Demo</title>
		<link href="/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="/css/prettify.css" rel="stylesheet"/>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/angular1.5.8.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>
		<script src="/js/prettify.js"></script>
	</head>
    <body ng-controller='demo'>
		<div class='container'> 
			<div class="jumbotron">
				<h2>My Annotation - Simple Annotation Processor</h2>
				<span class='pull-right'><a href='<@spring.url "/home"/>'>Back To Home</a></span>
			</div>
			<div>
				<div>
					<h2>Annotation and Annotation Processor</h2>
					<p>
						java裡一個很神奇的東西就是Annotation，也就是常看到的@Override的"@"這個東西，
						一般Annotation會在編譯時被掃描，幫忙做一些檢查或新建文件等等處理，
						而撰寫一般的Annotation需要一個處理這些Annotation的東西，我們稱為Annotation Processor<br>
						本篇文章純粹是怕自己忘記所以紀錄下撰寫Annotation Processor的過程<br>
					</p>
					<br>
					<h3>Before Start</h3>
					<p>
						須知:<br>
						1.此範例直接使用這個網站的例子，因此原始碼皆放在我的<a href='https://github.com/rick123344/javaSpringMvcDemo' target='_blank'>github</a>上，以下範例只會取重點的部分出來<br>
						2.使用 Gradle 進行專案管理<br>
						3.將會有1個主專案與2個子專案(a master project and two subproject)<br>
						4.每個專案會有一支java檔，分別為client,annotation,annotation processor<br>
						5.本篇會用到Google的AutoService及一款querydsl套件<br>
						6.這篇是我在創建Annotation Processor的流程，因此語法等不會做特別的說明<br>
						7.專案路徑D:\springDemo\<br>
						<pre class="prettyprint">
							<#include "prettyCode/rootPath.ftl">
						</pre>
					</p>
				</div>
				
				<!--FLOW 1-->
				<h2>Let Get Start</h2>
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#annotation"><span class='numTitle'>1</span>Create Annotation Project</a>
							</h4>
						</div>
						<div id="annotation" class="panel-collapse collapse">
							<div class="panel-body">
								<div>
									<h3>Create Annotation Project</h3>
									<div>
										<p>這個專案要做出annotation套件給main做import及使用</p>
										create basic annotation java library by Gradle...
										<pre class="prettyprint lang-bash">
											<#include "prettyCode/annoProject.ftl">
										</pre>
									</div>
									<div>
										create a annotation file named AnnoRick.java into D:\springDemo\library\annotation\src\main\java\, content:
										<pre class='prettyprint lang-java'>
											<#include "prettyCode/annoMainJavaCode.ftl">
										</pre>
										上面的程式碼只是測試用，當然可以更簡潔用String value() default "";
									</div>
									<div>
										Edit build.gradle file which belong annotation project.
										<pre class='prettyprint lang-java'>
											<#include "prettyCode/annoGradle.ftl">
										</pre>
									</div>
									Build Project
									<pre class='prettyprint lang-bash'>
										<#include "prettyCode/annoBuild.ftl">
									</pre>
									以上創建了一個名為annotation的gradle project，或許有人會問說project名稱哪裡看，一般而言
									Gradle會以資料夾名稱做為project名稱，在建立project後，可以在setting.gradle理面看到專案名稱，
									當然也可以自己改專案名稱
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#apt"><span class='numTitle'>2</span>Create Annotation Processor Project</a>
							</h4>
						</div>
						<div id="apt" class="panel-collapse collapse">
							<div class="panel-body">
								<h3>Create Annotation Processor Project</h3>
								<div>
									這個專案將會做一個屬於AnnoRick的註解處理器，先在library新建一個aptTool並建立專案
									<pre class='prettyprint lang-bash'>
										<#include "prettyCode/aptProject.ftl">
									</pre>
								</div>
								<div>
									建立主要java檔於D:\springDemo\library\aptTool\src\main\java\AnnoProcesser.java
									<pre class='prettyprint lang-java'>
										<#include "prettyCode/aptMainJavaCode.ftl">
									</pre>
								</div>
								<div>
									修改setting.gradle的內容
									<pre class='prettyprint lang-java'>
										<#include "prettyCode/aptGradleSetting.ftl">
									</pre>
									修改build.gradle的內容
									<pre class='prettyprint lang-java'>
										<#include "prettyCode/aptGradle.ftl">
									</pre>
								</div>
								<div>
									編譯aptTool專案
									<pre class='prettyprint lang-bash'>
										<#include "prettyCode/aptBuild.ftl">
									</pre>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#client"><span class='numTitle'>3</span>Create Client Project</a>
							</h4>
						</div>
						<div id="client" class="panel-collapse collapse">
							<div class="panel-body">
								<h2>Client Project</h2> 
								由於我直接從spring框架做出controller，因此這邊直接放上controller有用到annotation的部分
								，完整的程式碼可由我的<a href='https://github.com/rick123344/javaSpringMvcDemo' target='_blank'>github</a>取得
								D:\springDemo\src\main\java\rick\app\controller\HomeController.java
								<pre class='prettyprint lang-java'>
									<#include "prettyCode/clientMainJavaCode.ftl">
								</pre>
								編輯setting.gradle內容
								<pre class='prettyprint lang-java'>
									<#include "prettyCode/clientGradleSetting.ftl">
								</pre>
								編輯build.gradle內容
								<pre class='prettyprint lang-java'>
									<#include "prettyCode/clientGradle.ftl">
								</pre>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#test"><span class='numTitle'>4</span>Test Time!~~</a>
							</h4>
						</div>
						<div id="test" class="panel-collapse collapse">
							<div class="panel-body">
								<h2>TEST</h2>
								<pre class='prettyprint lang-bash'>
									<#include "prettyCode/testBuild.ftl">
								</pre>
								之後將可已在編譯時看到我們在client所設定AnnoRick的值
								<div>
									<img src='/Img/annoResult.jpg'/>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
    </body>
	<style>
		a, a:hover, a:active, a:visited, a:focus {
			text-decoration:none;
		}
		.numTitle{
			font-size:25px;
			font-weight:bold;
			color:#7ab6ff;
		}
		.numTitle:after{
			content:" . "
		}
		
	</style>
	<script>
		
		var app = angular.module("app",[]);
		app.controller("demo",Demo);
		
		function Demo($scope,$http){
			prettyPrint();
		}
		
		
	</script>
	
</html>

