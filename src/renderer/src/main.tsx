import React from 'react'
import { createRoot } from 'react-dom/client'
import './style.css'

function App() {
  return <main>
    <header><p className="eyebrow">YOUR TIME, REMEMBERED</p><h1>Reminder App</h1></header>
    <section aria-labelledby="reminders-heading">
      <h2 id="reminders-heading">Your reminders</h2>
      <p>No reminders yet.</p>
      <p>This is the project foundation. Creating reminders, notifications, and settings are coming next.</p>
    </section>
  </main>
}

createRoot(document.getElementById('root')!).render(<React.StrictMode><App /></React.StrictMode>)
