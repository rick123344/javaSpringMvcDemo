apply plugin: 'java'

sourceCompatibility = 1.8 
targetCompatibility = 1.8
repositories {
	jcenter()
}
dependencies {
	compile 'com.google.guava:guava:20.0'
	compile fileTree(dir: 'libs', include: ['*.jar'])
	testCompile 'junit:junit:4.12'
}