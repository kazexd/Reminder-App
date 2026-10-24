import { contextBridge } from 'electron'

// Expose only explicit capabilities as features are implemented.
contextBridge.exposeInMainWorld('reminderApp', { platform: 'windows' })
