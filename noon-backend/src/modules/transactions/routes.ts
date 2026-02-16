// modules/transactions/routes.ts — Transaction routes: GET / (filtered list), GET /:id
import { FastifyInstance } from 'fastify';
import { TransactionService } from './service.js';
import { TransactionController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function transactionRoutes(app: FastifyInstance): Promise<void> {
  const service = new TransactionService(app);
  const controller = new TransactionController(service);

  app.addHook('preHandler', authenticate);

  app.get('/', (req, reply) => controller.listTransactions(req, reply));
  app.get('/:id', (req, reply) => controller.getTransaction(req as any, reply));
}
