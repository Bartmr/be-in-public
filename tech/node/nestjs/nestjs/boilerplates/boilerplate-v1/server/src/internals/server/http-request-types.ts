import { Request } from 'express';
import { Response } from 'express';
import { AuthContext } from '../../auth/auth-context';

export type HttpRequest = Request & {
  authContext?: AuthContext;
};

export type HttpResponse<T = unknown> = Response<T>;
