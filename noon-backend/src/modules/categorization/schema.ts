// modules/categorization/schema.ts — Categorization rule schemas and response DTO
import { z } from 'zod';

export const categorizationRuleResponseSchema = z.object({
  id: z.string().uuid(),
  field: z.string(),
  operator: z.string(),
  value: z.string(),
  targetSpaceId: z.string().uuid(),
  priority: z.number().int(),
  isActive: z.boolean(),
});

export const createRuleBodySchema = z.object({
  field: z.string().min(1),
  operator: z.string().min(1),
  value: z.string().min(1),
  targetSpaceId: z.string().uuid(),
  priority: z.number().int().min(0).default(0),
  isActive: z.boolean().default(true),
});

export const updateRuleBodySchema = z.object({
  field: z.string().min(1).optional(),
  operator: z.string().min(1).optional(),
  value: z.string().min(1).optional(),
  targetSpaceId: z.string().uuid().optional(),
  priority: z.number().int().min(0).optional(),
  isActive: z.boolean().optional(),
});

export type CategorizationRuleResponse = z.infer<typeof categorizationRuleResponseSchema>;
export type CreateRuleBody = z.infer<typeof createRuleBodySchema>;
export type UpdateRuleBody = z.infer<typeof updateRuleBodySchema>;

export function toCategorizationRuleResponse(rule: {
  id: string; field: string; operator: string; value: string;
  targetSpaceId: string; priority: number; isActive: boolean;
}): CategorizationRuleResponse {
  return {
    id: rule.id,
    field: rule.field,
    operator: rule.operator,
    value: rule.value,
    targetSpaceId: rule.targetSpaceId,
    priority: rule.priority,
    isActive: rule.isActive,
  };
}
