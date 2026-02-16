// modules/transactions/service.ts — Transaction retrieval with filtering and pagination
import { FastifyInstance } from 'fastify';
import { NotFoundError } from '../../utils/errors.js';
import { toTransactionResponse } from './schema.js';
import type { TransactionResponse, TransactionFilters } from './schema.js';

export class TransactionService {
  constructor(private readonly app: FastifyInstance) {}

  async listTransactions(userId: string, filters: TransactionFilters): Promise<TransactionResponse[]> {
    const where: any = {
      account: { userId },
    };

    if (filters.accountId) where.accountId = filters.accountId;
    if (filters.spaceId) where.spaceId = filters.spaceId;
    if (filters.dateFrom || filters.dateTo) {
      where.date = {};
      if (filters.dateFrom) where.date.gte = new Date(filters.dateFrom);
      if (filters.dateTo) where.date.lte = new Date(filters.dateTo);
    }
    if (filters.search) {
      where.OR = [
        { description: { contains: filters.search, mode: 'insensitive' } },
        { merchantName: { contains: filters.search, mode: 'insensitive' } },
      ];
    }

    const transactions = await this.app.prisma.transaction.findMany({
      where,
      orderBy: { date: 'desc' },
      skip: (filters.page - 1) * filters.limit,
      take: filters.limit,
    });

    return transactions.map(toTransactionResponse);
  }

  async getTransaction(userId: string, transactionId: string): Promise<TransactionResponse> {
    const transaction = await this.app.prisma.transaction.findFirst({
      where: { id: transactionId, account: { userId } },
    });
    if (!transaction) throw new NotFoundError('Transaction');
    return toTransactionResponse(transaction);
  }
}
