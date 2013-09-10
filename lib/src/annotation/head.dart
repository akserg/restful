//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of annotation;

/**
 * Short version of [Head].
 */
const HEAD = const Head();

/**
 * Mark the annotated method to respond on HTTP HEAD requests.
 */
class Head extends Annotation {
  const Head();
}