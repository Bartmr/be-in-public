import '../src/internals/load-environment-variables';
import { DataSource } from 'typeorm';
import { APP_DATA_SOURCE_CONFIG } from '../src/data-source-config';

if (process.env.NODE_ENV !== 'test') {
  throw new Error();
}

export default async function setupE2ETests() {
  const dataSource = new DataSource({
    ...APP_DATA_SOURCE_CONFIG,
    migrationsRun: true,
  });

  await dataSource.initialize();

  await dataSource.destroy();
}
