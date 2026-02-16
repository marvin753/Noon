// modules/sharing/schema.ts — Sharing schemas for space member invitations
import { z } from 'zod';

export const spaceMemberResponseSchema = z.object({
  id: z.string().uuid(),
  spaceId: z.string().uuid(),
  userId: z.string().uuid(),
  role: z.enum(['owner', 'member']),
  joinedAt: z.date(),
});

export const inviteMemberBodySchema = z.object({
  spaceId: z.string().uuid(),
  email: z.string().email(),
  role: z.enum(['owner', 'member']).default('member'),
});

export type SpaceMemberResponse = z.infer<typeof spaceMemberResponseSchema>;
export type InviteMemberBody = z.infer<typeof inviteMemberBodySchema>;

export function toSpaceMemberResponse(member: {
  id: string; spaceId: string; userId: string; role: string; joinedAt: Date;
}): SpaceMemberResponse {
  return {
    id: member.id,
    spaceId: member.spaceId,
    userId: member.userId,
    role: member.role as SpaceMemberResponse['role'],
    joinedAt: member.joinedAt,
  };
}
