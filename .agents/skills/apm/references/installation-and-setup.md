# APM Installation and Setup

Use this section when installing, updating, or managing the APM CLI binary itself across platforms (macOS, Linux, Windows, WSL).

## Quick navigation

- **Installation methods**: Quick install, Homebrew, Scoop, pip, manual binary install, custom locations
- **Verifying installation**: Validate successful setup
- **Troubleshooting**: PATH issues, permissions, glibc, AppLocker/WDAC
- **Enterprise mirrors**: Air-gapped setup, mirror URLs, environment variables
- **From source**: Development builds and contributor setup

## Installation methods

### Quick install (recommended)

The fastest way to install APM on any platform:

**macOS/Linux:**

```bash
curl -sSL https://aka.ms/apm-unix | sh
```

**Windows (PowerShell):**

```powershell
irm https://aka.ms/apm-windows | iex
```

Both installers auto-detect your platform (macOS/Linux/Windows, Intel/ARM64) and add `apm` to `PATH`.

### Package managers

**Homebrew (macOS/Linux):**

```bash
brew install microsoft/apm/apm
```

**Scoop (Windows):**

```powershell
scoop bucket add apm https://github.com/microsoft/apm
scoop install apm
```

**pip (all platforms, requires Python 3.10+):**

```bash
pip install apm-cli
```

### Manual binary install

