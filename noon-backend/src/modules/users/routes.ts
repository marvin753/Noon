// modules/users/routes.ts — User routes: GET /me, PATCH /me (authenticated)
import { FastifyInstance } from 'fastify';
import { UserService } from './service.js';
import { UserController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function userRoutes(app: FastifyInstance): Promise<void> {
  const service = new UserService(app);
  const controller = new UserController(service);

  app.addHook('preHandler', authenticate);

  app.get('/me', (req, reply) => controller.getProfile(req, reply));
  app.patch('/me', (req, reply) => controller.updateProfile(req, reply));
}
