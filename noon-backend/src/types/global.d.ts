// types/global.d.ts — Global type declarations for environment variables
declare namespace NodeJS {
  interface ProcessEnv {
    PORT?: string;
    DATABASE_URL?: string;
    JWT_SECRET?: string;
    JWT_ACCESS_EXPIRY?: string;
    JWT_REFRESH_EXPIRY?: string;
    TINK_CLIENT_ID?: string;
    TINK_CLIENT_SECRET?: string;
    TINK_REDIRECT_URI?: string;
    NODE_ENV?: 'development' | 'production' | 'test';
    LOG_LEVEL?: string;
  }
}
