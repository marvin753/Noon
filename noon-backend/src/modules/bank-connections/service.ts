// modules/bank-connections/service.ts — Bank connection logic including Tink OAuth callback handling
import { FastifyInstance } from 'fastify';
import { NotFoundError } from '../../utils/errors.js';
import { toBankConnectionResponse } from './schema.js';
import type { BankConnectionResponse, CreateConnectionBody, ConnectionCallbackBody } from './schema.js';

export class BankConnectionService {
  constructor(private readonly app: FastifyInstance) {}

  async initiateConnection(userId: string, body: CreateConnectionBody): Promise<{ tinkLinkUrl: string }> {
    // TODO: Call Tink API to create a credentials request
    // TODO: Return Tink Link URL for the iOS WebView to load
    return { tinkLinkUrl: 'https://link.tink.com/...' };
  }

  async listConnections(userId: string): Promise<BankConnectionResponse[]> {
    const connections = await this.app.prisma.bankConnection.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    });
    return connections.map(toBankConnectionResponse);
  }

  async handleCallback(userId: string, body: ConnectionCallbackBody): Promise<BankConnectionResponse> {
    // TODO: Exchange authorization code with Tink for credentials
    // TODO: Store the Tink credentials ID internally (never exposed to client)
    // TODO: Create bank connection record

    const connection = await this.app.prisma.bankConnection.create({
      data: {
        userId,
        tinkCredentialsId: 'tink-creds-placeholder', // From Tink API exchange
        provider: 'tink',
        status: 'active',
      },
    });

    return toBankConnectionResponse(connection);
  }
}
