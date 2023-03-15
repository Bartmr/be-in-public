import 'source-map-support/register';
import 'reflect-metadata';
import './internals/load-environment-variables';

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { LoggingServiceSingleton } from './internals/logging/logging.service.singleton';
import { EnvironmentVariables } from './internals/runtime/environment-variables';
import { LoggerService } from '@nestjs/common';

async function bootstrap() {
  const loggingService = LoggingServiceSingleton.makeInstance();

  const logger: LoggerService = {
    log(message: string) {
      loggingService.logInfo('nestjs-logger-log', message);
    },
    error(message: string, trace: string) {
      loggingService.logError('nestjs-logger-error', new Error(), {
        message,
        trace,
      });
    },
    warn(message: string) {
      loggingService.logWarning('nestjs-logger-warn', message);
    },
    debug(message: string) {
      loggingService.logDebug('nestjs-logger-debug', message);
    },
    verbose(message: string) {
      loggingService.logInfo('nestjs-logger-verbose', message);
    },
  };

  const app = await NestFactory.create(AppModule, { logger });

  app.enableShutdownHooks();

  app.enableCors({
    origin: EnvironmentVariables.WEB_APP_ORIGIN,
    credentials: true,
    exposedHeaders: ['X-Resource-Not-Found'],
  });

  await app.listen(3000);
}
bootstrap();
