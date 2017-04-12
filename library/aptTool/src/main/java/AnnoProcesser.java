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

//@SupportedAnnotationTypes("rick.app.annotation.AnnoRick")
//@SupportedSourceVersion(SourceVersion.RELEASE_6)
@AutoService(AnnoRick.class)
public class AnnoProcesser extends AbstractProcessor{
	
	@Override
	public synchronized void init(ProcessingEnvironment env){
		super.init(env);
	}
	
	@Override
	public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment roundEnv){
		System.out.println("\n\nDO PROCESS START\n\n");
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