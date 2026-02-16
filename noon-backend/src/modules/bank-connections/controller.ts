// modules/bank-connections/controller.ts — Bank connection route handlers
import { FastifyRequest, FastifyReply } from 'fastify';
import { BankConnectionService } from './service.js';
import { createConnectionBodySchema, connectionCallbackBodySchema } from './schema.js';
import type { CreateConnectionBody, ConnectionCallbackBody } from './schema.js';

export class BankConnectionController {
  constructor(private readonly service: BankConnectionService) {}

  async initiateConnection(request: FastifyRequest<{ Body: CreateConnectionBody }>, reply: FastifyReply) {
    const body = createConnectionBodySchema.parse(request.body);
    const result = await this.service.initiateConnection(request.userId, body);
    return reply.status(201).send(result);
  }

  async listConnections(request: FastifyRequest, reply: FastifyReply) {
    const result = await this.service.listConnections(request.userId);
    return reply.send(result);
  }

  async handleCallback(request: FastifyRequest<{ Body: ConnectionCallbackBody }>, reply: FastifyReply) {
    const body = connectionCallbackBodySchema.parse(request.body);
    const result = await this.service.handleCallback(request.userId, body);
    return reply.send(result);
  }
}
