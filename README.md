# FactoryDevOps — DevOps & CI/CD + Automated Testing Framework

[![CI](https://github.com/aslamalkarywk7/factory-devops/actions/workflows/ci.yml/badge.svg)](https://github.com/aslamalkarywk7/factory-devops/actions/workflows/ci.yml)

> **DevOps & CI/CD Project** + **Automated Testing Framework** — Pipeline كاملة من Push لحد Deploy تلقائي مع تغطية اختبار 80%+.

## ماذا ستتعلم من هذا المشروع؟

- **CI/CD:** GitHub Actions — `lint → test → build → deploy` — كل Push يمر ببوابات جودة
- **Testing Framework:** Vitest (unit 80%) + Playwright (E2E) — إطار اختبار جاهز لأي مشروع
- **Docker:** Compose + Multi-stage Build — بيئة متطابقة للتطوير والإنتاج
- **Monitoring:** Health Checks + Metrics — جاهزية إنتاجية

## هيكل الـ Pipeline

```
push/PR
  ↓
┌─────────┐   ┌──────────┐   ┌────────┐   ┌───────────┐
│  Lint   │→  │ Test     │→  │ Build  │→  │ Deploy    │
│ ESLint  │   │ Vitest   │   │ Docker │   │ Preview   │
│ TypeChk │   │ Coverage │   │ Push   │   │ Staging   │
└─────────┘   └──────────┘   └────────┘   └───────────┘
     │              │              │              │
     └────── بوابات عبور — لا عبور بدون نجاح ──────┘
```

## Stack

```
Node.js 20 + TypeScript
Vitest + Playwright
Docker + Docker Compose
GitHub Actions
```

## Quick Start

```bash
git clone https://github.com/aslamalkarywk7/factory-devops.git
cd factory-devops
docker compose up -d          # Postgres + Redis
npm install
npm run test:coverage         # Vitest + Coverage
npm run test:e2e              # Playwright
npm run build                 # Production build
```

## CI/CD — GitHub Actions

**Triggers:** Push → `main` | PR → `main`

| Job | خطوة |
|---|---|
| `lint` | ESLint + TypeScript |
| `test` | Vitest + Coverage gate (80%) |
| `e2e` | Playwright — Chromium + WebKit |
| `build` | Docker multi-stage Build + Push |
| `deploy` | Preview Deploy (Vercel) + Staging |

التعريف كامل: [.github/workflows/ci.yml](./.github/workflows/ci.yml)

## Automated Testing Framework

### Unit Tests (Vitest) — تغطية 80%+

```ts
// tests/unit/auth.test.ts
import { describe, it, expect } from 'vitest'
import { AuthService } from '../../src/auth'

describe('AuthService', () => {
  it('hashes passwords', async () => {
    const hash = await auth.hashPassword('secret')
    expect(await auth.verifyPassword('secret', hash)).toBe(true)
  })
})
```

### E2E Tests (Playwright)

```ts
// tests/e2e/login.spec.ts
import { test, expect } from '@playwright/test'

test('guest can log in', async ({ page }) => {
  await page.goto('/login')
  await page.fill('[name=email]', 'test@example.com')
  await page.click('button[type=submit]')
  await expect(page).toHaveURL('/dashboard')
})
```

### Coverage Gate

```bash
npm run test:coverage
# exit 1 if coverage < 80% — CI blocks merge
```

## Docker

**docker-compose.yml:**

```yaml
services:
  app: { build: ., ports: ["3000:3000"] }
  db: { image: postgres:16, environment: { POSTGRES_PASSWORD: secret } }
  redis: { image: redis:7 }
```

## License

MIT © Islam Al-Nashar
