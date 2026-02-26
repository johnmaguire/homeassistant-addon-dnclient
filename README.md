# Home Assistant Add-on: DNClient (Defined Networking)

Run [Defined Networking's DNClient](https://www.defined.net/) (Managed Nebula) as a Home Assistant add-on to provide overlay network connectivity to your Home Assistant OS instance.

## Installation

1. In Home Assistant, go to **Settings → Add-ons → Add-on Store**
2. Click the **⋮** menu (top right) → **Repositories**
3. Add this repository URL: `https://github.com/johnmaguire/homeassistant-addon-dnclient`
4. Find **DNClient** in the store and click **Install**

## Configuration

| Option | Description |
|--------|-------------|
| `enrollment_code` | Your enrollment code from the [Defined Networking Admin Panel](https://admin.defined.net). Only needed for first run. |

### First Run

1. Generate an enrollment code from [admin.defined.net](https://admin.defined.net)
2. Paste it into the add-on configuration
3. Start the add-on
4. Once enrolled, you can clear the enrollment code — the host identity is persisted

## How It Works

The add-on runs `dnclient` with host networking and `NET_ADMIN` capability so it can create the Nebula tun interface directly on the Home Assistant host. Configuration is persisted in the add-on's data directory, so the host only needs to enroll once.

## Supported Architectures

- `amd64`
- `aarch64`
