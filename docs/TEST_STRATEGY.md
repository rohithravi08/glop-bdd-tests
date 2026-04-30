# Test Strategy

## Approach

This project follows a **documentation-first** approach to test automation. Before writing automated tests, we establish a shared understanding of the system through collaboration with the development team.

## Collaboration Model

1. **Discovery Sessions** - Initial sync calls to map application workflows and identify critical paths
2. **Shared Artifacts** - Architecture diagrams, test coverage matrices, and manual test cases documented in this repository
3. **Selector Strategy** - Work with frontend developers to implement `data-testid` attributes for stable test selectors

## Phased Rollout

| Phase | Focus | Status |
|-------|-------|--------|
| 1 | Core user journey (Vacancy Creation) | Complete |
| 2 | Authentication & edge cases | Not started |
| 3 | Cross-browser & regression suite | Not started |

## Tool Selection

- **Robot Framework** - Readable BDD syntax accessible to non-technical stakeholders
- **Playwright (Browser Library)** - Modern, reliable browser automation with auto-wait capabilities
- **GitHub Actions** - CI/CD integration for automated test runs on every PR

## Test Priorities

1. **Smoke Tests** - Critical paths that must work (login, vacancy creation)
2. **Regression Tests** - Prevent breaking existing functionality
3. **Edge Cases** - Validation errors, boundary conditions

## Living Documentation

This strategy evolves as we learn more about the system. All changes are version-controlled and reviewed.
