// modules/transactions/controller.ts — Transaction route handlers with query parameter parsing
import { FastifyRequest, FastifyReply } from 'fastify';
import { TransactionService } from './service.js';
import { transactionFiltersSchema } from './schema.js';

export class TransactionController {
  constructor(private readonly service: TransactionService) {}

  async listTransactions(request: FastifyRequest, reply: FastifyReply) {
    const filters = transactionFiltersSchema.parse(request.query);
    const result = await this.service.listTransactions(request.userId, filters);
    return reply.send(result);
  }

  async getTransaction(request: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
    const result = await this.service.getTransaction(request.userId, request.params.id);
    return reply.send(result);
  }
}
