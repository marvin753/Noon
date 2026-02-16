// modules/spaces/routes.ts — Space CRUD routes plus transaction assignment
import { FastifyInstance } from 'fastify';
import { SpaceService } from './service.js';
import { SpaceController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function spaceRoutes(app: FastifyInstance): Promise<void> {
  const service = new SpaceService(app);
  const controller = new SpaceController(service);

  app.addHook('preHandler', authenticate);

  app.get('/', (req, reply) => controller.listSpaces(req, reply));
  app.get('/:id', (req, reply) => controller.getSpace(req as any, reply));
  app.post('/', (req, reply) => controller.createSpace(req, reply));
  app.patch('/:id', (req, reply) => controller.updateSpace(req as any, reply));
  app.delete('/:id', (req, reply) => controller.deleteSpace(req as any, reply));
  app.post('/:id/assign', (req, reply) => controller.assignTransaction(req as any, reply));
}
