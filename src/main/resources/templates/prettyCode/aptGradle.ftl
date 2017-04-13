apply plugin: 'java'
sourceCompatibility = 1.8 
targetCompatibility = 1.8
configurations {
	querydslapt
}
repositories {
    jcenter()
}
dependencies {
    compile 'com.google.guava:guava:20.0'
    testCompile 'junit:junit:4.12'
	
	compile fileTree(dir: 'libs', include: ['*.jar'])
	//載入autoservice
	compile 'com.google.auto.service:auto-service:1.0-rc3'
	//載入上一步驟所做的專案(setting.gradle需要先include進來才能找的到)
	compile project(':annotation')
}