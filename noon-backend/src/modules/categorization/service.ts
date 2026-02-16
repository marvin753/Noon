// modules/categorization/service.ts — CRUD operations for auto-categorization rules
import { FastifyInstance } from 'fastify';
import { NotFoundError } from '../../utils/errors.js';
import { toCategorizationRuleResponse } from './schema.js';
import type { CategorizationRuleResponse, CreateRuleBody, UpdateRuleBody } from './schema.js';

export class CategorizationService {
  constructor(private readonly app: FastifyInstance) {}

  async listRules(userId: string): Promise<CategorizationRuleResponse[]> {
    const rules = await this.app.prisma.categorizationRule.findMany({
      where: { userId },
      orderBy: { priority: 'asc' },
    });
    return rules.map(toCategorizationRuleResponse);
  }

  async getRule(userId: string, ruleId: string): Promise<CategorizationRuleResponse> {
    const rule = await this.app.prisma.categorizationRule.findFirst({
      where: { id: ruleId, userId },
    });
    if (!rule) throw new NotFoundError('Rule');
    return toCategorizationRuleResponse(rule);
  }

  async createRule(userId: string, body: CreateRuleBody): Promise<CategorizationRuleResponse> {
    const rule = await this.app.prisma.categorizationRule.create({
      data: { ...body, userId },
    });
    return toCategorizationRuleResponse(rule);
  }

  async updateRule(userId: string, ruleId: string, body: UpdateRuleBody): Promise<CategorizationRuleResponse> {
    const existing = await this.app.prisma.categorizationRule.findFirst({ where: { id: ruleId, userId } });
    if (!existing) throw new NotFoundError('Rule');

    const rule = await this.app.prisma.categorizationRule.update({
      where: { id: ruleId },
      data: body,
    });
    return toCategorizationRuleResponse(rule);
  }

  async deleteRule(userId: string, ruleId: string): Promise<void> {
    const existing = await this.app.prisma.categorizationRule.findFirst({ where: { id: ruleId, userId } });
    if (!existing) throw new NotFoundError('Rule');

    await this.app.prisma.categorizationRule.delete({ where: { id: ruleId } });
  }
}
