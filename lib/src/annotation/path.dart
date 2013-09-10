//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of annotation;

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
class Path {
  
  /**
   * Defines a URI template for the resource class or method, must not include 
   * matrix parameters.
   */
  final String value;
  
  const Path(this.value);
}