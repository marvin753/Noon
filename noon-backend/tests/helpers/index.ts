// tests/helpers/index.ts — Test utility functions for creating users and auth headers
import type { FastifyInstance } from 'fastify';

export async function createTestUser(app: FastifyInstance, overrides: Record<string, string> = {}) {
  const userData = {
    email: overrides.email || `test-${Date.now()}@example.com`,
    password: overrides.password || 'TestPassword123!',
    name: overrides.name || 'Test User',
  };

  const response = await app.inject({
    method: 'POST',
    url: '/auth/register',
    payload: userData,
  });

  return {
    ...JSON.parse(response.body),
    ...userData,
  };
}

export async function getAuthHeaders(app: FastifyInstance, email?: string): Promise<Record<string, string>> {
  const user = await createTestUser(app, email ? { email } : {});
  return {
    Authorization: `Bearer ${user.accessToken}`,
  };
}
