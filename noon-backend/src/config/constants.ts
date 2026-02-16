// config/constants.ts — Application constants for routes, pagination, and defaults
export const ROUTE_PREFIXES = {
  AUTH: '/auth',
  USERS: '/users',
  CONNECTIONS: '/connections',
  ACCOUNTS: '/accounts',
  TRANSACTIONS: '/transactions',
  SPACES: '/spaces',
  RULES: '/rules',
  SHARING: '/sharing',
} as const;

export const PAGINATION = {
  DEFAULT_PAGE: 1,
  DEFAULT_LIMIT: 20,
  MAX_LIMIT: 100,
} as const;

export const SUPPORTED_CURRENCIES = ['EUR', 'USD', 'GBP', 'CHF', 'SEK', 'NOK', 'DKK'] as const;

export const TOKEN_TYPES = {
  ACCESS: 'access',
  REFRESH: 'refresh',
} as const;
