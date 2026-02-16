// modules/users/service.ts — User profile retrieval and update logic
import { FastifyInstance } from 'fastify';
import { NotFoundError } from '../../utils/errors.js';
import { toUserResponse } from './schema.js';
import type { UserResponse, UpdateUserBody } from './schema.js';

export class UserService {
  constructor(private readonly app: FastifyInstance) {}

  async getProfile(userId: string): Promise<UserResponse> {
    const user = await this.app.prisma.user.findUnique({ where: { id: userId } });
    if (!user) throw new NotFoundError('User');
    return toUserResponse(user);
  }

  async updateProfile(userId: string, body: UpdateUserBody): Promise<UserResponse> {
    const user = await this.app.prisma.user.update({
      where: { id: userId },
      data: body,
    });
    return toUserResponse(user);
  }
}
