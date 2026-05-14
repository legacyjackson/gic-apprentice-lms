# GIC Apprentice LMS — Complete Setup & Deployment Guide

**Version:** Final (post-curriculum)
**Date:** May 13, 2026
**Audience:** Julius (deploying), Cathy (reviewing & approving)
**Supersedes:** DEPLOY.md, DEPLOY-SESSION-2.md

---

## 1. What This System Is

The GIC Apprentice LMS is a single-page web application that delivers the U.S. Department of Labor Registered Apprenticeship for the Wealth Solutions Counselor occupation (RAPIDS code 3007HY). It hosts:

- 30 modules of structured curriculum (~150 lessons, ~360 quiz questions)
- A final comprehensive exam (30 integration-level questions across all competencies)
- Apprentice enrollment via employer-sponsored tokens
- Mentor sign-off workflow for competency completions
- Video upload submissions to DigitalOcean Spaces
- An OpenAI-powered study coach
- AI-disclosure footers awaiting Cathy's approval

This is a **pitch demo**, not a DOL audit-grade certification platform. All AI-generated content carries a footer awaiting review/approval by Cathy.

---

## 2. Architecture at a Glance

```
┌─────────────────────────────────────────────────────────────┐
│  Browser                                                     │
│  ↓                                                           │
│  Netlify CDN  →  gic-apprentice.netlify.app                 │
│  ├── index.html (React, Tailwind, single file)               │
│  └── netlify/functions/                                      │
│      ├── sign-upload.js  (DO Spaces presigned PUT)           │
│      ├── sign-read.js    (DO Spaces presigned GET)           │
│      ├── ai-coach.js     (OpenAI chat completions)           │
│      └── enroll-apprentice.js (token-based enrollment)       │
│                                                              │
│  Data:                                                       │
│  ├── Supabase (Postgres + Auth + RLS)                        │
│  │   → selcyohawrwfmmnsvnwx.supabase.co                      │
│  └── DigitalOcean Spaces (video uploads)                     │
│      → gic-apprentice.sfo3.digitaloceanspaces.com            │
│                                                              │
│  External:                                                   │
│  └── OpenAI API (gpt-4o-mini for study coach)                │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. Pre-Requisites (All Already Provisioned)

| Resource | Status | Location/Identifier |
|---|---|---|
| Supabase project | Live | `https://selcyohawrwfmmnsvnwx.supabase.co` |
| GitHub repo | Live | `https://github.com/legacyjackson/gic-apprentice-lms` |
| DigitalOcean Space | Live | `gic-apprentice` in `sfo3` region |
| Netlify site | Live | `gic-apprentice.netlify.app` |
| OpenAI account | Active | API key in Julius's vault |

If anything in this table is not live, see **Section 13 — From-Scratch Setup**.

---

## 4. Complete File Inventory

All paths relative to repo root.

### 4.1 Root-level files

| File | Purpose |
|---|---|
| `index.html` | The single-page React+Tailwind app. All UI lives here (~2944 lines). |
| `netlify.toml` | Netlify build config — directs functions to `netlify/functions/`. |
| `package.json` | Dependencies: `@aws-sdk/client-s3`, `@aws-sdk/s3-request-presigner`, `@supabase/supabase-js`, `openai`. |
| `.gitignore` | Standard Node + secrets ignores. |
| `README.md` | Project overview for repo visitors. |
| `SETUP-COMPLETE.md` | **This file** — master setup guide. |
| `DEPLOY.md` | Legacy — Session 1 deploy notes (kept for history). |
| `DEPLOY-SESSION-2.md` | Legacy — Session 2 deploy notes (kept for history). |

### 4.2 Netlify Functions (`netlify/functions/`)

| File | What it does | Env vars used |
|---|---|---|
| `sign-upload.js` | Returns a presigned PUT URL for uploading video to DO Spaces. Validates user via Supabase JWT. | `DO_SPACES_KEY`, `DO_SPACES_SECRET`, `DO_SPACES_BUCKET`, `DO_SPACES_REGION`, `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY` |
| `sign-read.js` | Returns a presigned GET URL for playback. Only authorized viewers (apprentice owner, mentor, admin) get URLs. | Same as above |
| `ai-coach.js` | Proxies user questions to OpenAI with module context. Footer marks output as "Drafted · Awaiting Review." | `OPENAI_API_KEY`, `OPENAI_MODEL`, `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY` |
| `enroll-apprentice.js` | Redeems a sponsorship token from an employer, creates the apprentice profile, links to sponsor. | `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY` |

