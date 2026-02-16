// modules/accounts/controller.ts — Account route handlers
import { FastifyRequest, FastifyReply } from 'fastify';
import { AccountService } from './service.js';

export class AccountController {
  constructor(private readonly service: AccountService) {}

  async listAccounts(request: FastifyRequest, reply: FastifyReply) {
    const result = await this.service.listAccounts(request.userId);
    return reply.send(result);
  }

  async getAccount(request: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
    const result = await this.service.getAccount(request.userId, request.params.id);
    return reply.send(result);
  }
}
