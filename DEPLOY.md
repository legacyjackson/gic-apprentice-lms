# Deploy Guide — GIC Apprentice LMS (Session 1)

This walks you through getting the LMS live. Same pattern as Life House Workshop Studio — GitHub web editor + Netlify dashboard + Supabase SQL editor. No terminal required.

**Total time: ~20 minutes.**

---

## Step 1 — Supabase schema (already done, but verify)

You should have already run `sql/supabase_setup.sql` in the Supabase SQL Editor against project `selcyohawrwfmmnsvnwx`. To verify:

1. Go to https://supabase.com/dashboard/project/selcyohawrwfmmnsvnwx
2. SQL Editor → New query → paste this and run:
   ```sql
   select count(*) as modules, count(*) filter (where status = 'draft') as drafts from modules;
   ```
3. You should see `modules = 30` and `drafts = 30`. If you see `0`, run `sql/supabase_setup.sql` first.

**Note:** `supabase_setup.sql` is safe to re-run. It uses `if not exists` and `on conflict do nothing`. It won't wipe content.

---

## Step 2 — Load Module 1 content

1. Supabase → SQL Editor → New query
2. Paste the entire contents of `sql/module1_content.sql`
3. Click **Run**
4. Verify:
   ```sql
   select module_number, name, status, jsonb_array_length(content->'lessons') as lessons
   from modules where module_number = 1;
   ```
   You should see `lessons = 7` and `status = draft`.

---

## Step 3 — Turn off email confirmation

This is a private apprenticeship platform — you don't want apprentices stuck waiting on confirmation emails.

1. Supabase → Authentication → Providers → **Email**
2. Toggle **Confirm email** → **OFF**
3. Save

---

## Step 4 — Create Cathy's and your accounts

1. Supabase → Authentication → Users → **Add user** → **Create new user**
2. Email: `cathy@globalinvestmentcompanies.com`
3. Password: (pick something strong, give it to Cathy in person or via your normal channel)
4. Check **Auto Confirm User**
5. Click **Create user**
6. Repeat for `julius@globalinvestmentcompanies.com`

The trigger we installed in Step 1 will automatically set:
- Cathy → `role = approver`
- Julius → `role = admin`
- Everyone else → `role = apprentice`

To verify:
```sql
select email, role, full_name from profiles where email like '%globalinvestmentcompanies%';
```

---

## Step 5 — Push the frontend to GitHub

Repo: https://github.com/legacyjackson/gic-apprentice-lms

Using the GitHub web editor (press `.` on the repo page, or click **Add file → Upload files**), add these files at the repo root:

- `index.html`
- `netlify.toml`
- `package.json`
- `README.md`
- `.gitignore`

And in a `sql/` subfolder (optional but recommended for safekeeping):

- `sql/supabase_setup.sql`
- `sql/module1_content.sql`

Commit. That's it.

---

## Step 6 — Deploy on Netlify

1. https://app.netlify.com → **Add new site** → **Import an existing project**
2. Connect GitHub → select `legacyjackson/gic-apprentice-lms`
3. Build settings:
   - Build command: *(leave blank)*
   - Publish directory: `.`
4. **Deploy site**

No environment variables needed for Session 1 — Supabase credentials are public-safe and already in `window.GIC_CONFIG` inside `index.html`. Row Level Security on Supabase is what actually protects your data.

After ~30 seconds you'll have a URL like `https://random-name-12345.netlify.app`. Site Settings → Change site name → `gic-apprentice` to get `https://gic-apprentice.netlify.app`.

---

## Step 7 — Smoke test

Open the Netlify URL. **Hard-refresh (Cmd+Shift+R)** — browser cache always bites the first time.

### Test as admin (Julius)
1. Log in as `julius@globalinvestmentcompanies.com`
2. Dashboard shows Module 1 with a small **"Drafted · Awaiting Review"** badge
3. Click into Module 1 — all 7 lessons should render, footer says "Drafted · Awaiting Cathy Jackson-Gent's review"
4. Quiz at the end — take it, confirm scoring works
5. Header shows an **Admin** link — click it. You should see all 30 modules with status filters.

### Test as approver (Cathy)
1. Sign out, log in as `cathy@globalinvestmentcompanies.com`
2. Open Module 1 → at the bottom you should see an **Approve Module** button (only Cathy sees this)
3. Click it → status flips to `approved`, badge disappears, footer changes to *"Reviewed and approved by Cathy Jackson-Gent, Global Investment Company."*

### Test as apprentice
1. Sign out, create a third account at any email (not `@globalinvestmentcompanies.com`)
2. Dashboard should only show Module 1 (the one Cathy approved). Modules 2–30 are hidden because they're still drafts.

If all three pass — you're live.

---

## What's intentionally NOT in Session 1

These are scoped for Session 2 onward, deferred so we can ship something demo-able first:

- **Video recording uploads** (DO Spaces + presigner Netlify Function) — needs the DO Spaces secret pasted into Netlify env vars
- **OpenAI suggestion sidebar** (in-module "explain this differently" / "give me an example") — needs a fresh OpenAI key
- **Employer-token sponsorship** — apprentices entering a code that ties them to a sponsoring employer
- **Mentor sign-off workflow** on competencies
- **Modules 2–30 content** — Module 1 is the quality benchmark; the rest get built in subsequent sessions

---

## When something breaks

**"Setup needed" screen on first load**
→ `window.GIC_CONFIG` didn't load. Check `index.html` is at the repo root and Netlify's publish directory is `.`.

**Login works but dashboard is empty**
→ Modules table is empty. Re-run `sql/supabase_setup.sql`.

**Cathy doesn't see the Approve button**
→ Her profile role didn't get set to `approver`. Check:
```sql
select email, role from profiles where email = 'cathy@globalinvestmentcompanies.com';
```
If role is `apprentice`, run:
```sql
update profiles set role = 'approver' where email = 'cathy@globalinvestmentcompanies.com';
```

**Module 1 shows but lessons are blank**
→ `module1_content.sql` didn't run. Re-run it. The script is idempotent.

**Browser shows old version after deploy**
→ Hard-refresh: Cmd+Shift+R (Mac) / Ctrl+Shift+R (Win). Always the first thing to try.