### 4.3 SQL files (`sql/`)

**Schema/feature setup:**
| File | Purpose | Run when |
|---|---|---|
| `session2_setup.sql` | Adds `employer_sponsors`, `sponsorship_tokens`, `competency_submissions` tables, `mentor` role, RLS policies. | Once, after Session 1 schema exists |
| `final_exam_setup.sql` | Adds `final_exams` + `final_exam_attempts` tables, RLS, and inserts the 30-question comprehensive exam. | Once, after all modules loaded |

**Module content (run in any order, each UPDATEs one pre-seeded module row):**

| File | Module | Title | Band | OJL hrs |
|---|---|---|---|---|
| `module1_content.sql` | 1 | Financial Literacy & Planning | CORE-1 | RI 16 |
| `module2_content.sql` | 2 | Time Value of Money | CORE-2 | RI 16 |
| `module3_content.sql` | 3 | Credit, Debt & Lending | CORE-3 | RI 16 |
| `module4_content.sql` | 4 | Risk Management & Insurance | CORE-4 | RI 16 |
| `module5_content.sql` | 5 | Tax Fundamentals | CORE-5 | RI 16 |
| `module6_content.sql` | 6 | Investment Vehicles & Markets | CORE-6 | RI 16 |
| `module7_content.sql` | 7 | Retirement Planning Foundations | CORE-7 | RI 16 |
| `module8_content.sql` | 8 | Estate Planning & Wealth Transfer | CORE-8 | RI 16 |
| `module9_content.sql` | 9 | Ethics, Fiduciary Duty & Regulation | CORE-9 | RI 16 |
| `module10_content.sql` | 10 | Client Discovery & Intake | OJL-1 | 60 |
| `module11_content.sql` | 11 | Goal-Setting & Prioritization | OJL-2 | 60 |
| `module12_content.sql` | 12 | Document Collection & Analysis | OJL-3 | 60 |
| `module13_content.sql` | 13 | Building Financial Statements | OJL-4 | 60 |
| `module14_content.sql` | 14 | Behavioral Finance & Client Coaching | OJL-5 | 80 |
| `module15_content.sql` | 15 | Risk Profiling & Suitability | OJL-6 | 80 |
| `module16_content.sql` | 16 | Plan Presentation & Communication | OJL-7 | 80 |
| `module17_content.sql` | 17 | Implementation & Coordination | OJL-8 | 100 |
| `module18_content.sql` | 18 | Ongoing Reviews & Life Events | OJL-9 | 100 |
| `module19_content.sql` | 19 | Portfolio Construction | OJL-10 | 120 |
| `module20_content.sql` | 20 | Investment Research & Due Diligence | OJL-11 | 100 |
| `module21_content.sql` | 21 | Asset Allocation & Rebalancing | OJL-12 | 100 |
| `module22_content.sql` | 22 | Performance Reporting | OJL-13 | 80 |
| `module23_content.sql` | 23 | Trading & Execution | OJL-14 | 80 |
| `module24_content.sql` | 24 | Tax-Loss Harvesting | OJL-15 | 80 |
| `module25_content.sql` | 25 | Account Administration & Custody | OJL-16 | 80 |
| `module26_content.sql` | 26 | Reconciliation & Operations Controls | OJL-17 | 80 |
| `module27_content.sql` | 27 | Compliance Workflows | OJL-18 | 80 |
| `module28_content.sql` | 28 | Cybersecurity & Data Protection | OJL-19 | 60 |
| `module29_content.sql` | 29 | Practice Management & Business Development | OJL-20 | 80 |
| `module30_content.sql` | 30 | Capstone: Building a Practice | OJL-21 | 120 |

