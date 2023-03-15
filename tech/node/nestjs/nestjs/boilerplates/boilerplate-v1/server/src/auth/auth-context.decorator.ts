import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { HttpRequest } from '../internals/server/http-request-types';
import { throwError } from '../internals/utils/throw-error';
import { EnforceParameterDecoratorTypesafety } from '../internals/utils/typesafe-parameter-decorator';
import { AuthContext } from './auth-context';

export const WithAuthContext = createParamDecorator(
  (data: unknown, ctx: ExecutionContext): AuthContext => {
    const request = ctx.switchToHttp().getRequest<HttpRequest>();

    return request.authContext ?? throwError();
  },
  [EnforceParameterDecoratorTypesafety(AuthContext)],
);

export const WithOptionalAuthContext = createParamDecorator(
  (data: unknown, ctx: ExecutionContext): undefined | AuthContext => {
    const request = ctx.switchToHttp().getRequest<HttpRequest>();

    return request.authContext;
  },
  [EnforceParameterDecoratorTypesafety(AuthContext)],
);
