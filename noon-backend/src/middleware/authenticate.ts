// middleware/authenticate.ts — JWT verification middleware that attaches userId to request
import { FastifyRequest, FastifyReply } from 'fastify';

export async function authenticate(request: FastifyRequest, reply: FastifyReply): Promise<void> {
  try {
    const decoded = await request.jwtVerify<{ userId: string; type: string }>();

    if (decoded.type !== 'access') {
      return reply.status(401).send({ statusCode: 401, error: 'Unauthorized', message: 'Invalid token type' });
    }

    request.userId = decoded.userId;
  } catch (err) {
    return reply.status(401).send({ statusCode: 401, error: 'Unauthorized', message: 'Invalid or expired token' });
  }
}
