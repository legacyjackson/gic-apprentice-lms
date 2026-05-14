# GIC Apprentice LMS

Learning Management System for the **Global Investment Company Wealth Solutions Counselor Apprenticeship** — a DOL-Registered Apprenticeship under RAPIDS Program No. 3007HY.

Built for Global Investment Company • 300 Frank H. Ogawa Plaza, Suite 254, Oakland, CA 94612.

---

## What this is

A single-file React app (no build step) backed by Supabase. Apprentices log in, work through 30 competency modules across Financial Literacy, Client Service, and Operations, and complete a knowledge check at the end of each. The Related Supplemental Instruction (RSI) provider — Cathy Jackson-Gent — reviews and approves each module before apprentices see it.

**Stack**
- Frontend: React 18 + Tailwind (CDN, no build) — single `index.html`
- Auth & DB: Supabase (Postgres + RLS + Realtime)
- Hosting: Netlify
- Fonts: Newsreader (display serif) + Plus Jakarta Sans (body)

**Brand**
- Royal Blue `#2D1FB1` · Navy Ink `#0F1631` · Bone `#FAF7F2`
- Tagline: *Your Money Made Simple When You Have A System*
- Values: Integrity · Intelligence · Impact

---

## Roles

| Role        | Email                                          | Can do                                                          |
|-------------|------------------------------------------------|-----------------------------------------------------------------|
| `approver`  | `cathy@globalinvestmentcompanies.com`          | Review and approve modules. Only role that can publish content. |
| `admin`     | `julius@globalinvestmentcompanies.com`         | See all modules including drafts, manage apprentices.           |
| `apprentice`| anyone else                                    | Sees only approved modules. Progress + quiz attempts tracked.   |

Roles are auto-assigned via a Supabase trigger on signup based on email.

---

## Content review workflow

Every module is authored as a draft (status = `draft`) and shows a small **"Drafted · Awaiting Review"** badge visible to admins/approvers only. When Cathy clicks **Approve**, the badge disappears and the module footer reads:

> *Reviewed and approved by Cathy Jackson-Gent, Global Investment Company.*

This is the disclosure model the platform runs on. Only Cathy's account can flip the switch.

---

## Repo contents

```
index.html              ← The entire frontend app
netlify.toml            ← Netlify config + security headers
package.json            ← Minimal Node manifest
.gitignore
README.md               ← This file
DEPLOY.md               ← Step-by-step deploy instructions
sql/
  supabase_setup.sql    ← Run once in Supabase SQL Editor
  module1_content.sql   ← Loads Module 1 lessons + quiz
```

See **DEPLOY.md** for the full deploy sequence.

---

## Status

| Component                          | Status                                |
|------------------------------------|---------------------------------------|
| Platform shell                     | ✅ Session 1                          |
| Supabase schema + RLS              | ✅ Session 1                          |
| 30 modules scaffolded (names, hours, objectives) | ✅ Session 1                          |
| Module 1 content (7 lessons + quiz)| ✅ Session 1                          |
| Video recording uploads            | ⏳ Session 2 (DO Spaces + presigner)  |
| OpenAI suggestion sidebar          | ⏳ Session 2                          |
| Employer-token sponsorship         | ⏳ Session 2                          |
| Modules 2–30 content               | ⏳ Sessions 3+                        |
| Final exam (30 competencies)       | ⏳ Future                             |
