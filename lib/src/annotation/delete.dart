//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of annotation;

/**
 * Short version of [Delete] annotation.
 */
const DELETE = const Delete();

/**
 * Mark the annotated method to respond on HTTP DELETE requests.
 */
class Delete extends Annotation {
  const Delete();
}