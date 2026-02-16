// modules/spaces/service.ts — Space CRUD operations and transaction assignment
import { FastifyInstance } from 'fastify';
import { NotFoundError, ForbiddenError } from '../../utils/errors.js';
import { toSpaceResponse } from './schema.js';
import type { SpaceResponse, CreateSpaceBody, UpdateSpaceBody, AssignTransactionBody } from './schema.js';

export class SpaceService {
  constructor(private readonly app: FastifyInstance) {}

  async listSpaces(userId: string): Promise<SpaceResponse[]> {
    const spaces = await this.app.prisma.space.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    });
    return spaces.map(toSpaceResponse);
  }

  async getSpace(userId: string, spaceId: string): Promise<SpaceResponse> {
    const space = await this.app.prisma.space.findFirst({
      where: { id: spaceId, userId },
    });
    if (!space) throw new NotFoundError('Space');
    return toSpaceResponse(space);
  }

  async createSpace(userId: string, body: CreateSpaceBody): Promise<SpaceResponse> {
    const space = await this.app.prisma.space.create({
      data: { ...body, userId },
    });
    return toSpaceResponse(space);
  }

  async updateSpace(userId: string, spaceId: string, body: UpdateSpaceBody): Promise<SpaceResponse> {
    const existing = await this.app.prisma.space.findFirst({ where: { id: spaceId, userId } });
    if (!existing) throw new NotFoundError('Space');

    const space = await this.app.prisma.space.update({
      where: { id: spaceId },
      data: body,
    });
    return toSpaceResponse(space);
  }

  async deleteSpace(userId: string, spaceId: string): Promise<void> {
    const existing = await this.app.prisma.space.findFirst({ where: { id: spaceId, userId } });
    if (!existing) throw new NotFoundError('Space');

    await this.app.prisma.space.delete({ where: { id: spaceId } });
  }

  async assignTransaction(userId: string, spaceId: string, body: AssignTransactionBody): Promise<void> {
    const space = await this.app.prisma.space.findFirst({ where: { id: spaceId, userId } });
    if (!space) throw new NotFoundError('Space');

    const transaction = await this.app.prisma.transaction.findFirst({
      where: { id: body.transactionId, account: { userId } },
    });
    if (!transaction) throw new NotFoundError('Transaction');

    await this.app.prisma.transaction.update({
      where: { id: body.transactionId },
      data: { spaceId },
    });
  }
}
