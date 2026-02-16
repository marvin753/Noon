// modules/auth/routes.ts — Auth route definitions: register, login, refresh
import { FastifyInstance } from 'fastify';
import { AuthService } from './service.js';
import { AuthController } from './controller.js';

export async function authRoutes(app: FastifyInstance): Promise<void> {
  const service = new AuthService(app);
  const controller = new AuthController(service);

  app.post('/register', (req, reply) => controller.register(req, reply));
  app.post('/login', (req, reply) => controller.login(req, reply));
  app.post('/refresh', (req, reply) => controller.refresh(req, reply));
}
