// modules/bank-connections/routes.ts — Bank connection routes including POST /callback for Tink OAuth
import { FastifyInstance } from 'fastify';
import { BankConnectionService } from './service.js';
import { BankConnectionController } from './controller.js';
import { authenticate } from '../../middleware/authenticate.js';

export async function bankConnectionRoutes(app: FastifyInstance): Promise<void> {
  const service = new BankConnectionService(app);
  const controller = new BankConnectionController(service);

  app.addHook('preHandler', authenticate);

  app.post('/', (req, reply) => controller.initiateConnection(req, reply));
  app.get('/', (req, reply) => controller.listConnections(req, reply));
  app.post('/callback', (req, reply) => controller.handleCallback(req, reply));
}
