// modules/bank-connections/schema.ts — Bank connection schemas with callback handler DTO
import { z } from 'zod';

export const bankConnectionResponseSchema = z.object({
  id: z.string().uuid(),
  provider: z.string(),
  status: z.enum(['active', 'expired', 'revoked']),
  consentExpiresAt: z.date().nullable(),
  createdAt: z.date(),
});

export const createConnectionBodySchema = z.object({
  provider: z.string().min(1),
});

export const connectionCallbackBodySchema = z.object({
  authorizationCode: z.string().min(1),
});

export type BankConnectionResponse = z.infer<typeof bankConnectionResponseSchema>;
export type CreateConnectionBody = z.infer<typeof createConnectionBodySchema>;
export type ConnectionCallbackBody = z.infer<typeof connectionCallbackBodySchema>;

export function toBankConnectionResponse(conn: {
  id: string; provider: string; status: string; consentExpiresAt: Date | null; createdAt: Date;
}): BankConnectionResponse {
  return {
    id: conn.id,
    provider: conn.provider,
    status: conn.status as BankConnectionResponse['status'],
    consentExpiresAt: conn.consentExpiresAt,
    createdAt: conn.createdAt,
  };
}
