package rick.app.annoprocesser;
import rick.app.annotation.AnnoRick;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;
import javax.annotation.processing.AbstractProcessor;
import javax.annotation.processing.Filer;
import javax.annotation.processing.Messager;
import javax.annotation.processing.ProcessingEnvironment;
import javax.annotation.processing.Processor;
import javax.annotation.processing.RoundEnvironment;
import javax.annotation.processing.SupportedAnnotationTypes;
import javax.annotation.processing.SupportedSourceVersion;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.TypeElement;
import javax.lang.model.element.Element;
import javax.tools.Diagnostic;
import com.google.auto.service.AutoService;
//這份java檔會用到剛剛所建立的AnnoRick的project
//如果妳不想用getSupportedAnnotationTypes及getSupportedSourceVersion方法的話，可使用下列2行注解取代
//@SupportedAnnotationTypes("rick.app.annotation.AnnoRick")
//@SupportedSourceVersion(SourceVersion.RELEASE_6)
//AutoService 會自動幫我們建立META-INF\services\rick.app.annotation.AnnoRick的annotation文件
@AutoService(AnnoRick.class)
public class AnnoProcesser extends AbstractProcessor{
	@Override
	public synchronized void init(ProcessingEnvironment env){
		super.init(env);
	}
	@Override
	public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment roundEnv){
		//這邊會將把client有用到所有AnnoRick這個Annotation的內容值印出來
		for (Element elem : roundEnv.getElementsAnnotatedWith(AnnoRick.class)) {
			AnnoRick annorick = elem.getAnnotation(AnnoRick.class);
			String message = "annotation found in " + elem.getSimpleName()
						   + " with annorick " + annorick.level()+" "+annorick.name()+" "+annorick.tester();
			processingEnv.getMessager().printMessage(Diagnostic.Kind.NOTE, message);
		}
		return true;
	}
	@Override
	public Set<String> getSupportedAnnotationTypes(){
		Set<String> annotations = new LinkedHashSet<String>();
		annotations.add(AnnoRick.class.getCanonicalName());
		return annotations;
	}
	@Override
	public SourceVersion getSupportedSourceVersion(){
		return SourceVersion.latestSupported();
	}
}