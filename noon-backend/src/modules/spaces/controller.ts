// modules/spaces/controller.ts — Space CRUD route handlers
import { FastifyRequest, FastifyReply } from 'fastify';
import { SpaceService } from './service.js';
import { createSpaceBodySchema, updateSpaceBodySchema, assignTransactionBodySchema } from './schema.js';
import type { CreateSpaceBody, UpdateSpaceBody, AssignTransactionBody } from './schema.js';

export class SpaceController {
  constructor(private readonly service: SpaceService) {}

  async listSpaces(request: FastifyRequest, reply: FastifyReply) {
    const result = await this.service.listSpaces(request.userId);
    return reply.send(result);
  }

  async getSpace(request: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
    const result = await this.service.getSpace(request.userId, request.params.id);
    return reply.send(result);
  }

  async createSpace(request: FastifyRequest<{ Body: CreateSpaceBody }>, reply: FastifyReply) {
    const body = createSpaceBodySchema.parse(request.body);
    const result = await this.service.createSpace(request.userId, body);
    return reply.status(201).send(result);
  }

  async updateSpace(request: FastifyRequest<{ Params: { id: string }; Body: UpdateSpaceBody }>, reply: FastifyReply) {
    const body = updateSpaceBodySchema.parse(request.body);
    const result = await this.service.updateSpace(request.userId, request.params.id, body);
    return reply.send(result);
  }

  async deleteSpace(request: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
    await this.service.deleteSpace(request.userId, request.params.id);
    return reply.status(204).send();
  }

  async assignTransaction(request: FastifyRequest<{ Params: { id: string }; Body: AssignTransactionBody }>, reply: FastifyReply) {
    const body = assignTransactionBodySchema.parse(request.body);
    await this.service.assignTransaction(request.userId, request.params.id, body);
    return reply.status(204).send();
  }
}
