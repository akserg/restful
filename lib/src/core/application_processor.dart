//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Application processor. 
 */
class ApplicationProcessor {
  
  /*
   * Instance of [ApplicationParser].
   */
  final AnnotationParser _parser;
  
  /**
   * Create an instance of [ApplicationProcessor] with specified [AnnotationParser].
   */
  ApplicationProcessor(AnnotationParser this._parser);
  
  /*
   * Process [Application].
   */
  ApplicationContext process(Application application) {
    // Create ApplicationContext for application
    ApplicationContext applicationContext = new ApplicationContext(application);
    // Get application class annotations and process them
    _parser.getClassAnnotations(application).forEach((InstanceMirror im) {
      if (im.reflectee is ApplicationPath) {
        applicationContext.applicationPath = (im.reflectee as ApplicationPath).value;
      }
    });
    // Process all servicess in application
    application.services.forEach((service){
      // Create an empty ServiceContext
      ServiceContext serviceContext = new ServiceContext();
      // Get Servic's class annotations and process them
      _parser.getClassAnnotations(service).forEach((InstanceMirror im) {
        if (im.reflectee is Path) {
          serviceContext.servicePath = (im.reflectee as Path).value;
        }
      });
      // Get Service's method annotations
      _parser.getMethodAnnotations(service).forEach((MethodMirror mm){
        // Find Path
        Path path = mm.metadata.singleWhere((InstanceMirror im) => im.reflectee is Path).reflectee;
        assert(path != null);
        // Register method
        serviceContext.register(path.value, mm);
      });
      // Register service context
      applicationContext.register(serviceContext);
    });
    //
    return applicationContext;
  }
}