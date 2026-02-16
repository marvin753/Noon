// integrations/tink/accounts.ts — Fetch and sync accounts from Tink API
import { getTinkAccessToken } from './auth.js';
import { tinkRequest } from './client.js';
import type { TinkAccount } from './types.js';

export async function fetchTinkAccounts(userAccessToken: string): Promise<TinkAccount[]> {
  const response = await tinkRequest<{ accounts: TinkAccount[] }>('/data/v2/accounts', {
    token: userAccessToken,
  });
  return response.accounts;
}
