// modules/users/controller.ts — User route handlers for profile management
import { FastifyRequest, FastifyReply } from 'fastify';
import { UserService } from './service.js';
import { updateUserBodySchema } from './schema.js';
import type { UpdateUserBody } from './schema.js';

export class UserController {
  constructor(private readonly service: UserService) {}

  async getProfile(request: FastifyRequest, reply: FastifyReply) {
    const result = await this.service.getProfile(request.userId);
    return reply.send(result);
  }

  async updateProfile(request: FastifyRequest<{ Body: UpdateUserBody }>, reply: FastifyReply) {
    const body = updateUserBodySchema.parse(request.body);
    const result = await this.service.updateProfile(request.userId, body);
    return reply.send(result);
  }
}
