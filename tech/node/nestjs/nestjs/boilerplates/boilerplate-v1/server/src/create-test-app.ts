import {
  INestApplication,
  LoggerService,
  ModuleMetadata,
} from '@nestjs/common';
import { Test } from '@nestjs/testing';
import { LoggingService } from './internals/logging/logging.service';
import { inspect } from 'util';
import { LoggingModule } from './internals/logging/logging.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { APP_DATA_SOURCE_CONFIG } from './data-source-config';
import { AuthModule } from './auth/auth.module';
import { CROSS_CUTTING_PROVIDERS } from './cross-cutting-providers';
import { EnvironmentVariables } from './internals/runtime/environment-variables';

if (process.env.NODE_ENV !== 'test') {
  throw new Error();
}

class LoggingTestService extends LoggingService {
  logDebug(...args: unknown[]): void {
    if (EnvironmentVariables.LOG_DEBUG) {
      console.log(inspect(args, undefined, 30));
    }
  }
  logInfo(...args: unknown[]): void {
    if (EnvironmentVariables.LOG_DEBUG) {
      console.info(inspect(args, undefined, 30));
    }
  }
  logWarning(...args: unknown[]): void {
    console.warn(inspect(args, undefined, 30));

    /*
      Test should fail if a warning occurs inside the request-response flow
    */
    throw new Error();
  }
  logError(key: string, caughtValue: unknown, extraData?: unknown): void {
    console.error(inspect([key, caughtValue, extraData], undefined, 30));

    /*
      Test should fail if an error occurs inside the request-response flow
    */
    if (caughtValue instanceof Error) {
      throw caughtValue;
    } else {
      throw new Error();
    }
  }
}

const loggingTestService = new LoggingTestService();

const logger: LoggerService = {
  log(message: string) {
    loggingTestService.logInfo('nestjs-logger-log', message);
  },
  error(message: string, trace: string) {
    loggingTestService.logError('nestjs-logger-error', new Error(), {
      message,
      trace,
    });
  },
  warn(message: string) {
    loggingTestService.logWarning('nestjs-logger-warn', message);
  },
  debug(message: string) {
    loggingTestService.logDebug('nestjs-logger-debug', message);
  },
  verbose(message: string) {
    loggingTestService.logInfo('nestjs-logger-verbose', message);
  },
};

export async function createAndInitializeTestApp(args: {
  imports: NonNullable<ModuleMetadata['imports']>;
}): Promise<INestApplication> {
  const moduleRef = await Test.createTestingModule({
    imports: [
      LoggingModule.forRoot(() => loggingTestService),
      TypeOrmModule.forRoot(APP_DATA_SOURCE_CONFIG),
      AuthModule,
      ...args.imports,
    ],
    providers: CROSS_CUTTING_PROVIDERS,
  }).compile();

  const app = moduleRef.createNestApplication({ logger });

  await app.init();

  return app;
}
