# Homebrew Tap Automation

This tap is automatically updated when new releases are published to [nijaru/kombrucha](https://github.com/nijaru/kombrucha).

## How It Works

1. **Release Published** in `nijaru/kombrucha`
   - GitHub Actions workflow `.github/workflows/update-homebrew-tap.yml` is triggered
   - Extracts version from release tag (e.g., `v0.1.12` → `0.1.12`)

2. **Repository Dispatch** to `nijaru/homebrew-tap`
   - Sends `repository_dispatch` event with version info
   - Requires `TAP_UPDATE_TOKEN` secret with `repo` scope

3. **Formula Update** in `nijaru/homebrew-tap`
   - Workflow `.github/workflows/update-formula.yml` is triggered
   - Downloads release tarball and calculates SHA256
   - Updates `Formula/bru.rb` with new version and SHA256
   - Commits and pushes changes

## Manual Trigger

You can also manually update the formula:

```bash
# Via GitHub CLI
gh workflow run update-formula.yml -R nijaru/homebrew-tap -f version=0.1.12

# Via GitHub UI
# Go to Actions → Update Formula → Run workflow → Enter version
```

## Setup Requirements

### GitHub Token

The automation requires a Personal Access Token (PAT) with `repo` scope:

1. Create PAT: https://github.com/settings/tokens/new
   - Name: "Homebrew Tap Update"
   - Scopes: `repo` (full control of private repositories)
   - Expiration: No expiration or 1 year

2. Add as secret to `nijaru/kombrucha`:
   - Go to Settings → Secrets and variables → Actions
   - New repository secret: `TAP_UPDATE_TOKEN`
   - Paste the PAT

### Permissions

The workflows require:
- **kombrucha**: `contents: read`, `actions: write`
- **homebrew-tap**: `contents: write`

## Testing

Test the automation after setup:

```bash
# 1. Make a test release in kombrucha
gh release create v0.1.13-test --prerelease --notes "Test release"

# 2. Check if homebrew-tap was updated
cd ../homebrew-tap
git pull
grep "0.1.13-test" Formula/bru.rb

# 3. Clean up test release
gh release delete v0.1.13-test -R nijaru/kombrucha
```

## Manual Formula Update

If automation fails, update manually:

```bash
cd homebrew-tap

# Get SHA256 of new version
VERSION="0.1.12"
curl -sL "https://github.com/nijaru/kombrucha/archive/refs/tags/v${VERSION}.tar.gz" | shasum -a 256

# Update Formula/bru.rb
# - Change version in URL
# - Update SHA256

# Commit and push
git add Formula/bru.rb
git commit -m "chore: update formula to v${VERSION}"
git push
```

## Troubleshooting

- **Workflow not triggering**: Check `TAP_UPDATE_TOKEN` is set correctly
- **Permission denied**: Token needs `repo` scope
- **SHA256 mismatch**: Verify tarball downloaded correctly
- **Commit fails**: Check bot has write access to homebrew-tap
