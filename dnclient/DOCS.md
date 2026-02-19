# DNClient Add-on for Home Assistant

## About

This add-on runs [Defined Networking's DNClient](https://www.defined.net/) on your Home Assistant OS instance, giving it connectivity to your Managed Nebula overlay network.

## Setup

1. Go to [admin.defined.net](https://admin.defined.net) and create a host for your Home Assistant instance
2. Generate an enrollment code for the host
3. Paste the enrollment code into this add-on's configuration
4. Start the add-on

After the first successful enrollment, the host identity is persisted. You can clear the enrollment code from the configuration — it won't be needed again unless you re-enroll.

## Network

The add-on uses **host networking** so the Nebula tun interface is created directly on the Home Assistant host. This means other add-ons and Home Assistant itself can communicate over the Nebula network.

## Troubleshooting

- Check the add-on logs for enrollment or connection errors
- Ensure the enrollment code hasn't expired (they are single-use)
- If you need to re-enroll, stop the add-on, clear the persistent data, set a new enrollment code, and restart
