// integrations/tink/transactions.ts — Fetch transactions from Tink API
import { tinkRequest } from './client.js';
import type { TinkTransaction } from './types.js';

export async function fetchTinkTransactions(
  userAccessToken: string,
  accountId?: string
): Promise<TinkTransaction[]> {
  const path = accountId
    ? `/data/v2/transactions?accountIdIn=${accountId}`
    : '/data/v2/transactions';

  const response = await tinkRequest<{ transactions: TinkTransaction[] }>(path, {
    token: userAccessToken,
  });
  return response.transactions;
}
