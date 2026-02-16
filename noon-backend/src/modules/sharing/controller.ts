// modules/sharing/controller.ts — Sharing route handlers for space member management
import { FastifyRequest, FastifyReply } from 'fastify';
import { SharingService } from './service.js';
import { inviteMemberBodySchema } from './schema.js';
import type { InviteMemberBody } from './schema.js';

export class SharingController {
  constructor(private readonly service: SharingService) {}

  async inviteMember(request: FastifyRequest<{ Body: InviteMemberBody }>, reply: FastifyReply) {
    const body = inviteMemberBodySchema.parse(request.body);
    const result = await this.service.inviteMember(request.userId, body);
    return reply.status(201).send(result);
  }

  async getSharedSpaces(request: FastifyRequest, reply: FastifyReply) {
    const result = await this.service.getSharedSpaces(request.userId);
    return reply.send(result);
  }
}
