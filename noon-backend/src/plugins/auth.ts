// plugins/auth.ts — @fastify/jwt plugin registration for token verification
import { FastifyInstance } from 'fastify';
import fastifyJwt from '@fastify/jwt';
import { config } from '../config/index.js';

export async function registerAuth(app: FastifyInstance): Promise<void> {
  await app.register(fastifyJwt, {
    secret: config.jwt.secret,
  });
}
