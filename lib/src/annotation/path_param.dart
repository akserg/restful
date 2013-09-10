//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of annotation;

/**
 * Binds the value of a URI template parameter or a path segment
 * containing the template parameter to a resource method parameter, resource
 * class field, or resource class
 * bean property. The value is URL decoded unless this
 * is disabled using the [Encoded] annotation.
 * A default value can be specified using the [DefaultValue]
 * annotation.
 */
class PathParam {
  
  /**
   * Defines the name of the URI template parameter whose value will be used
   * to initialize the value of the annotated method parameter, class field or
   * property. See [Path.value] for a description of the syntax of
   * template parameters.
   */
  final String value;
  
  const PathParam(this.value);
}