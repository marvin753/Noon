// modules/accounts/service.ts — Account retrieval logic with internal field stripping
import { FastifyInstance } from 'fastify';
import { NotFoundError } from '../../utils/errors.js';
import { toAccountResponse } from './schema.js';
import type { AccountResponse } from './schema.js';

export class AccountService {
  constructor(private readonly app: FastifyInstance) {}

  async listAccounts(userId: string): Promise<AccountResponse[]> {
    const accounts = await this.app.prisma.account.findMany({
      where: { userId },
      orderBy: { name: 'asc' },
    });
    return accounts.map(toAccountResponse);
  }

  async getAccount(userId: string, accountId: string): Promise<AccountResponse> {
    const account = await this.app.prisma.account.findFirst({
      where: { id: accountId, userId },
    });
    if (!account) throw new NotFoundError('Account');
    return toAccountResponse(account);
  }
}
