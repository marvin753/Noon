// modules/sharing/routes.ts — Sharing routes: POST /invite, GET /spaces
import { FastifyInstance } from 'fastify';
import { SharingService } from './service.js';
import { SharingController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function sharingRoutes(app: FastifyInstance): Promise<void> {
  const service = new SharingService(app);
  const controller = new SharingController(service);

  app.addHook('preHandler', authenticate);

  app.post('/invite', (req, reply) => controller.inviteMember(req, reply));
  app.get('/spaces', (req, reply) => controller.getSharedSpaces(req, reply));
}
