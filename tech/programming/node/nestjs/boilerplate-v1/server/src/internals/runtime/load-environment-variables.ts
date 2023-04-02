import * as dotenv from 'dotenv';
import path from 'path';

const NODE_ENV = process.env.NODE_ENV || '';

if (!['development', 'production', 'test'].includes(NODE_ENV)) {
  throw new Error(`Invalid NODE_ENV: ${process.env.NODE_ENV}`);
}

dotenv.config({
  path: path.join(process.cwd(), `.env.${NODE_ENV}`),
});
