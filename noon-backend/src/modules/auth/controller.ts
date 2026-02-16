// modules/auth/controller.ts — Auth route handlers delegating to AuthService
import { FastifyRequest, FastifyReply } from 'fastify';
import { AuthService } from './service.js';
import { registerBodySchema, loginBodySchema, refreshBodySchema } from './schema.js';
import type { RegisterBody, LoginBody, RefreshBody } from './schema.js';

export class AuthController {
  constructor(private readonly service: AuthService) {}

  async register(request: FastifyRequest<{ Body: RegisterBody }>, reply: FastifyReply) {
    const body = registerBodySchema.parse(request.body);
    const result = await this.service.register(body);
    return reply.status(201).send(result);
  }

  async login(request: FastifyRequest<{ Body: LoginBody }>, reply: FastifyReply) {
    const body = loginBodySchema.parse(request.body);
    const result = await this.service.login(body);
    return reply.send(result);
  }

  async refresh(request: FastifyRequest<{ Body: RefreshBody }>, reply: FastifyReply) {
    const body = refreshBodySchema.parse(request.body);
    const result = await this.service.refresh(body);
    return reply.send(result);
  }
}
