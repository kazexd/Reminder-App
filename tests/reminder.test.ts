import { describe, expect, it } from 'vitest'
import { validateReminder } from '../src/shared/reminder'

describe('reminder input validation', () => {
  it('rejects empty titles', () => expect(validateReminder('  ', 200, 100)).toBe('A title is required.'))
  it('rejects invalid dates', () => expect(validateReminder('Task', NaN, 100)).toBe('A valid date and time are required.'))
  it.each([99, 100])('rejects a due time at or before now: %s', due => {
    expect(validateReminder('Task', due, 100)).toBe('The reminder must be in the future.')
  })
  it('accepts a future reminder', () => expect(validateReminder('Task', 101, 100)).toBeNull())
})
