rootProject.name = 'aptTool'
//注意，這邊需要先做include ,build.gradle才能直接用project(":annotation")
include ":annotation"
//由於路徑的關係，aptTool和annotation是在同一層，需要做專案路徑的設定
//如果annotation在aptTool的資料夾內，則不必寫這一行
project(":annotation").projectDir = new File("../annotation")