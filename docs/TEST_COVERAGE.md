# Test Coverage

## Current Coverage

### Vacancy Module

| Feature | Scenario | Status | Test File |
|---------|----------|--------|-----------|
| Create Vacancy | Happy path - public vacancy | Automated | `create_vacancy.robot` |
| Create Vacancy | Required field validation | Not Started | - |
| Create Vacancy | Draft save functionality | Not Started | - |
| Edit Vacancy | Modify existing vacancy | Not Started | - |
| Delete Vacancy | Remove vacancy | Not Started | - |

### Authentication Module

| Feature | Scenario | Status | Test File |
|---------|----------|--------|-----------|
| Login | Valid credentials | Automated | `create_vacancy.robot` (as precondition) |
| Login | Invalid credentials | Not Started | - |
| Login | Session timeout handling | Not Started | - |
| Logout | User logout | Not Started | - |

## Gaps & Risks

| Gap | Risk Level | Mitigation |
|-----|------------|------------|
| No negative test cases | Medium | Priority for Phase 2 |
| Single browser only (Chromium) | Low | Cross-browser tests in Phase 3 |
| No API-level validation | Medium | Add API tests to verify data persistence |

## Next Priority

1. Add validation error scenarios for vacancy creation
2. Add API tests to to identify issues faster
3. Data-driven tests for multiple vacancy types
