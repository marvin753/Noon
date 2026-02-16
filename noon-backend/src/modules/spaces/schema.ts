// modules/spaces/schema.ts — Space CRUD schemas and response DTO
import { z } from 'zod';

export const spaceResponseSchema = z.object({
  id: z.string().uuid(),
  name: z.string(),
  budgetAmount: z.number(),
  budgetPeriod: z.enum(['monthly', 'weekly']),
  color: z.string(),
  icon: z.string(),
  createdAt: z.date(),
});

export const createSpaceBodySchema = z.object({
  name: z.string().min(1).max(50),
  budgetAmount: z.number().positive(),
  budgetPeriod: z.enum(['monthly', 'weekly']),
  color: z.string(),
  icon: z.string(),
});

export const updateSpaceBodySchema = z.object({
  name: z.string().min(1).max(50).optional(),
  budgetAmount: z.number().positive().optional(),
  budgetPeriod: z.enum(['monthly', 'weekly']).optional(),
  color: z.string().optional(),
  icon: z.string().optional(),
});

export const assignTransactionBodySchema = z.object({
  transactionId: z.string().uuid(),
});

export type SpaceResponse = z.infer<typeof spaceResponseSchema>;
export type CreateSpaceBody = z.infer<typeof createSpaceBodySchema>;
export type UpdateSpaceBody = z.infer<typeof updateSpaceBodySchema>;
export type AssignTransactionBody = z.infer<typeof assignTransactionBodySchema>;

export function toSpaceResponse(space: {
  id: string; name: string; budgetAmount: any; budgetPeriod: string;
  color: string; icon: string; createdAt: Date;
}): SpaceResponse {
  return {
    id: space.id,
    name: space.name,
    budgetAmount: Number(space.budgetAmount),
    budgetPeriod: space.budgetPeriod as SpaceResponse['budgetPeriod'],
    color: space.color,
    icon: space.icon,
    createdAt: space.createdAt,
  };
}
