// integrations/tink/client.ts — HTTP client for Tink API using undici
import { request } from 'undici';
import { config } from '../../config/index.js';
import { logger } from '../../utils/logger.js';

const TINK_BASE_URL = 'https://api.tink.com';

export async function tinkRequest<T>(
  path: string,
  options: {
    method?: string;
    body?: Record<string, unknown>;
    token?: string;
  } = {}
): Promise<T> {
  const { method = 'GET', body, token } = options;

  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
  };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const response = await request(`${TINK_BASE_URL}${path}`, {
    method: method as any,
    headers,
    body: body ? JSON.stringify(body) : undefined,
  });

  const data = await response.body.json() as T;

  if (response.statusCode >= 400) {
    logger.error({ statusCode: response.statusCode, path, data }, 'Tink API error');
    throw new Error(`Tink API error: ${response.statusCode}`);
  }

  return data;
}
