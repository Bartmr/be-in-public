import { Column, Entity, PrimaryColumn } from 'typeorm';
import { Role } from './roles/roles';

@Entity()
export class User {
  @PrimaryColumn('uuid')
  id!: string;

  @Column({
    type: 'enum',
    enum: [Role.EndUser, Role.Admin],
  })
  role!: Role;

  @Column('text')
  firebaseUid!: string;
}
