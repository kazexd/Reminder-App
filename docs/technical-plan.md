# Technical Plan

## Stack

- Electron for the Windows desktop runtime and system integration.
- React and TypeScript for the interface; electron-vite and Vite for development and builds.
- SQLite for persistent local reminders and settings, to be integrated in the next feature stage.
- electron-builder with NSIS for Windows installers. A custom installer page will offer automatic startup, enabled by default.
- Vitest for logic tests and Playwright for Electron startup checks and later feature workflow tests.

## Responsibilities

The main process will own reminder scheduling, storage, notifications, system tray behavior, and startup settings. React will render the interface. A sandboxed preload bridge will expose specific operations through IPC, with context isolation enabled and Node.js disabled in the renderer. Inputs must also be validated in the main process.

The scheduler will recheck due reminders after startup and resume. The installer and app settings must control the same Windows startup entry. Automatic startup will use a background flag. No server, account, or Windows Service is required.

## Current Foundation

The repository contains a desktop window, a React placeholder screen, a restricted preload bridge, reminder input validation, and unit tests. Closing the window currently exits the app. Persistence, scheduling, ringtone, notifications, tray behavior, startup settings, and the installer are planned features, not implemented capabilities.

## Development

Use Node.js 22.16 or newer supported by the locked dependencies. Run `npm ci`, then `npm run dev`. Run `npm test`, `npm run test:docs`, and `npm run test:desktop` before delivery. The desktop test also runs type checking and a production build. Build output is written to `out/`; an installer is not generated yet.

## Next Steps

1. Implement SQLite storage and reminder creation, editing, and deletion.
2. Add scheduling, notifications, ringtone, completion, snooze, and missed reminders.
3. Add tray operation and startup settings, then the NSIS installer and Windows workflow tests.

## References

- [Electron context isolation](https://www.electronjs.org/docs/latest/tutorial/context-isolation)
- [Electron process model](https://www.electronjs.org/docs/latest/tutorial/process-model)
- [electron-builder NSIS](https://www.electron.build/docs/nsis/)
