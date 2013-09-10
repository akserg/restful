//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of annotation;

/**
 * Identifies the application path that serves as the base URI
 * for all resource URIs provided by [Path]. May only be
 * applied to a subclass of [Application].
 */
class ApplicationPath {
  
  /**
   * Defines the base URI for all resource URIs. A trailing '/' character must 
   * present.
   */
  final String value;
  
  const ApplicationPath(this.value);
}