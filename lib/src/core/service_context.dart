//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Context shared by message body interceptors that can be used to wrap
 * calls to [MessageBodyReader.readFrom] and [MessageBodyWriter.writeTo]. 
 * The getters and setters in this context class correspond to the parameters in
 * the aforementioned methods.
 */
class ServiceContext {
  
  final Map<String, MethodMirror> _methods = new Map<String, MethodMirror>();
  
  String servicePath;
  
  void register(String path, MethodMirror method) {
    if (_methods.containsKey(path)) {
      throw new Exception("Method process $path duplicate");
    } else {
      _methods[path] = method;
    }
  }
  
  bool process(HttpRequest request, String path) {
    if (_methods.containsKey(path)) {
      HttpResponse response = request.response;
      response.write("Hello world");
      response.statusCode = HttpStatus.OK;
      response.close();
      return true;
    }
    return false;
  }
}
