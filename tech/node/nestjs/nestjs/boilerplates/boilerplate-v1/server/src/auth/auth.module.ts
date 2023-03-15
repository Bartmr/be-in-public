import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FirebaseModule } from '../internals/firebase/firebase.module';
import { AuthGuard } from './auth.guard';
import { User } from './user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User]), FirebaseModule],
  providers: [
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AuthModule {}
