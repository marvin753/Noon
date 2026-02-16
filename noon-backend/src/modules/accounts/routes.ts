// modules/accounts/routes.ts — Account routes: GET / (list), GET /:id (detail)
import { FastifyInstance } from 'fastify';
import { AccountService } from './service.js';
import { AccountController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function accountRoutes(app: FastifyInstance): Promise<void> {
  const service = new AccountService(app);
  const controller = new AccountController(service);

  app.addHook('preHandler', authenticate);

  app.get('/', (req, reply) => controller.listAccounts(req, reply));
  app.get('/:id', (req, reply) => controller.getAccount(req as any, reply));
}
