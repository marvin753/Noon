// tests/modules/auth.test.ts — Auth module integration tests
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestApp, closeTestApp } from '../setup.js';
import type { FastifyInstance } from 'fastify';

describe('Auth Module', () => {
  let app: FastifyInstance;

  beforeAll(async () => {
    app = await getTestApp();
  });

  afterAll(async () => {
    await closeTestApp();
  });

  describe('POST /auth/register', () => {
    it('should register a new user and return tokens', async () => {
      const response = await app.inject({
        method: 'POST',
        url: '/auth/register',
        payload: {
          email: `test-${Date.now()}@example.com`,
          password: 'SecurePass123!',
          name: 'Test User',
        },
      });

      expect(response.statusCode).toBe(201);
      const body = JSON.parse(response.body);
      expect(body).toHaveProperty('accessToken');
      expect(body).toHaveProperty('refreshToken');
    });
  });

  describe('POST /auth/login', () => {
    it('should login and return both tokens', async () => {
      // TODO: Implement login test
      expect(true).toBe(true);
    });
  });

  describe('POST /auth/refresh', () => {
    it('should return a new access token', async () => {
      // TODO: Implement refresh test
      expect(true).toBe(true);
    });
  });
});
