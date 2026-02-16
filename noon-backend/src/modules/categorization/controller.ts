// modules/categorization/controller.ts — Categorization rule route handlers
import { FastifyRequest, FastifyReply } from 'fastify';
import { CategorizationService } from './service.js';
import { createRuleBodySchema, updateRuleBodySchema } from './schema.js';
import type { CreateRuleBody, UpdateRuleBody } from './schema.js';

export class CategorizationController {
  constructor(private readonly service: CategorizationService) {}

  async listRules(request: FastifyRequest, reply: FastifyReply) {
    const result = await this.service.listRules(request.userId);
    return reply.send(result);
  }

  async getRule(request: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
    const result = await this.service.getRule(request.userId, request.params.id);
    return reply.send(result);
  }

  async createRule(request: FastifyRequest<{ Body: CreateRuleBody }>, reply: FastifyReply) {
    const body = createRuleBodySchema.parse(request.body);
    const result = await this.service.createRule(request.userId, body);
    return reply.status(201).send(result);
  }

  async updateRule(request: FastifyRequest<{ Params: { id: string }; Body: UpdateRuleBody }>, reply: FastifyReply) {
    const body = updateRuleBodySchema.parse(request.body);
    const result = await this.service.updateRule(request.userId, request.params.id, body);
    return reply.send(result);
  }

  async deleteRule(request: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
    await this.service.deleteRule(request.userId, request.params.id);
    return reply.status(204).send();
  }
}
