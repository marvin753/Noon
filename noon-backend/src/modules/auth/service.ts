// modules/auth/service.ts — Auth business logic: register, login, refresh with dual-token pattern
import { FastifyInstance } from 'fastify';
import { hashPassword, comparePassword } from '../../utils/crypto.js';
import { UnauthorizedError, ValidationError } from '../../utils/errors.js';
import { config } from '../../config/index.js';
import type { RegisterBody, LoginBody, RefreshBody, AuthResponse, RefreshResponse } from './schema.js';

export class AuthService {
  constructor(private readonly app: FastifyInstance) {}

  async register(body: RegisterBody): Promise<AuthResponse> {
    const existingUser = await this.app.prisma.user.findUnique({
      where: { email: body.email },
    });

    if (existingUser) {
      throw new ValidationError('Email already registered');
    }

    const passwordHash = await hashPassword(body.password);

    const user = await this.app.prisma.user.create({
      data: {
        email: body.email,
        passwordHash,
        name: body.name,
      },
    });

    const accessToken = this.app.jwt.sign(
      { userId: user.id, type: 'access' },
      { expiresIn: config.jwt.accessExpiry }
    );

    const refreshToken = this.app.jwt.sign(
      { userId: user.id, type: 'refresh' },
      { expiresIn: config.jwt.refreshExpiry }
    );

    return { accessToken, refreshToken };
  }

  async login(body: LoginBody): Promise<AuthResponse> {
    const user = await this.app.prisma.user.findUnique({
      where: { email: body.email },
    });

    if (!user) {
      throw new UnauthorizedError('Invalid email or password');
    }

    const validPassword = await comparePassword(body.password, user.passwordHash);
    if (!validPassword) {
      throw new UnauthorizedError('Invalid email or password');
    }

    const accessToken = this.app.jwt.sign(
      { userId: user.id, type: 'access' },
      { expiresIn: config.jwt.accessExpiry }
    );

    const refreshToken = this.app.jwt.sign(
      { userId: user.id, type: 'refresh' },
      { expiresIn: config.jwt.refreshExpiry }
    );

    return { accessToken, refreshToken };
  }

  async refresh(body: RefreshBody): Promise<RefreshResponse> {
    try {
      const decoded = this.app.jwt.verify<{ userId: string; type: string }>(body.refreshToken);

      if (decoded.type !== 'refresh') {
        throw new UnauthorizedError('Invalid token type');
      }

      const user = await this.app.prisma.user.findUnique({
        where: { id: decoded.userId },
      });

      if (!user) {
        throw new UnauthorizedError('User not found');
      }

      const accessToken = this.app.jwt.sign(
        { userId: user.id, type: 'access' },
        { expiresIn: config.jwt.accessExpiry }
      );

      return { accessToken };
    } catch {
      throw new UnauthorizedError('Invalid or expired refresh token');
    }
  }
}