**Totals:** RI hours: 144 (CORE 1-9). OJL hours: ≈1,738 (sums to the apprenticeship's on-the-job requirement).

---

## 5. Deployment Workflow — From Current State

Use this section if your Supabase + Netlify + DO Spaces are already provisioned (they are). For a from-scratch reproduction, jump to **Section 13**.

### Step 1 — Run remaining SQL in Supabase

Open Supabase SQL Editor: `https://supabase.com/dashboard/project/selcyohawrwfmmnsvnwx/sql/new`

Run files in this exact order. Each one independently — paste the contents into a new SQL query, click Run.

1. **`session2_setup.sql`** — *only if not already run earlier*. Safe to re-run (uses `create table if not exists`).
2. **`module1_content.sql` through `module30_content.sql`** — run each. Order doesn't matter among modules, but running 1-30 in sequence is cleanest. Each is a single `UPDATE` on its pre-seeded row.
3. **`final_exam_setup.sql`** — **must run after all modules**. Creates `final_exams` table and inserts the 30-question comprehensive exam.

After all 31 SQL files (30 modules + 1 final exam setup) are run, verify in SQL Editor:

```sql
-- Should return 30 rows, all with content populated
select module_number, title, competency_id, ri_hours, ojl_hours,
       jsonb_array_length(content -> 'lessons') as lesson_count,
       jsonb_array_length(content -> 'quiz' -> 'questions') as quiz_count
from public.modules
order by module_number;

-- Should return 1 row with 30 questions
select exam_code, title, passing_score,
       jsonb_array_length(content -> 'questions') as question_count
from public.final_exams
where exam_code = 'FINAL-COMPREHENSIVE';
```

### Step 2 — Push code to GitHub

From your local clone of `legacyjackson/gic-apprentice-lms`, copy in any updated files (`index.html`, all four `netlify/functions/*.js`, `package.json`, `netlify.toml`) and:

```bash
git add .
git commit -m "Curriculum complete: 30 modules + final exam"
git push origin main
```

Netlify auto-deploys on push to main. Build status visible at `https://app.netlify.com/sites/gic-apprentice/deploys`.

### Step 3 — Confirm Netlify environment variables

In Netlify: Site → Settings → Environment variables. All must be set:

| Variable | Value source |
|---|---|
| `SUPABASE_URL` | `https://selcyohawrwfmmnsvnwx.supabase.co` |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase Dashboard → Project Settings → API → service_role (secret) |
| `OPENAI_API_KEY` | From your OpenAI account |
| `OPENAI_MODEL` | `gpt-4o-mini` |
| `DO_SPACES_KEY` | `DO00VZZDK8UVFVRLU83G` |
| `DO_SPACES_SECRET` | From your DO account |
| `DO_SPACES_BUCKET` | `gic-apprentice` |
| `DO_SPACES_REGION` | `sfo3` |

**Never paste service role keys or secrets into chat.** Set them only in the Netlify env vars panel.

After setting/changing any env var, trigger a redeploy: Netlify → Deploys → Trigger deploy → Deploy site.

### Step 4 — Hard-refresh the live site

Browser cache bites after deploys. Open the live site and do a **hard refresh** (Cmd+Shift+R on Mac, Ctrl+Shift+R on Win/Linux). Otherwise you may see stale UI for several minutes.

### Step 5 — Promote admin and approver accounts

Both `cathy@globalinvestmentcompanies.com` and `julius@globalinvestmentcompanies.com` are auto-promoted on first sign-up (logic lives in `enroll-apprentice.js` and Supabase auth hooks). To confirm or fix manually:

```sql
-- Verify roles (replace email if needed)
select id, email, role from public.profiles
where email in ('cathy@globalinvestmentcompanies.com',
                'julius@globalinvestmentcompanies.com');

-- If cathy is not 'approver', set it:
update public.profiles
set role = 'approver'
where email = 'cathy@globalinvestmentcompanies.com';

-- If julius is not 'admin', set it:
update public.profiles
set role = 'admin'
where email = 'julius@globalinvestmentcompanies.com';
```

Only `cathy` (role `approver`) can approve AI-drafted content. Julius is `admin` for system management but explicitly not an approver — that authority sits with Cathy.

---

## 6. Verification Checklist

Before handing to Cathy, verify each:

- [ ] Supabase: all 30 modules show populated content via the SQL verification query above
- [ ] Supabase: final exam present with 30 questions
- [ ] Supabase: `profiles` table shows `cathy` as `approver`, `julius` as `admin`
- [ ] Netlify: latest deploy shows green status
- [ ] Netlify: all 8 environment variables set
- [ ] Live site: hard refresh, sign in as `julius`, see admin dashboard
- [ ] Live site: navigate to Module 1, lessons render, quiz works, 80% passing
- [ ] Live site: navigate to Module 30 (Capstone), final lesson and quiz render
- [ ] AI coach: ask a question in any module, receive response with "Drafted · Awaiting Review" footer
- [ ] Video upload: record/upload a short test clip in any module submission; playback works
- [ ] Token enrollment: generate a sponsorship token in admin UI; redeem in incognito; new apprentice profile created
- [ ] Mentor sign-off: submit a competency as test apprentice; mentor account sees and can sign off

---

## 7. Cathy's Review Handoff

Once verification passes, send Cathy the following note (suggested wording):

> Hi Mom,
>
> The apprentice platform is live at `https://gic-apprentice.netlify.app`. Your account is `cathy@globalinvestmentcompanies.com` — sign in with the magic link you'll receive by email.
>
> When you sign in you'll be tagged as the **approver**, which means anything I or the AI drafted shows up with a "Drafted · Awaiting Review" badge until you approve it. Approving a piece of content swaps the badge to "Reviewed and approved by Cathy Jackson-Gent, Global Investment Company."
>
> What I'd like you to review:
>
> 1. **Module content (30 modules).** Each module has 5 lessons and a 12-question quiz. Quality benchmark is Module 1 — the others follow the same depth.
> 2. **Final comprehensive exam.** 30 questions, one per competency, integration-level. Visible from admin dashboard.
> 3. **AI coach tone.** Click into any lesson and try a question — make sure the responses feel right for GIC's voice.
> 4. **Branding and tone overall.** Editorial financial gravitas — does it read like a 40-year Bay Area firm or like a startup?
>
> No rush. Take a week. Flag anything that needs revision and I'll fix and resubmit before any apprentices touch it.
>
> Love,
> Julius

---

## 8. Cathy's Approval Workflow

From the admin dashboard, Cathy will see:

- **Pending Approval** section — content with "Drafted · Awaiting Review" badge
- For each item: Preview button, Approve button, Request Revision button (with comment field)
- Approval is logged in `competency_submissions` (or equivalent audit table) with timestamp and reviewer ID

The footer on approved items reads:
> *Reviewed and approved by Cathy Jackson-Gent, Global Investment Company.*

This is the trust signal that distinguishes GIC's curriculum from generic LMS content. Treat the badge change as the moment a piece of curriculum becomes "official."

---

## 9. Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| Site loads but shows blank module list | RLS blocking `select` on `modules` | Confirm user is authenticated; check RLS policy on `public.modules` |
| AI coach returns "Error" | `OPENAI_API_KEY` missing or model name wrong | Verify env var; redeploy after setting |
| Upload returns 403 from DO Spaces | CORS not configured on Space | Set CORS to allow PUT/GET from `https://gic-apprentice.netlify.app`, headers `*` |
| Stale UI after deploy | Browser cache | Hard refresh (Cmd+Shift+R) |
| `tg_set_updated_at()` does not exist on `final_exam_setup.sql` run | Session 1 trigger function not present | Run trigger function definition: `create or replace function public.tg_set_updated_at() returns trigger as $$ begin new.updated_at = now(); return new; end; $$ language plpgsql;` |
| Module update SQL says "0 rows affected" | The pre-seeded module row doesn't exist | Insert it manually first: `insert into public.modules (module_number) values (N) on conflict do nothing;` then re-run the content SQL |
| Cathy can't approve content | Her `profiles.role` is not `approver` | Run the role-update SQL in Step 5 |

---

## 10. File Sizes Reference (for storage planning)

| Category | Size |
|---|---|
| `index.html` | ~120 KB |
| 30 module SQL files | ~35-40 KB each, ~1.1 MB total |
| `final_exam_setup.sql` | ~30 KB |
| `session2_setup.sql` | ~14 KB |
| Each Netlify function | 2-8 KB |
| Total repo (code + SQL, no node_modules) | ~1.5 MB |

---

## 11. Maintenance Notes

- **OpenAI model** — set to `gpt-4o-mini` for cost efficiency. Upgrade to `gpt-4o` for higher-quality coach responses if budget permits; cost is ~10x.
- **DO Spaces lifecycle** — videos older than 1 year are not auto-deleted by default. Consider setting up a lifecycle policy if storage grows past plan limits.
- **Supabase free tier** — sufficient for pilot. Plan to upgrade to Pro once active apprentices exceed ~10 concurrent users or the database approaches 500MB.
- **Custom domain** — eventually `learn.globalinvestmentcompanies.com`. Set up via Netlify → Domain management → Add custom domain. Add the DNS records at your registrar.

---

## 12. Architecture Decisions (for the Record)

For Cathy's reference and any future developer onboarding:

1. **Single-HTML SPA** — entire UI is one `index.html` with React via CDN, no build step. Trades performance/bundle-size against deploy simplicity. Right call for pilot scale.
2. **Supabase + RLS** — Postgres + auth + row-level security replaces a custom backend. RLS policies enforce that apprentices only see their own data; mentors see their cohort; admins see all.
3. **Netlify Functions** — serverless endpoints for actions that need server-side secrets (DO Spaces signing, OpenAI proxy, enrollment). Keeps secrets out of the browser.
4. **DO Spaces over S3** — chose DO for cost (predictable flat rate) and SFO region proximity. Interchangeable with S3 via the AWS SDK.
5. **Cathy-as-sole-approver** — codified at the role level (`approver` is a distinct role from `admin`). Julius can administer the system but cannot approve content. This is intentional and aligns with Cathy's role as the firm's RSI Provider.

---

## 13. From-Scratch Setup (Reference Only)

Use this section only if Supabase project is being recreated or migrated. Skip otherwise.

### 13.1 Create Supabase project
1. Sign in at supabase.com → New project
2. Save the project URL and the publishable + service_role keys
3. SQL Editor → run a base schema (modules table with 30 pre-seeded rows, profiles table with role enum, RLS policies, `tg_set_updated_at()` trigger function). The current live schema can be exported via Supabase CLI `supabase db dump --schema public > base_schema.sql` for reference.

### 13.2 Create DO Space
1. DO Console → Spaces → Create Space
2. Region: `sfo3`, Name: `gic-apprentice`
3. Create access key (Spaces Keys section); save key ID and secret
4. Configure CORS: PUT, GET, OPTIONS from `https://gic-apprentice.netlify.app` with headers `*`

### 13.3 Create Netlify site
1. Netlify → New site from Git → connect `legacyjackson/gic-apprentice-lms`
2. Build settings: build command empty (no build step), publish directory `.`
3. Set all 8 environment variables (Section 5, Step 3)
4. Deploy

### 13.4 Run SQL files
Follow Section 5, Step 1.

### 13.5 Promote admins
Follow Section 5, Step 5.

---

## 14. Quick Reference — One-Page Summary

**Live URLs:**
- App: `https://gic-apprentice.netlify.app`
- Supabase: `https://supabase.com/dashboard/project/selcyohawrwfmmnsvnwx`
- GitHub: `https://github.com/legacyjackson/gic-apprentice-lms`
- DO Spaces: `https://cloud.digitalocean.com/spaces/gic-apprentice`
- Netlify: `https://app.netlify.com/sites/gic-apprentice`

**Roles:**
- `admin` — Julius. System management, no approval authority.
- `approver` — Cathy. Sole authority to approve AI-drafted content.
- `mentor` — supervising counselors. Sign off competency submissions.
- `apprentice` — learners. Default role on token enrollment.

**SQL to run in this deployment (in order):**
1. `session2_setup.sql` (if not already run)
2. `module1_content.sql` through `module30_content.sql`
3. `final_exam_setup.sql`

**Total deliverable:**
- 30 modules · 150 lessons · 360 module-quiz questions
- 1 final comprehensive exam · 30 integration-level questions
- 4 Netlify functions for AI, uploads, downloads, enrollment
- 1 React+Tailwind single-page app

---

**End of guide.** Questions for Julius? Slack me. Questions for Cathy? Wait for her review notes and address them in the next deploy.
