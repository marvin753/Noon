// integrations/tink/webhooks.ts — Tink webhook event handlers for real-time updates
import { logger } from '../../utils/logger.js';

export interface TinkWebhookEvent {
  event: string;
  credentialsId: string;
  userId: string;
  timestamp: string;
}

export async function handleTinkWebhook(event: TinkWebhookEvent): Promise<void> {
  logger.info({ event }, 'Received Tink webhook');

  switch (event.event) {
    case 'credentials:updated':
      // TODO: Sync accounts and transactions for updated credentials
      break;
    case 'credentials:expired':
      // TODO: Update bank connection status to expired
      break;
    default:
      logger.warn({ event: event.event }, 'Unhandled Tink webhook event');
  }
}
