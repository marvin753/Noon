// plugins/error-handler.ts — Global error handler mapping errors to HTTP responses
import { FastifyInstance, FastifyError } from 'fastify';
import { ZodError } from 'zod';
import { AppError } from '../utils/errors.js';
import { logger } from '../utils/logger.js';

export async function registerErrorHandler(app: FastifyInstance): Promise<void> {
  app.setErrorHandler((error: FastifyError | AppError | ZodError, request, reply) => {
    logger.error({ err: error, url: request.url, method: request.method });

    if (error instanceof ZodError) {
      return reply.status(400).send({
        statusCode: 400,
        error: 'Validation Error',
        message: error.errors.map((e) => e.message).join(', '),
      });
    }

    if (error instanceof AppError) {
      return reply.status(error.statusCode).send({
        statusCode: error.statusCode,
        error: error.name,
        message: error.message,
      });
    }

    const statusCode = (error as FastifyError).statusCode || 500;
    return reply.status(statusCode).send({
      statusCode,
      error: 'Internal Server Error',
      message: statusCode === 500 ? 'An unexpected error occurred' : error.message,
    });
  });
}
