//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Restful Annotation library.
 */
library annotation;


/**
 * Short version of [Delete] annotation.
 */
const DELETE = const Delete();

/**
 * Short version of [Get].
 */
const GET = const Get();

/**
 * Short version of [Head].
 */
const HEAD = const Head();

/**
 * Short version of [Post].
 */
const POST = const Post();

/**
 * Short version of [Put].
 */
const PUT = const Put();


/**
 * Abstract annotation class is the base for other annotations.
 */
class Annotation {
  const Annotation();
}

/**
 * Identifies the application path that serves as the base URI
 * for all resource URIs provided by [Path]. May only be
 * applied to a subclass of [Application].
 */
class ApplicationPath extends Annotation {
  
  /**
   * Defines the base URI for all resource URIs. A trailing '/' character must 
   * present.
   */
  final String value;
  
  const ApplicationPath([this.value = ""]);
}

/**
 * Mark the annotated method to respond on HTTP DELETE requests.
 */
class Delete extends Annotation {
  const Delete();
}

/**
 * Mark the annotated method to respond on HTTP GET requests.
 */
class Get extends Annotation {
  const Get();
}

/**
 * Mark the annotated method to respond on HTTP HEAD requests.
 */
class Head extends Annotation {
  const Head();
}

/**
 * Identifies the URI path that a resource class or class method will serve
 * requests for.
 *
 * Paths are relative. For an annotated class the base URI is the
 * application path, see [ApplicationPath]. For an annotated
 * method the base URI is the
 * effective URI of the containing class. For the purposes of absolutizing a
 * path against the base URI , a leading '/' in a path is
 * ignored and base URIs are treated as if they ended in '/'.
 */
class Path extends Annotation {
  
  /**
   * Defines a URI template for the resource class or method, must not include 
   * matrix parameters.
   */
  final String value;
  
  const Path([this.value = ""]);
}

/**
 * Binds the value of a URI template parameter or a path segment
 * containing the template parameter to a resource method parameter, resource
 * class field, or resource class
 * bean property. The value is URL decoded unless this
 * is disabled using the [Encoded] annotation.
 * A default value can be specified using the [DefaultValue]
 * annotation.
 */
class PathParam extends Annotation {
  
  /**
   * Defines the name of the URI template parameter whose value will be used
   * to initialize the value of the annotated method parameter, class field or
   * property. See [Path.value] for a description of the syntax of
   * template parameters.
   */
  final String value;
  
  const PathParam(this.value);
}

/**
 * Mark the annotated method to respond on HTTP POST requests.
 */
class Post extends Annotation {
  const Post();
}

/**
 * Defines the media type(s) that the methods of a resource class or 
 * [MessageBodyWriter] can produce.
 */
class Produces extends Annotation {
  
  /**
   * Media type.
   */
  final String value;
  
  const Produces(this.value);
}

/**
 * Mark the annotated method to respond on HTTP PUT requests.
 */
class Put extends Annotation {
  const Put();
}
