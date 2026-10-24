import { _electron as electron, expect, test } from '@playwright/test'

test('desktop app opens its local interface with isolated renderer', async () => {
  const app = await electron.launch({ args: ['.'] })
  try {
    const window = await app.firstWindow()
    await expect(window.getByRole('heading', { name: 'Reminder App', exact: true })).toBeVisible()
    await expect(window.getByText('No reminders yet.', { exact: true })).toBeVisible()
    expect(await window.evaluate(() => typeof (globalThis as Record<string, unknown>).require)).toBe('undefined')
    expect(await window.evaluate(() => (globalThis as Record<string, unknown>).reminderApp)).toEqual({ platform: 'windows' })
  } finally {
    await app.close()
  }
})
