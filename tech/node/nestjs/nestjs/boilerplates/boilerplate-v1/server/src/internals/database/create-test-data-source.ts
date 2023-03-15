import { DataSource, DataSourceOptions } from 'typeorm';
import { APP_DATA_SOURCE_CONFIG } from '../../data-source-config';

if (process.env.NODE_ENV !== 'test') {
  throw new Error();
}

export async function createTestDatasource({
  entities,
}: {
  entities?: DataSourceOptions['entities'];
}): Promise<DataSource> {
  const datasource = new DataSource({
    ...APP_DATA_SOURCE_CONFIG,
    entities,
  });

  await datasource.initialize();

  return datasource;
}
