package rick.app.annotation;

import java.lang.annotation.Documented; 
import java.lang.annotation.ElementType; 
import java.lang.annotation.Retention; 
import java.lang.annotation.RetentionPolicy; 
import java.lang.annotation.Target; 

//製作一個基本的annotation，包含了level,name,tester三個參數
//使用時可使用 @AnnoRick(level=AnnoRick.Level.UNIT,name="hello",tester="ABCD")來改變值
public @interface AnnoRick {
	public enum Level {NONE,UNIT,INTEGRATION,FUNCTION};
	Level level() default Level.NONE;
	String name() default "Rick";
	String tester() default "Ricker";
}