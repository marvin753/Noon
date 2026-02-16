// modules/sharing/service.ts — Space sharing and member invitation logic
import { FastifyInstance } from 'fastify';
import { NotFoundError, ForbiddenError, ValidationError } from '../../utils/errors.js';
import { toSpaceMemberResponse } from './schema.js';
import type { SpaceMemberResponse, InviteMemberBody } from './schema.js';

export class SharingService {
  constructor(private readonly app: FastifyInstance) {}

  async inviteMember(userId: string, body: InviteMemberBody): Promise<SpaceMemberResponse> {
    // Verify the inviting user owns the space
    const space = await this.app.prisma.space.findFirst({
      where: { id: body.spaceId, userId },
    });
    if (!space) throw new NotFoundError('Space');

    // Find the invited user by email
    const invitedUser = await this.app.prisma.user.findUnique({
      where: { email: body.email },
    });
    if (!invitedUser) throw new NotFoundError('User');

    // Check if already a member
    const existingMember = await this.app.prisma.spaceMember.findFirst({
      where: { spaceId: body.spaceId, userId: invitedUser.id },
    });
    if (existingMember) throw new ValidationError('User is already a member of this space');

    const member = await this.app.prisma.spaceMember.create({
      data: {
        spaceId: body.spaceId,
        userId: invitedUser.id,
        role: body.role,
      },
    });

    return toSpaceMemberResponse(member);
  }

  async getSharedSpaces(userId: string): Promise<SpaceMemberResponse[]> {
    const memberships = await this.app.prisma.spaceMember.findMany({
      where: { userId },
      orderBy: { joinedAt: 'desc' },
    });
    return memberships.map(toSpaceMemberResponse);
  }
}
