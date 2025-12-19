# Adding a Rust CLI to nijaru/homebrew-tap

Use this prompt template to add a new Rust CLI project.

## Prerequisites

- Project published to crates.io
- Repository has `TAP_UPDATE_TOKEN` secret configured (PAT with repo access to homebrew-tap)

## Prompt

```
Add <PROJECT_NAME> to the nijaru homebrew tap with hybrid prebuilt/source formula.

Project details:
- Repo: nijaru/<PROJECT_NAME>
- Description: <ONE_LINE_DESCRIPTION>
- Binary name: <BINARY_NAME> (usually same as project name)
- System deps: <NONE or list like "libacl1-dev">
- Toolchain: <stable or nightly>
- Multiple binaries: <NO or list like "main-bin, helper-bin">

Tasks:
1. Update .github/workflows/release.yml to match the sy pattern:
   - Add tag trigger (on: push: tags: - "v*")
   - Create tarballs with SHA256 checksums
   - Create draft GitHub release
   - Publish to crates.io via OIDC
   - Auto-update homebrew-tap formula
   - Finalize release

2. Create Formula/<project>.rb in homebrew-tap:
   - Prebuilt binaries for macOS arm64, macOS x64, Linux x64
   - Include test block that verifies --version and --help
   - Use placeholder SHAs (release workflow will update)

Reference implementations:
- sy: https://github.com/nijaru/sy/.github/workflows/release.yml
- jb: https://github.com/nijaru/jb/.github/workflows/release.yml
```

## After Setup

1. Commit and push changes to both repos
2. Tag a release: `git tag v<VERSION> && git push origin v<VERSION>`
3. Release workflow will:
   - Build binaries
   - Create GitHub release (draft)
   - Publish to crates.io
   - Update homebrew-tap formula with real SHAs
   - Finalize release

## Formula Template

```ruby
class <ClassName> < Formula
  desc "<description>"
  homepage "https://github.com/nijaru/<project>"
  version "<version>"
  license "MIT"
  head "https://github.com/nijaru/<project>.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/<project>/releases/download/v<version>/<project>-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/<project>/releases/download/v<version>/<project>-x86_64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nijaru/<project>/releases/download/v<version>/<project>-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "<binary>"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/<binary> --version")
    assert_match "<keyword>", shell_output("#{bin}/<binary> --help")
  end
end
```

## Release Workflow Template

See `jb/.github/workflows/release.yml` for a complete example. Key stages:

1. **verify** - Check version, run clippy/fmt
2. **build-binaries** - Parallel builds for each target
3. **create-release** - Draft GitHub release with artifacts
4. **publish-crates** - OIDC auth to crates.io
5. **update-homebrew** - Update formula in tap repo
6. **finalize** - Publish draft release