Download platform-specific binaries from [GitHub Releases](https://github.com/microsoft/apm/releases/latest):

**macOS/Linux example (Apple Silicon):**

```bash
curl -L https://github.com/microsoft/apm/releases/latest/download/apm-darwin-arm64.tar.gz | tar -xz
sudo mkdir -p /usr/local/lib/apm
sudo cp -r apm-darwin-arm64/* /usr/local/lib/apm/
sudo ln -sf /usr/local/lib/apm/apm /usr/local/bin/apm
```

**Windows PowerShell example:**

```powershell
Invoke-WebRequest -Uri https://github.com/microsoft/apm/releases/latest/download/apm-windows-x86_64.zip -OutFile apm-windows-x86_64.zip
Expand-Archive -Path .\apm-windows-x86_64.zip -DestinationPath .
$installDir = "$env:LOCALAPPDATA\Programs\apm"
New-Item -ItemType Directory -Force -Path $installDir | Out-Null
Copy-Item -Path .\apm-windows-x86_64\* -Destination $installDir -Recurse -Force
[Environment]::SetEnvironmentVariable("Path", "$installDir;" + [Environment]::GetEnvironmentVariable("Path", "User"), "User")
```

### Custom install locations

For user-local installations without sudo:

**macOS/Linux:**

```bash
curl -sSL https://aka.ms/apm-unix | APM_INSTALL_DIR=$HOME/.local/bin sh
```

**Windows PowerShell:**

```powershell
$env:APM_INSTALL_DIR = "$env:LOCALAPPDATA\Programs\apm\bin"
irm https://aka.ms/apm-windows | iex
```

## Verifying installation

```bash
apm --version
```

## Troubleshooting installation

### `apm: command not found` (macOS/Linux)

Ensure your install directory is in `PATH`:

```bash
echo $PATH | tr ':' '\n' | grep /usr/local/bin
```

If missing, add it to your shell profile (`~/.zshrc`, `~/.bashrc`, etc.):

```bash
export PATH="/usr/local/bin:$PATH"
```

### Permission denied during install (macOS/Linux)

Use `sudo` for system-wide installation, or install to a user-writable directory:

```bash
curl -sSL https://aka.ms/apm-unix | APM_INSTALL_DIR=$HOME/.local/bin sh
```

### Binary install fails on older Linux (glibc compatibility)

If the pre-built binary fails on very old base images, the installer automatically falls back to `pip install --user apm-cli`. If that doesn't resolve, switch to a base image with glibc 2.35 or newer (e.g., Debian `trixie` family or `mcr.microsoft.com/devcontainers/universal:24-trixie`).

### Windows access denied (AppLocker/WDAC)

If your enterprise application control policy blocks execution, add an allow-list rule for `%LOCALAPPDATA%\Programs\apm\*` or use pip as a workaround:

```powershell
pip install --user apm-cli
```

## Enterprise installation and mirrors

For air-gapped or GHES environments, configure mirror URLs before running the installer:

**macOS/Linux:**

```bash
export APM_INSTALLER_BASE_URL="https://artifactory.mycorp.example/generic/apm-install"
export APM_RELEASE_METADATA_URL="https://artifactory.mycorp.example/generic/apm-releases/latest.json"
export APM_RELEASE_BASE_URL="https://artifactory.mycorp.example/generic/apm-releases"
export APM_PYPI_INDEX_URL="https://artifactory.mycorp.example/api/pypi/python-proxy/simple"
export APM_NO_DIRECT_FALLBACK=1

curl -sSL "$APM_INSTALLER_BASE_URL/install.sh" | sh
```

**Windows PowerShell:**

```powershell
$env:APM_INSTALLER_BASE_URL = "https://artifactory.mycorp.example/generic/apm-install"
$env:APM_RELEASE_METADATA_URL = "https://artifactory.mycorp.example/generic/apm-releases/latest.json"
$env:APM_RELEASE_BASE_URL = "https://artifactory.mycorp.example/generic/apm-releases"
$env:APM_PYPI_INDEX_URL = "https://artifactory.mycorp.example/api/pypi/python-proxy/simple"
$env:APM_NO_DIRECT_FALLBACK = "1"

irm "$env:APM_INSTALLER_BASE_URL/install.ps1" | iex
```

Mirror layout for binary releases:

```
apm-releases/
  latest.json
  v0.19.0/
    apm-linux-x86_64.tar.gz
    apm-darwin-arm64.tar.gz
    apm-windows-x86_64.zip
    apm-windows-x86_64.zip.sha256
```

## Environment variables for installation

| Variable                   | Default                                                               | Purpose                                                                |
| -------------------------- | --------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| `APM_INSTALL_DIR`          | `/usr/local/bin` (Unix) / `%LOCALAPPDATA%\Programs\apm\bin` (Windows) | Directory for the apm binary/shim                                      |
| `APM_LIB_DIR`              | `$(dirname APM_INSTALL_DIR)/lib/apm`                                  | (Unix only) Full binary bundle location (must end with `/apm`)         |
| `GITHUB_URL`               | `https://github.com`                                                  | GitHub or GHES base URL (must be https:// on Windows)                  |
| `APM_REPO`                 | `microsoft/apm`                                                       | Repository as owner/name                                               |
| `VERSION`                  | latest                                                                | Pin a specific release tag (format: `v1.2.3`)                          |
| `APM_RELEASE_METADATA_URL` | unset                                                                 | Exact URL for mirrored release metadata                                |
| `APM_RELEASE_BASE_URL`     | unset                                                                 | Base URL for release assets                                            |
| `APM_INSTALLER_BASE_URL`   | unset                                                                 | Base URL containing install.sh and install.ps1                         |
| `APM_PYPI_INDEX_URL`       | unset                                                                 | PyPI-compatible mirror for pip fallback                                |
| `APM_NO_DIRECT_FALLBACK`   | unset                                                                 | Set to `1` to fail closed (no public host fallback)                    |
| `APM_SKIP_CHECKSUM`        | unset                                                                 | (Windows only) Set to `1` to skip SHA256 verification (emergency only) |

## From source (contributors)

For development or building from source:

```bash
git clone https://github.com/microsoft/apm.git
cd apm

# Install uv if not already installed
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create environment and install in development mode
uv venv
uv pip install -e ".[dev]"
source .venv/bin/activate
```

### Build binary from source

```bash
cd apm  # cloned repo
uv pip install pyinstaller
chmod +x scripts/build-binary.sh
./scripts/build-binary.sh
```

The output binary is at `./dist/apm-{platform}-{arch}/apm`.
