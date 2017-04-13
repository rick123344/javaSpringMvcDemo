apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'org.springframework.boot'

sourceCompatibility = 1.8
targetCompatibility = 1.8
//設定querydslapt
configurations {
    ...
	querydslapt
}
...
dependencies {
	...
	//設定querydslapt的依賴 querydsql 可以幫我們做processor的處理
	querydslapt "com.mysema.querydsl:querydsl-apt:3.7.4"
	//編譯時使用我們自定的annotation 及 aptTool 專案為依賴
	compile project(':aptTool')
	compile project(':annotation')
}
...
sourceSets {
    generated {
        java {
            srcDirs = ['src/main/generated']
        }
    }
}
task generateQueryDSL(type: JavaCompile, group: 'build', description: 'Generates the QueryDSL query types') {
    source = sourceSets.main.java // input source set
    classpath = configurations.compile + configurations.querydslapt // add processor module to classpath
    // specify javac arguments
    options.compilerArgs = [
            "-proc:only",
            "-processor", "rick.app.annoprocesser.AnnoProcesser" // your processor here
    ]
    // specify output of generated code
    destinationDir = sourceSets.generated.java.srcDirs.iterator().next()
}
//編譯java時 使用generateQueryDSL
compileJava {
    dependsOn generateQueryDSL
    source generateQueryDSL.destinationDir
}