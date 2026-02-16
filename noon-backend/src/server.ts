// server.ts — Application entry point with graceful shutdown handling
import { buildApp } from './app.js';
import { config } from './config/index.js';
import { logger } from './utils/logger.js';

const start = async () => {
  const app = await buildApp();
  try {
    await app.listen({ port: config.port, host: '0.0.0.0' });
    logger.info(`Server running on port ${config.port}`);
  } catch (err) {
    logger.error(err);
    process.exit(1);
  }
};

// Graceful shutdown
const signals: NodeJS.Signals[] = ['SIGINT', 'SIGTERM'];
signals.forEach((signal) => {
  process.on(signal, async () => {
    logger.info(`Received ${signal}, shutting down gracefully...`);
    process.exit(0);
  });
});

start();
