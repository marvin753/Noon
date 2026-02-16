// modules/categorization/routes.ts — CRUD routes for categorization rules
import { FastifyInstance } from 'fastify';
import { CategorizationService } from './service.js';
import { CategorizationController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function categorizationRoutes(app: FastifyInstance): Promise<void> {
  const service = new CategorizationService(app);
  const controller = new CategorizationController(service);

  app.addHook('preHandler', authenticate);

  app.get('/', (req, reply) => controller.listRules(req, reply));
  app.get('/:id', (req, reply) => controller.getRule(req as any, reply));
  app.post('/', (req, reply) => controller.createRule(req, reply));
  app.patch('/:id', (req, reply) => controller.updateRule(req as any, reply));
  app.delete('/:id', (req, reply) => controller.deleteRule(req as any, reply));
}
