library server;

import "dart:io";

import 'package:logging_handlers/server_logging_handlers.dart';
import 'package:logging/logging.dart';

import 'package:restful/rest_server.dart';

part 'service.dart';
part 'customer.dart';

/**
 * Main entry point.
 */
main() {
  // Server configuration
	String host = "127.0.0.1";
	int port = 8080;
	
	// Logger
	Logger.root.onRecord.listen(new PrintHandler());
	Logger.root.level = Level.FINE;
	Logger logger = new Logger("Server");
  
	// Bind server to specified configuration
  HttpServer.bind(host, port).then((server) {
  	logger.info("Server listens [${host}:${port}]");
  	logger.info("To stop server press CTRL + C");
    // Create new REST Server
  	RestServer rest = new RestServer([new CustomerService()]);
    // Start listenning
    server.listen((HttpRequest request) {
      logger.fine("Request to ${request.uri.path}");
      try {
        rest.service(request);
      } on Exception catch(e) {
        _error404(request);
      }
    });
  });
}

/**
 * Error 404.
 */
void _error404(HttpRequest request) {
  request.response.write("<h1>Error</h1><p>404 - Page not found</p>");
  request.response.statusCode = HttpStatus.NOT_FOUND;
  request.response.close();
}

/*
//      if (!rest.service(request)) {
//        // Process other type of requests or resources 
//        final Uri uri = request.uri;
//        if (!uri.isAbsolute) {
//          final String stringPath = uri.path == '/' ? 'index.html' : uri.path;
//          final File file = new File(stringPath);
//          file.exists()
//            ..then((bool found) {
//            if (found) {
//              file.openRead()
//                .pipe(request.response)
//                .catchError((e) { 
//                  logger.severe("File i/o error", e);
//                });
//            } else {
//              // File not found
//              logger.warning("File not found ${stringPath}");
//              _error404(request);
//            }
//          })
//          ..catchError((error){
//            // File doesn't exists
//            logger.warning("File doesn't exists ${stringPath}");
//            _error404(request);
//          });
//        } else {
//          // URI incorrect
//          logger.warning("URI incorrect");
//          _error404(request);
//        }
//      };
*/