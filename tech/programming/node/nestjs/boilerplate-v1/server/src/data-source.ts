import './internals/load-environment-variables.ts';

import { DataSource } from 'typeorm';
import { APP_DATA_SOURCE_CONFIG } from './data-source-config';

export const AppDataSource = new DataSource({
  ...APP_DATA_SOURCE_CONFIG,
  entities: ['src/**/*.entity.ts'],
});
