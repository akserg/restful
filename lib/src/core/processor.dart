//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

class Processor {
  
  final Parser _parser;
  
  Processor(Parser this._parser);
  
  ApplicationContext process(Application application) {
    ApplicationContext applicationContext = new ApplicationContext(application);
    // Process application
    _parser.getClassAnnotations(application).forEach((InstanceMirror im) {
      if (im.reflectee is ApplicationPath) {
        applicationContext.applicationPath = (im.reflectee as ApplicationPath).value;
      }
    });
    // Process all servicess in application
    application.services.forEach((service){
      ServiceContext serviceContext = new ServiceContext();
      // Find Class annotations
      _parser.getClassAnnotations(service).forEach((InstanceMirror im) {
        if (im.reflectee is Path) {
          serviceContext.servicePath = (im.reflectee as Path).value;
        }
      });
      // Find method annotations
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