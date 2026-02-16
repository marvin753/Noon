// tests/modules/spaces.test.ts — Spaces module integration tests
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestApp, closeTestApp } from '../setup.js';
import { getAuthHeaders } from '../helpers/index.js';
import type { FastifyInstance } from 'fastify';

describe('Spaces Module', () => {
  let app: FastifyInstance;
  let authHeaders: Record<string, string>;

  beforeAll(async () => {
    app = await getTestApp();
    authHeaders = await getAuthHeaders(app);
  });

  afterAll(async () => {
    await closeTestApp();
  });

  describe('POST /spaces', () => {
    it('should create a new space', async () => {
      const response = await app.inject({
        method: 'POST',
        url: '/spaces',
        headers: authHeaders,
        payload: {
          name: 'Groceries',
          budgetAmount: 400,
          budgetPeriod: 'monthly',
          color: '#4CAF50',
          icon: 'cart',
        },
      });

      expect(response.statusCode).toBe(201);
      const body = JSON.parse(response.body);
      expect(body.name).toBe('Groceries');
    });
  });

  describe('GET /spaces', () => {
    it('should list user spaces', async () => {
      // TODO: Implement list test
      expect(true).toBe(true);
    });
  });
});
