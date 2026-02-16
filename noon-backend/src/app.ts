// app.ts — Fastify application factory with plugin and route registration
import Fastify, { FastifyInstance } from 'fastify';
import { registerCors } from './plugins/cors.js';
import { registerAuth } from './plugins/auth.js';
import { registerPrisma } from './plugins/prisma.js';
import { registerErrorHandler } from './plugins/error-handler.js';
import { registerRateLimit } from './middleware/rate-limit.js';
import { authRoutes } from './modules/auth/routes.js';
import { userRoutes } from './modules/users/routes.js';
import { bankConnectionRoutes } from './modules/bank-connections/routes.js';
import { accountRoutes } from './modules/accounts/routes.js';
import { transactionRoutes } from './modules/transactions/routes.js';
import { spaceRoutes } from './modules/spaces/routes.js';
import { categorizationRoutes } from './modules/categorization/routes.js';
import { sharingRoutes } from './modules/sharing/routes.js';
export async function buildApp(): Promise<FastifyInstance> {
  const app = Fastify({
    logger: {
      level: process.env.LOG_LEVEL || 'info',
      transport:
        process.env.NODE_ENV !== 'production'
          ? { target: 'pino-pretty', options: { colorize: true } }
          : undefined,
    },
  });

  // Register plugins
  await registerCors(app);
  await registerAuth(app);
  await registerPrisma(app);
  await registerErrorHandler(app);
  await registerRateLimit(app);

  // Register routes
  await app.register(authRoutes, { prefix: '/auth' });
  await app.register(userRoutes, { prefix: '/users' });
  await app.register(bankConnectionRoutes, { prefix: '/connections' });
  await app.register(accountRoutes, { prefix: '/accounts' });
  await app.register(transactionRoutes, { prefix: '/transactions' });
  await app.register(spaceRoutes, { prefix: '/spaces' });
  await app.register(categorizationRoutes, { prefix: '/rules' });
  await app.register(sharingRoutes, { prefix: '/sharing' });

  // Health check
  app.get('/health', async () => ({ status: 'ok' }));

  return app;
}
