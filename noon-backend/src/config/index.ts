// config/index.ts — Environment configuration loader with typed config object
import 'dotenv/config';

export const config = {
  port: parseInt(process.env.PORT || '3000', 10),
  databaseUrl: process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/noon_dev',
  jwt: {
    secret: process.env.JWT_SECRET || 'dev-secret-change-in-production',
    accessExpiry: process.env.JWT_ACCESS_EXPIRY || '15m',
    refreshExpiry: process.env.JWT_REFRESH_EXPIRY || '30d',
  },
  tink: {
    clientId: process.env.TINK_CLIENT_ID || '',
    clientSecret: process.env.TINK_CLIENT_SECRET || '',
    redirectUri: process.env.TINK_REDIRECT_URI || '',
  },
} as const;

export type Config = typeof config;
