// types/fastify.d.ts — Fastify type augmentation for custom decorators and request properties
import { PrismaClient } from '@prisma/client';

declare module 'fastify' {
  interface FastifyInstance {
    prisma: PrismaClient;
  }

  interface FastifyRequest {
    userId: string;
  }
}
