import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { z } from 'zod';
import { FirebaseService } from '../internals/firebase/firebase.service';
import { HttpRequest } from '../internals/server/http-request-types';
import { AuthContext } from './auth-context';
import {
  PublicRouteMetadata,
  PUBLIC_ROUTE_METADATA_KEY,
} from './public-route.decorator';
import { ROLES_LEVELS } from './roles/roles';
import {
  RolePermissionType,
  RouteRolesMetadata,
  ROUTE_ROLES_METADATA_KEY,
} from './roles/roles.decorator';
import { User } from './user.entity';

const AuthTokenSchema = z
  .string()
  .refine((s) => s == undefined || s.startsWith('Bearer '))
  .transform((s) => {
    if (s == null) {
      return undefined;
    }

    return s.replace('Bearer ', '');
  });

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    @InjectDataSource() private connection: DataSource,
    private firebaseService: FirebaseService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<true> {
    if (context.getType() !== 'http') {
      throw new Error('Unknown execution context');
    }

    const request: HttpRequest = context
      .switchToHttp()
      .getRequest<HttpRequest>();

    const isPublic = this.reflector.get<PublicRouteMetadata | undefined>(
      PUBLIC_ROUTE_METADATA_KEY,
      context.getHandler(),
    );

    const authTokenIdValidationResult = AuthTokenSchema.safeParse(
      request.header('authorization'),
    );

    if (!authTokenIdValidationResult.success) {
      throw new UnauthorizedException();
    }

    const authToken = authTokenIdValidationResult.data;

    if (authToken) {
      const user = await this.decodeAsFirebaseToken(authToken);

      if (!user) {
        throw new UnauthorizedException();
      }

      const authContext = new AuthContext({ user });
      request.authContext = authContext;
    }

    if (isPublic) {
      return true;
    } else {
      if (request.authContext) {
        const rolesMetadata = this.reflector.get<RouteRolesMetadata>(
          ROUTE_ROLES_METADATA_KEY,
          context.getHandler(),
        );

        if (rolesMetadata) {
          const currentUserRole = request.authContext.user.role;

          let isAllowed: boolean;

          switch (rolesMetadata.permissionType) {
            case RolePermissionType.UpAndIncluding:
              isAllowed =
                ROLES_LEVELS[currentUserRole] >=
                ROLES_LEVELS[rolesMetadata.role];
              break;
            case RolePermissionType.DownAndIncluding:
              isAllowed =
                ROLES_LEVELS[currentUserRole] <=
                ROLES_LEVELS[rolesMetadata.role];
              break;
            case RolePermissionType.EqualTo:
              isAllowed = rolesMetadata.allowedRoles.includes(currentUserRole);
              break;
            default:
              throw new Error();
          }

          if (isAllowed) {
            return true;
          } else {
            throw new ForbiddenException();
          }
        }

        return true;
      } else {
        throw new UnauthorizedException();
      }
    }
  }

  async decodeAsFirebaseToken(authToken: string) {
    try {
      const decoded = await this.firebaseService
        .getAuth()
        .verifyIdToken(authToken);

      const usersRepository = this.connection.getRepository(User);

      const user = await usersRepository.findOne({
        where: { firebaseUid: decoded.uid },
      });

      return user;
    } catch (err) {
      throw new UnauthorizedException();
    }
  }
}
