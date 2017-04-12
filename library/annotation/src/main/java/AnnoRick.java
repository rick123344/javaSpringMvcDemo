package rick.app.annotation;

import java.lang.annotation.Documented; 
import java.lang.annotation.ElementType; 
import java.lang.annotation.Retention; 
import java.lang.annotation.RetentionPolicy; 
import java.lang.annotation.Target; 

//Document mean it will show on javaAPI doc when you create JavaDoc automatically
@Documented
//Target mean this annotation can be using in which type, such as method , type , field....
//if not using , it's mean can be using in any types.
//@Target(ElementType.METHOD) 
//Retention has three parameter. 
//SOURCE  => only in source files, not appear in .class files
//CLASS   => in source and .class files, but not in execute JVM , not check in execute,but in compile. default
//RUNTIME => in source and .class and JVM , it's mean will check when execute
@Retention(RetentionPolicy.RUNTIME) 
public @interface AnnoRick {
	public enum Level {NONE,UNIT,INTEGRATION,FUNCTION};
	Level level() default Level.NONE;
	String name() default "Rick";
	String tester() default "Ricker";
}