// tests/modules/categorization.test.ts — Categorization rules module tests
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestApp, closeTestApp } from '../setup.js';
import { getAuthHeaders } from '../helpers/index.js';
import type { FastifyInstance } from 'fastify';

describe('Categorization Module', () => {
  let app: FastifyInstance;
  let authHeaders: Record<string, string>;

  beforeAll(async () => {
    app = await getTestApp();
    authHeaders = await getAuthHeaders(app);
  });

  afterAll(async () => {
    await closeTestApp();
  });

  describe('POST /rules', () => {
    it('should create a new categorization rule', async () => {
      // TODO: Implement create rule test (needs a space first)
      expect(true).toBe(true);
    });
  });

  describe('GET /rules', () => {
    it('should list user rules', async () => {
      // TODO: Implement list rules test
      expect(true).toBe(true);
    });
  });
});
