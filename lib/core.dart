//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Restful Core library.
 */
library core;

import "dart:io";
import "dart:mirrors";

import 'package:logging/logging.dart';

import 'annotation.dart';

part 'src/core/application.dart';
part 'src/core/rest_runtime.dart';
part 'src/core/rest_exception.dart';
part 'src/core/exception_mapper.dart';
part 'src/core/application_context.dart';
part 'src/core/service_context.dart';
part 'src/core/application_processor.dart';
part 'src/core/annotation_parser.dart';
part 'src/core/resolver.dart';

final logger = new Logger("RESTFUL");