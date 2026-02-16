// integrations/tink/types.ts — Type definitions for Tink API responses
export interface TinkTokenResponse {
  access_token: string;
  token_type: string;
  expires_in: number;
  scope: string;
}

export interface TinkAccount {
  id: string;
  name: string;
  type: string;
  iban: string;
  balance: { amount: { value: number; currencyCode: string } };
}

export interface TinkTransaction {
  id: string;
  accountId: string;
  amount: { value: number; currencyCode: string };
  descriptions: { original: string; display: string };
  merchantInformation?: { merchantName: string };
  dates: { booked: string };
  categories?: { pfm: { id: string; name: string } };
}

export interface TinkCredentials {
  id: string;
  providerName: string;
  status: string;
}

export interface TinkPaymentRequest {
  amount: { value: number; currencyCode: string };
  recipientAccountId: string;
  message?: string;
}
