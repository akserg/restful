//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Context shared by message body interceptors that can be used to wrap
 * calls to [MessageBodyReader.readFrom] and [MessageBodyWriter.writeTo]. 
 * The getters and setters in this context class correspond to the parameters in
 * the aforementioned methods.
 */
class ApplicationContext {

	/**
	 * Reference to Application
	 */  
  final Application application;
  
  String applicationPath = "";
  
  /**
   * Map of ServiceContext's
   */
  final Map<String, ServiceContext> _serviceContexts = new Map<String, ServiceContext>();
  
  /**
   * Create an instance of ApplicationContext to wrap [Application].
   */
  ApplicationContext(Application this.application);
  
  void register(ServiceContext serviceContext) {
    assert(serviceContext != null);
    if (_serviceContexts.containsKey(serviceContext.servicePath)) {
      throw new Exception("Service for ${serviceContext.servicePath} exists");
    } else {
      _serviceContexts[serviceContext.servicePath] = serviceContext;
    }
  }
  
  /**
   * Find service for [path] and fill response from [request].
   */
  bool process(HttpRequest request, Uri uri) {
    if (_serviceContexts.containsKey(uri.path)) {
      print("Processing");
      ServiceContext serviceContext = _serviceContexts[uri.path];
      return serviceContext.process(request, uri.path);
    }
    return false;
  }
}