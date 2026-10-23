# Reminder App Product Design

## Product Direction

A lightweight Windows desktop reminder app. Users set a title, date, and time, and receive a ringtone and Windows notification when the reminder is due, helping them manage everyday tasks.

The MVP focuses on easy setup, timely reminders, and fewer missed tasks. Data is stored locally, with no account required.

## Core User Flow

1. During installation, choose whether to start the app automatically after signing in to Windows. This option is checked by default.
2. Open the app and create a reminder with a title, date, and time.
3. After saving, view, edit, or delete reminders in the list.
4. Closing the main window keeps the app running in the system tray.
5. When a reminder is due, play the default ringtone and display a Windows notification.
6. Users can stop the ringtone, complete the reminder, or snooze it for 5 minutes.

## MVP Features

| Feature | Scope |
| --- | --- |
| Create reminders | Require a title, date, and time; validate missing fields and times in the past |
| Manage reminders | Sort by due time; support viewing, editing, and deletion; distinguish pending, completed, and missed reminders |
| Due reminders | Trigger the default ringtone and Windows notification together; provide stop, complete, and snooze actions |
| Local storage | Persist reminders and settings across restarts |
| Background operation | Keep a system tray icon after closing the window, with options to reopen the main window or explicitly exit |
| Missed reminders | After restarting the app or waking the computer, send notifications for missed reminders and mark their state, preventing duplicate catch-up notifications |
| Automatic startup | The installer and app settings control the same setting; show its actual state; automatic startup runs only in the system tray |
| Test reminder | Immediately play the ringtone and display a notification to verify that reminders work |
| Uninstallation | Remove the app's automatic startup setting |

## Interface Direction

- **Main window**: Reminder list, status, due time, an add action, and edit/delete actions.
- **Create/edit reminder**: Title, date, time, and a save button; concise input error messages.
- **Settings**: A switch for automatic startup after signing in to Windows and a test reminder button.
- **Reminder actions**: Clearly display the title and provide stop ringtone, complete, and snooze for 5 minutes actions.
- **System tray menu**: Open the app, open settings, and exit.

Use a simple, readable Windows desktop interface that minimizes the steps needed to create and handle reminders.

## Operating Boundaries

- Timely reminders require the computer to be on and the app to be running. Immediate reminders are not guaranteed while the computer is shut down or asleep, or the app has exited.
- The MVP does not wake the computer. Missed reminders are handled after restart or wake.
- Use Windows local time; the first version does not offer a separate time zone selector.
- Windows notification permissions and Do Not Disturb may affect notification display. The test reminder flow should prompt users to check these settings.
- The ringtone plays until stopped or until a reasonable time limit is reached. The exact limit will be decided during implementation.

## Outside MVP Scope

Recurring reminders, custom ringtones, account sign-in, cloud sync, multiple devices, calendar integration, and advanced reminder categories.

## Acceptance Criteria

- After creating a reminder and closing the main window, the ringtone and Windows notification still trigger at the due time.
- Edited reminders trigger at the updated time; deleted reminders do not trigger.
- Stopping the ringtone takes effect immediately; completed reminders do not trigger again; snoozed reminders trigger again after 5 minutes.
- Reminders and settings survive app restarts; missed reminders receive catch-up notifications without duplicates.
- The installer startup option matches app settings; signing in to Windows starts the app in the background when enabled.
- Disabling automatic startup or uninstalling the app prevents automatic startup.
- Each feature change requires relevant new or updated tests, with tests and necessary checks on Windows passing before delivery.
