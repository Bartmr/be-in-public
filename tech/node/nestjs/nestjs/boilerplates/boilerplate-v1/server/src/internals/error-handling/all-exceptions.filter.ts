import {
  Catch,
  ArgumentsHost,
  HttpException,
  ExceptionFilter,
  InternalServerErrorException,
} from '@nestjs/common';
import { LoggingService } from '../logging/logging.service';
import { HttpRequest, HttpResponse } from '../server/http-request-types';
import { ResourceNotFoundException } from '../server/resource-not-found.exception';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter<unknown> {
  constructor(private loggingService: LoggingService) {}

  private logError(exception: unknown, request: HttpRequest) {
    this.loggingService.logError('on-exception-request-logging', exception, {
      path: request.path,
      method: request.method,
      statusCode:
        exception instanceof HttpException ? exception.getStatus() : undefined,
      body: request.body as unknown,
    });
  }

  catch(exception: unknown, host: ArgumentsHost): void {
    if (host.getType() !== 'http') {
      this.loggingService.logError(
        'all-exceptions-filter:unknown-execution-context',
        new Error(),
      );
      return;
    }

    const ctx = host.switchToHttp();
    const request = ctx.getRequest<HttpRequest>();
    const response = ctx.getResponse<HttpResponse>();

    if (exception instanceof HttpException) {
      const statusCode = exception.getStatus();

      if (statusCode >= 500) {
        this.logError(exception, request);
      } else {
        this.loggingService.logDebug('request-exception', {
          exception,
          request: {
            path: request.path,
            method: request.method,
            statusCode: statusCode,
            body: request.body as unknown,
          },
        });

        if (exception instanceof ResourceNotFoundException) {
          response.set('X-Resource-Not-Found', 'true');
        }
      }

      response.status(statusCode).json(exception.getResponse());
    } else {
      this.logError(exception, request);

      const internalErrorException = new InternalServerErrorException();

      response
        .status(internalErrorException.getStatus())
        .json(internalErrorException.getResponse());
    }
  }
}
