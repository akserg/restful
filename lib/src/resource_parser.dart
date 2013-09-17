//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * Class helps parse instances to find REST resources.
 */
class ResourceParser {
  
  /**
   * Parse set of [instances] to find REST resources.
   */
  Map<Resource, Resource> parse(Set instances) {
    Map<Resource, Resource> resources = new Map<Resource, Resource>();
    instances.forEach((instance){
      // Get class mirror of instance
      ClassMirror clazz = reflect(instance).type;
      // Find @Path class annotation
      String classPath = _findClassPath(clazz);
      logger.fine("Resource root is ${classPath}");
      // Find public, REST annotated methods and create Resource of each them.
      _findMethods(clazz, classPath, resources);
    });
    return resources;
  }

  /**
   * Find class path.
   */
  String _findClassPath(ClassMirror theClass) {
    String path = "";
    _findRestClassAnnotations(theClass).any((InstanceMirror theClassAnnotation){
      // Is reflectee of theClassAnnotation equals @Path
      if (theClassAnnotation.reflectee is Path) {
        path = (theClassAnnotation.reflectee as Path).value;
        return true;
      }
      return false;
    });
    return path;
  }
  
  /**
   * Find public, REST annotated methods and create Resource of each them.
   */
  void _findMethods(ClassMirror theClass, String classPath, Map<Resource, Resource> resources) {
    // Now pass through all public methods in class to find REST annotated
    _findMethodWithRestAnnotations(theClass).forEach((MethodMirror theMethod){
      // Find path as combination class and method paths
      String path = classPath;
      try {
        Path pathAnnotation = _findAnnotationByType(Path, theMethod);
        path += pathAnnotation.value;
      } on Exception catch(e) {}
      // Find method
      String method = "GET";
      try {
        Annotation annotation = _findAnnotationByType(GET, theMethod);
        if (annotation != null) method = "GET";
        //
        annotation = _findAnnotationByType(PUT, theMethod);
        if (annotation != null) method = "PUT";
        //
        annotation = _findAnnotationByType(POST, theMethod);
        if (annotation != null) method = "POST";
        //
        annotation = _findAnnotationByType(DELETE, theMethod);
        if (annotation != null) method = "DELETE";
      } on Exception catch(e) {}
      // Find mime type
      String mimeType = WILDCARD;
      try {
        Produces producesAnnotation = _findAnnotationByType(Produces, theMethod);
        mimeType = producesAnnotation.value;
      } on Exception catch(e) {}
      // Create new resource
      Resource resource = new Resource(path, method, new MediaType.from(mimeType), theMethod);
      if (resources.containsKey(resource)) {
        // Find duplicate
        throw new RestException("Found duplicate method ${theMethod.toString()}");
      } else {
        resources[resource] = resource;
        logger.fine("Added ${resource.toString()}");
      }
    });

  }
  
  /**
   * Return iterator of [clazz] annotations.
   */
  Iterable<InstanceMirror> _findRestClassAnnotations(ClassMirror clazz) {
    return clazz.metadata.where((InstanceMirror im) => im.reflectee is Path);
  }
  
  /**
   * Return iterator of method annotations of [clazz].
   */
  Iterable<MethodMirror> _findMethodWithRestAnnotations(ClassMirror clazz) {
    // Check only public methods
    return clazz.methods.values.where((MethodMirror mm) => 
        !mm.isPrivate && mm.metadata.any(_isRestAnnotations));
  }
  
  /**
   * Return iterator of method annotations of [clazz].
   */
  Iterable<InstanceMirror> _findMethodRestAnnotations(MethodMirror theMethod) {
    return theMethod.metadata.where(_isRestAnnotations);
  }
  
  /**
   * Check is [instanceMirror] is REST type annotations.
   */
  bool _isRestAnnotations(InstanceMirror instanceMirror)  => 
      instanceMirror.reflectee is Get ||
      instanceMirror.reflectee is Post ||
      instanceMirror.reflectee is Put ||
      instanceMirror.reflectee is Delete ||
      instanceMirror.reflectee is Path ||
      instanceMirror.reflectee is Produces;
  
  Annotation _findAnnotationByType(Type type, MethodMirror theMethod) {
    _findMethodRestAnnotations(theMethod).forEach((InstanceMirror im) {
      if (im.reflectee.runtimeType == type) {
        return im.reflectee;
      }
    });
    throw new Exception("Not found");
  }
}