//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * REST Runtime. 
 */
class RestRuntime {
  
  /**
   * Map of [ApplicationContext]'s.
   */
  final Map<String, ApplicationContext> _applicationContexts = new Map<String, ApplicationContext>();
  
  RestRuntime() {
    logger.info("Starting REST server");
  }
  
  /**
   * Register list of the specified [applications].
   */
  void register(List<Application> applications) {
    assert(applications != null);
    // Process all applications and create ApplicationContext per each of them.
    applications.forEach((Application app){
      // Create Parser and Processor
      ApplicationProcessor processor = new ApplicationProcessor(new AnnotationParser());
      // Process application
      ApplicationContext applicationContext = processor.process(app);
      // Check duplicates
      if (_applicationContexts.containsKey(applicationContext.applicationPath)) {
        throw new Exception("Found duplicate path ${applicationContext.applicationPath}");
      } else {
        _applicationContexts[applicationContext.applicationPath] = applicationContext;
        logger.info("${app.toString()} added to pull of REST applications.");
      }
    });
  }
  
  /**
   * Service HttpRequest [request] and fill in response.
   */
  bool service(HttpRequest request) {
    String httpMethod = request.method;
    // Get application path from request
    String applicationPath = request.uri.path;
    //
    logger.fine("Service ${request.method} method for ${request.uri.path}");
    //
    if (_applicationContexts.containsKey(applicationPath)) {
      // Return ApplicationContext.
      ApplicationContext context = _applicationContexts[applicationPath];
      // Get service path
      String servicePath = "";
      // Process request with ApplicationContext
      return context.service(request, request.uri);
    }
    return false;
  }
}