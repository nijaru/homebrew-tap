# Homebrew Tap for bru

This tap provides the `bru` formula - a fast, Homebrew-compatible package manager written in Rust.

## Installation

```bash
brew install nijaru/tap/bru
```

## About bru

bru is 5.5x faster than Homebrew with full compatibility:
- Same formulae (Homebrew API)
- Same Cellar structure
- Same bottles
- Fully parallelized operations
- In-memory caching

Visit the [main repository](https://github.com/nijaru/kombrucha) for more information.

## For Maintainers

### Testing Locally with brew test-bot

Before pushing changes, test the formula locally:

```bash
cd /opt/homebrew/Library/Taps/nijaru/homebrew-tap

# Test the formula (builds bottles, runs tests)
brew test-bot --tap=nijaru/tap --local bru

# This will:
# 1. Build bru from source
# 2. Run the test block
# 3. Create bottles for your platform
# 4. Output logs to logs/ directory
# 5. Use ./home/ as $HOME (safe isolation)

# Review logs
cat logs/*

# If successful, bottles will be in current directory
ls *.bottle.tar.gz
```

**⚠️ IMPORTANT**: Never use `--ci-pr`, `--ci-master`, or `--ci-testing` flags on your local machine - they remove all installed packages!

### Automated Bottle Building

This tap uses GitHub Actions to automatically build and publish bottles:

1. **Make changes** in a feature branch
2. **Push and open PR** - brew test-bot runs automatically
3. **Review CI results** - tests run on macOS 13, macOS 14, and Ubuntu
4. **Label PR with `pr-pull`** - bottles are automatically published to GitHub Releases
5. **PR auto-merged** - formula updated with bottle SHAs

### Formula Testing Best Practices

The formula test block tests actual functionality (not just `--version`):
- Tests Homebrew API integration (search, info, deps)
- Verifies bru can parse formula metadata
- Confirms dependency resolution works

See [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) for more testing guidelines.
