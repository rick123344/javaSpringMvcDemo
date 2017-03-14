# Spring MVC Boot 

Before run application, you must have  [Gradle Installed](https://gradle.org/) and [Java Installed](http://www.oracle.com/technetwork/indexes/downloads/index.html#java)

## How to run

1. run with jar (packaged) 

```sh
$ git clone https://github.com/rick123344/javaSpringMvcDemo.git 
$ cd javaSpringMvcDemo
$ gradle clean build
$ java -jar build\libs\webService.jar
```
2. run with debug (when you just change static file or html , you will see the result just refresh page instead recompile and rerun server)
```sh
$ git clone https://github.com/rick123344/javaSpringMvcDemo.git 
$ cd javaSpringMvcDemo
$ gradle bootRun
```

Visit [http://localhost:8080/home](http://localhost:8080/home).

## Notice

I'm still learn how to use spring mvc framework , so this demo is not complete.
The Postgres database just for test, so public here, when you run application, you should connect successly,
or you can chage it in application.properties file where locate in src\main\resources.