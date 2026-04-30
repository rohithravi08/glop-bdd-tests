# GloPros BDD Test Automation

UI automation using Robot Framework + Browser (Playwright) library.

## Prerequisites

- Python 3.9+
- Node.js 18+

## Setup

```bash
# Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate    # Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Download browser binaries (one-time)
rfbrowser init
```

## Run Tests

```bash
source .venv/bin/activate
robot --pythonpath . tests/
```

Run by tag:
```bash
robot --pythonpath . --include smoke tests/
```

## Results

After running, check `results/report.html` for test report.

## Project Structure

```
tests/              # Test suites
resources/pages/    # Page keywords & locators
resources/common/   # Shared setup/teardown
data/environments/  # Environment configs (URLs, credentials)
```

## Configuration

- `data/environments/dev.yaml` - URLs, browser settings
- `.env` - Credentials (copy from `.env.example`)

## CI/CD (GitHub Actions)

Tests run automatically on push/PR to `main` branch.

### Setup GitHub Secrets

1. Go to repo **Settings > Secrets and variables > Actions**
2. Add these secrets:
   - `GLOP_EMAIL` - Login email
   - `GLOP_PASSWORD` - Login password

Tests run in headless mode automatically in CI.
