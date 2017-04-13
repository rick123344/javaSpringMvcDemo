rootProject.name = 'springDemo'
include ':annotation',':aptTool'
project(":aptTool").projectDir = new File("library/aptTool")
project(":annotation").projectDir = new File("library/annotation")