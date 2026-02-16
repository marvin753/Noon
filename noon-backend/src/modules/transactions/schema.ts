// modules/transactions/schema.ts — Transaction response DTO and filter schemas
import { z } from 'zod';

export const transactionResponseSchema = z.object({
  id: z.string().uuid(),
  accountId: z.string().uuid(),
  amount: z.number(),
  currency: z.string(),
  description: z.string(),
  merchantName: z.string().nullable(),
  date: z.date(),
  categoryId: z.string().uuid().nullable(),
  spaceId: z.string().uuid().nullable(),
  isAutoAssigned: z.boolean(),
});

export const transactionFiltersSchema = z.object({
  accountId: z.string().uuid().optional(),
  spaceId: z.string().uuid().optional(),
  dateFrom: z.string().datetime().optional(),
  dateTo: z.string().datetime().optional(),
  search: z.string().optional(),
  page: z.coerce.number().int().positive().default(1),
  limit: z.coerce.number().int().positive().max(100).default(20),
});

export type TransactionResponse = z.infer<typeof transactionResponseSchema>;
export type TransactionFilters = z.infer<typeof transactionFiltersSchema>;

export function toTransactionResponse(tx: {
  id: string; accountId: string; amount: any; currency: string;
  description: string; merchantName: string | null; date: Date;
  categoryId: string | null; spaceId: string | null; isAutoAssigned: boolean;
}): TransactionResponse {
  return {
    id: tx.id,
    accountId: tx.accountId,
    amount: Number(tx.amount),
    currency: tx.currency,
    description: tx.description,
    merchantName: tx.merchantName,
    date: tx.date,
    categoryId: tx.categoryId,
    spaceId: tx.spaceId,
    isAutoAssigned: tx.isAutoAssigned,
  };
}
