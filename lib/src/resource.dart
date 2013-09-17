//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * Resource to invoke.
 */
class Resource implements Comparable {
  
  /**
   * Method calls as REST resource.
   */
  MethodMirror theMethod;
  
  /**
   * Request method.
   */
  String method;
  
  /**
   * Resource path.
   */
  String path;
  
  /**
   * Produces mime type.
   */
  MediaType produces;

  /**
   * Create resource instance.
   */
  Resource(this.path, this.method, this.produces, this.theMethod);
  
  /**
   * Compares this object to another [Comparable]
   *
   * Returns a value like a [Comparator] when comparing [:this:] to [other].
   *
   * May throw an [ArgumentError] if [other] is of a type that
   * is not comparable to [:this:].
   */
  int compareTo(Resource other) {
    if ( (method != null && method == other.method) &&
         (path != null && path == other.path) &&
         (produces == other.produces) ) {
      return 0;
    }
    return -1;
  }
  
  /**
   * Translate resource to string. 
   */
  String toString() {
    StringBuffer sb = new StringBuffer("Resource: ");
    sb.write("Method ${method}, ");
    sb.write("Path ${path}");
    sb.write("Produces ${produces.toString()}");
    return sb.toString();
  }
}