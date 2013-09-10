//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * REST Runtime. 
 */
class RestRuntime {
  
  final Map<String, ApplicationContext> _applicationContexts = new Map<String, ApplicationContext>();
  
  /**
   * Register list of the supplied applications.
   */
  void register(List<Application> applications) {
    assert(applications != null);
    // Process all applications and create ApplicationContext per each of them.
    applications.forEach((Application app){
      // Create Parser and Processor
      Processor processor = new Processor(new Parser());
      // Process application
      ApplicationContext applicationContext = processor.process(app);
      // Check duplicates
      if (_applicationContexts.containsKey(applicationContext.applicationPath)) {
        throw new Exception("Found duplicate path ${applicationContext.applicationPath}");
      } else {
        _applicationContexts[applicationContext.applicationPath] = applicationContext;
      }
    });
  }
  
  bool process(HttpRequest request) {
    // Get application path from request
    String applicationPath = request.uri.path;
    if (_applicationContexts.containsKey(applicationPath)) {
      ApplicationContext context = _applicationContexts[applicationPath];
      // Get service path
      String servicePath = "";
      // Process request with ApplicationContext
      return context.process(request, request.uri);
    }
    return false;
  }
}