import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { createAndInitializeTestApp } from './../src/create-test-app';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    app = await createAndInitializeTestApp({
      imports: [],
    });
  });

  afterAll(async () => {
    await app.close();
  });

  it('/ (GET)', () => {
    return request(app.getHttpServer())
      .get('/')
      .expect(200)
      .expect('Hello World!');
  });
});
