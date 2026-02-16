# Noon Backend

Backend API for the Noon Fintech App - A modern personal finance management platform with Tink banking integration.

## Features

- User authentication with JWT (access & refresh tokens)
- Bank account aggregation via Tink
- Multi-account transaction tracking
- Smart transaction categorization with custom rules
- Budget spaces with shared access
- RESTful API built with Fastify
- PostgreSQL database with Prisma ORM
- Docker containerization
- Production-ready deployment to Fly.io

## Tech Stack

- **Runtime**: Node.js 20+
- **Framework**: Fastify
- **Database**: PostgreSQL 16
- **ORM**: Prisma
- **Authentication**: JWT (@fastify/jwt)
- **Validation**: Zod
- **Testing**: Vitest
- **Language**: TypeScript (strict mode)

## Prerequisites

- Node.js >= 20.0.0
- Docker & Docker Compose
- pnpm/npm/yarn

## Quick Start

### 1. Clone the repository

```bash
git clone <repository-url>
cd noon-backend
```

### 2. Install dependencies

```bash
npm install
```

### 3. Start PostgreSQL

```bash
docker-compose up -d
```

### 4. Configure environment

```bash
cp .env.example .env
# Edit .env with your configuration
```

### 5. Run database migrations

```bash
npm run db:migrate
```

### 6. Start development server

```bash
npm run dev
```

The API will be available at `http://localhost:3000`

## Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm test` - Run tests
- `npm run test:watch` - Run tests in watch mode
- `npm run db:migrate` - Run database migrations
- `npm run db:push` - Push schema changes to database
- `npm run db:seed` - Seed database with sample data
- `npm run db:studio` - Open Prisma Studio
- `npm run lint` - Type check with TypeScript

## Database Schema

The application uses 8 core models:

- **User**: User accounts and authentication
- **BankConnection**: Tink bank connection credentials
- **Account**: Individual bank accounts
- **Transaction**: Financial transactions
- **Space**: Budget spaces for organizing finances
- **SpaceMember**: Shared space access control
- **CategorizationRule**: Automated transaction categorization
- **Category**: Transaction categories

## API Documentation

### Authentication

- `POST /auth/register` - Create new user account
- `POST /auth/login` - Login and receive tokens
- `POST /auth/refresh` - Refresh access token
- `POST /auth/logout` - Invalidate refresh token

### Bank Connections

- `POST /connections` - Initiate new bank connection
- `GET /connections` - List user's bank connections
- `DELETE /connections/:id` - Remove bank connection

### Accounts

- `GET /accounts` - List user's accounts
- `GET /accounts/:id` - Get account details
- `POST /accounts/:id/sync` - Sync account transactions

### Transactions

- `GET /transactions` - List transactions with filters
- `GET /transactions/:id` - Get transaction details
- `PATCH /transactions/:id` - Update transaction (categorize, assign space)

### Spaces

- `POST /spaces` - Create budget space
- `GET /spaces` - List user's spaces
- `PATCH /spaces/:id` - Update space
- `DELETE /spaces/:id` - Delete space
- `POST /spaces/:id/members` - Add member to space

### Categories

- `GET /categories` - List categories
- `POST /categories` - Create custom category

### Categorization Rules

- `POST /rules` - Create categorization rule
- `GET /rules` - List user's rules
- `PATCH /rules/:id` - Update rule
- `DELETE /rules/:id` - Delete rule

## Deployment

### Docker

```bash
docker build -t noon-backend .
docker run -p 3000:3000 --env-file .env noon-backend
```

### Fly.io

```bash
fly deploy
```

## Security

- Passwords hashed with bcrypt
- JWT tokens with short expiry
- Rate limiting on authentication endpoints
- CORS configuration
- Environment variable validation
- SQL injection protection via Prisma

## License

MIT
