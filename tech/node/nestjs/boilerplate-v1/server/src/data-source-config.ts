import { DataSourceOptions } from 'typeorm';
import { EnvironmentVariables } from './internals/runtime/environment-variables';

export const APP_DATA_SOURCE_CONFIG: DataSourceOptions = {
  type: 'postgres' as const,
  host: EnvironmentVariables.DB_HOST,
  port: EnvironmentVariables.DB_PORT,
  username: EnvironmentVariables.DB_USER,
  password: EnvironmentVariables.DB_PASSWORD,
  database: EnvironmentVariables.DB_NAME,
  migrations: ['src/migrations/*.ts'],
  synchronize: false,
  migrationsRun: process.env.NODE_ENV === 'development',
};
