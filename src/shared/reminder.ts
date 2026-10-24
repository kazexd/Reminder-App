export function validateReminder(title: string, dueAt: number, now: number): string | null {
  if (!title.trim()) return 'A title is required.'
  if (!Number.isFinite(dueAt)) return 'A valid date and time are required.'
  if (dueAt <= now) return 'The reminder must be in the future.'
  return null
}
