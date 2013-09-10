//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * REST Runtime. 
 */
class RuntimeDelegate {
  
  final Map<String, ApplicationContext> _application = new Map<String, ApplicationContext>();
  
  /**
   * Register list of the supplied applications.
   */
  void register(List<Application> applications) {
    assert(applications != null);
    // Process all applications and create ApplicationContext per each of them.
    applications.forEach((Application app){
      // Find application path
      String applicationPath = "";
      // Check duplicates
      if (_application.containsKey(applicationPath)) {
        throw new Exception("Found duplicate path $applicationPath");
      } else {
        _application[applicationPath] = new ApplicationContext(app);
      }
    });
  }
  
  bool process(HttpRequest request) {
    // Process request and find application path
    String applicationPath = "";
    if (_application.containsKey(applicationPath)) {
      ApplicationContext context = _application[applicationPath];
      // Get service path
      String servicePath = "";
      // Process request with ApplicationContext
      return context.process(request, servicePath);
    }
    return false;
  }
}