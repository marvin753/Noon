// modules/accounts/schema.ts — Account response DTO stripping internal tinkAccountId
import { z } from 'zod';

export const accountResponseSchema = z.object({
  id: z.string().uuid(),
  bankConnectionId: z.string().uuid(),
  name: z.string(),
  iban: z.string(),
  balance: z.number(),
  currency: z.string(),
  type: z.enum(['checking', 'savings']),
  lastSyncedAt: z.date().nullable(),
});

export type AccountResponse = z.infer<typeof accountResponseSchema>;

export function toAccountResponse(account: {
  id: string; bankConnectionId: string; name: string; iban: string;
  balance: any; currency: string; type: string; lastSyncedAt: Date | null;
}): AccountResponse {
  return {
    id: account.id,
    bankConnectionId: account.bankConnectionId,
    name: account.name,
    iban: account.iban,
    balance: Number(account.balance),
    currency: account.currency,
    type: account.type as AccountResponse['type'],
    lastSyncedAt: account.lastSyncedAt,
  };
}
