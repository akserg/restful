//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of annotation;

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