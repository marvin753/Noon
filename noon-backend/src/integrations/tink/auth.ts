// integrations/tink/auth.ts — Tink OAuth token management for server-to-server auth
import { config } from '../../config/index.js';
import { tinkRequest } from './client.js';
import type { TinkTokenResponse } from './types.js';

let cachedToken: { token: string; expiresAt: number } | null = null;

export async function getTinkAccessToken(): Promise<string> {
  if (cachedToken && cachedToken.expiresAt > Date.now()) {
    return cachedToken.token;
  }

  const response = await tinkRequest<TinkTokenResponse>('/api/v1/oauth/token', {
    method: 'POST',
    body: {
      client_id: config.tink.clientId,
      client_secret: config.tink.clientSecret,
      grant_type: 'client_credentials',
      scope: 'accounts:read,transactions:read,credentials:write',
    },
  });

  cachedToken = {
    token: response.access_token,
    expiresAt: Date.now() + (response.expires_in - 60) * 1000,
  };

  return response.access_token;
}

export async function exchangeAuthorizationCode(authorizationCode: string): Promise<TinkTokenResponse> {
  return tinkRequest<TinkTokenResponse>('/api/v1/oauth/token', {
    method: 'POST',
    body: {
      client_id: config.tink.clientId,
      client_secret: config.tink.clientSecret,
      grant_type: 'authorization_code',
      code: authorizationCode,
    },
  });
}
