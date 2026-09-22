---
name: expo
description: "Expo: managed workflow, EAS builds, config, permissions, OTA limits. Same engineering base as react-native with Expo focus; verify SDK version via official docs."
---

# expo

Expo: managed workflow, EAS builds, config, permissions, OTA limits. Same engineering base as react-native with Expo focus; verify SDK version via official docs.

## Official documentation research

Identify the Expo SDK version FIRST (package.json, app.json, app.config.*) — Expo APIs are SDK-gated. Research Router, EAS, config plugins, permissions, builds, and OTA in https://docs.expo.dev/ for that SDK (Router: https://docs.expo.dev/router/introduction/, EAS: https://docs.expo.dev/eas/). Registry: `../../research/documentation-search/references/framework-registry.yaml` (expo). Runtime procedure: `../../research/documentation-search/`.

## Sources (verbatim, zero loss)

- Full verbatim copy in `references/source-verbatim/` (exact cp -R, includes SKILL.md + references/scripts/assets).
- Full text inlined below.

--- BEGIN VERBATIM SOURCE ---
SOURCE: bjornjee-skills/skills/react-native-patterns

---
name: react-native-patterns
description: React Native platform, Metro-port and emulator/simulator worktree isolation, and cleanup conventions (expo-dev-client, adb, avdmanager, simctl). Use when working on React Native apps.
---
# React Native

Applies to React Native projects only — if the repo has no `react-native` dependency in `package.json`, ignore this rule. (The broad TS/TSX matching is deliberate — no file pattern can express the dependency condition.)

## Platform
- Build system: expo-dev-client, not Expo Go.
- Connection modes: `usb` (adb reverse + localhost), `wifi` (LAN IP), `emulator` (10.0.2.2).
- Prefer cloud-hosted signaling for WebRTC — local servers cause ICE failures on non-home networks.
- adb reverse only forwards TCP, not UDP — plan around this for media protocols.

## Engineering
- State: server state → React Query; client state → Zustand; component state until it's shared. No Redux by default.
- Persistence: MMKV over AsyncStorage; encrypt anything sensitive.
- Navigation: auth-gating swaps navigator trees on auth state — never conditionally hidden screens. Deep links and push-tap navigation run after state hydration, not before.
- Lists: FlashList over FlatList past ~50 items (provide size estimates). Hermes stays on. `expo-image` for cached images.

## Worktree ops (agent-dashboard flow)
- Each feature worktree gets a unique Metro port.
- Main project uses default port `8081`. Worktrees start from `8082`, incrementing.
- Scan all worktrees for `.metro-port` files to find ports in use. Verify with `lsof`.
- Write the assigned port to `.metro-port` in the worktree root.
- AVDs are named `feat-<feature_name>`. Created via `avdmanager`, device `pixel_6`.
- iOS Simulators are named `feat-<feature_name>`. Created via `xcrun simctl`, device `iPhone 16`.
- Store the Simulator UUID in `.sim-uuid` in the worktree root.
- Ask the user which platform(s) to set up: Android, iOS, or Both.

### Cleanup
- Kill Metro process on the assigned port (read from `.metro-port`).
- Delete Android AVD `feat-<feature_name>` via `avdmanager`.
- Shut down and delete iOS Simulator (prefer UUID from `.sim-uuid`, fall back to name).
- Remove marker files: `.metro-port`, `.sim-uuid`.

--- END VERBATIM SOURCE ---
