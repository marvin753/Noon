// modules/users/schema.ts — User request/response schemas with UserResponse DTO
import { z } from 'zod';

export const userResponseSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string(),
  createdAt: z.date(),
});

export const updateUserBodySchema = z.object({
  name: z.string().min(1).max(100).optional(),
  email: z.string().email().optional(),
});

export type UserResponse = z.infer<typeof userResponseSchema>;
export type UpdateUserBody = z.infer<typeof updateUserBodySchema>;

export function toUserResponse(user: { id: string; email: string; name: string; createdAt: Date }): UserResponse {
  return { id: user.id, email: user.email, name: user.name, createdAt: user.createdAt };
}
