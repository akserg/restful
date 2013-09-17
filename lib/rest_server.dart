//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * RESTServer library.
 */
library rest_server;

import "dart:io";
import "dart:mirrors";

import 'package:logging/logging.dart';

part 'src/annotation.dart';
part 'src/resource.dart';
part 'src/rest_exception.dart';
part 'src/media_type.dart';
part 'src/rest_server.dart';
part 'src/request_resolver.dart';
part 'src/resource_parser.dart';
part 'src/resource_invoker.dart';
part 'src/response_writer.dart';

final logger = new Logger("REST");