import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CROSS_CUTTING_PROVIDERS } from './cross-cutting-providers';
import { APP_DATA_SOURCE_CONFIG } from './data-source-config';
import { LoggingModule } from './internals/logging/logging.module';
import { LoggingServiceSingleton } from './internals/logging/logging.service.singleton';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      ...APP_DATA_SOURCE_CONFIG,
      autoLoadEntities: true,
    }),
    LoggingModule.forRoot(() => LoggingServiceSingleton.getInstance()),
  ],
  providers: [...CROSS_CUTTING_PROVIDERS],
})
export class AppModule {}
