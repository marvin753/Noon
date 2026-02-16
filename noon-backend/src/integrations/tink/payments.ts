// integrations/tink/payments.ts — Payment initiation via Tink API
import { tinkRequest } from './client.js';
import type { TinkPaymentRequest } from './types.js';

export async function initiatePayment(
  userAccessToken: string,
  payment: TinkPaymentRequest
): Promise<{ paymentRequestId: string }> {
  // TODO: Implement Tink payment initiation
  return tinkRequest<{ paymentRequestId: string }>('/api/v1/payments/requests', {
    method: 'POST',
    token: userAccessToken,
    body: payment as unknown as Record<string, unknown>,
  });
}
