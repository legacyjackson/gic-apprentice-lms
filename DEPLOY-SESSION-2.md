# Deploy Guide — Session 2

Session 2 adds video recording uploads, an AI study coach, employer-token enrollment, and the mentor sign-off workflow. This builds on top of Session 1 — you must have that running first.

**Total time: ~30 minutes** (most of it is pasting env vars).

---

## Step 1 — Run the SQL migration

1. https://supabase.com/dashboard/project/selcyohawrwfmmnsvnwx → SQL Editor → New query
2. Paste all of `sql/session2_setup.sql`
3. Click **Run**
4. Verify:
   ```sql
   select table_name from information_schema.tables
    where table_schema = 'public'
      and table_name in ('employer_sponsors','sponsorship_tokens','competency_submissions');
   ```
   You should see all three tables. Also verify the `mentor` role:
   ```sql
   select unnest(enum_range(null::user_role));
   ```
   You should see `apprentice, admin, approver, mentor`.

The script is idempotent — safe to re-run.

---

## Step 2 — Set Netlify environment variables

Netlify dashboard → your site → **Site settings → Environment variables → Add a variable**. Paste each one. Do NOT paste any of these into a chat.

| Variable | Value | Where to get it |
|---|---|---|
| `SUPABASE_URL` | `https://selcyohawrwfmmnsvnwx.supabase.co` | already known |
| `SUPABASE_SERVICE_ROLE_KEY` | (long string) | Supabase → Project Settings → API → `service_role` key. **Secret.** |
| `DO_SPACES_KEY` | `DO00VZZDK8UVFVRLU83G` | DO control panel (already issued) |
| `DO_SPACES_SECRET` | (your secret) | DO control panel — the secret that pairs with the key above |
| `DO_SPACES_BUCKET` | `gic-apprentice` | already named |
| `DO_SPACES_REGION` | `sfo3` | already chosen |
| `OPENAI_API_KEY` | `sk-…` | platform.openai.com → API keys → Create new |
| `OPENAI_MODEL` | `gpt-4o-mini` | leave as default unless you want to upgrade |

After saving, trigger a deploy: **Deploys → Trigger deploy → Deploy site**. Functions only pick up new env vars after a redeploy.

---

## Step 3 — Push the new files to GitHub

To `legacyjackson/gic-apprentice-lms`, upload via the web editor:

- Update at the root:
  - `index.html` (full replacement — 2,944 lines now)
  - `package.json` (now v0.2.0 with AWS SDK + Supabase deps)
- New folder `netlify/functions/`:
  - `sign-upload.js`
  - `sign-read.js`
  - `ai-coach.js`
  - `enroll-apprentice.js`
- New file in `sql/`:
  - `session2_setup.sql`

Commit. Netlify will detect the functions, install dependencies, and redeploy automatically.

---

## Step 4 — Configure DO Spaces CORS

The browser will PUT video files directly to DO Spaces, so the bucket needs CORS configured to accept your domain.

1. DigitalOcean → Spaces → `gic-apprentice` → **Settings → CORS Configurations**
2. Add a rule:
   - **Origin:** `https://gic-apprentice.netlify.app` (and later `https://learn.globalinvestmentcompanies.com`)
   - **Allowed Methods:** `GET`, `PUT`
   - **Allowed Headers:** `*`
   - **Access-Control Max Age:** `3600`
3. Save

Without this, uploads will fail with a CORS error in the browser console.

---

## Step 5 — Create a mentor account

Mentors aren't auto-promoted by email like Cathy and you are. Add one manually:

1. Supabase → Authentication → Users → **Add user → Create new user**
2. Email/password, check **Auto Confirm User**, create
3. In SQL editor:
   ```sql
   update profiles
      set role = 'mentor',
          full_name = 'Mentor Name Here'
    where email = 'mentor@example.com';
   ```
4. Assign apprentices to this mentor. For each apprentice:
   ```sql
   update profiles
      set mentor_id = (select id from profiles where email = 'mentor@example.com')
    where email = 'apprentice@example.com';
   ```

Now when the mentor signs in, they'll see a **Mentor** tab in the header with their mentees' submissions.

---

## Step 6 — End-to-end demo path

Use this for the pitch. About 5 minutes.

**As Julius (admin):**
1. Sign in → header shows Admin + Sponsors
2. Click **Sponsors → Add sponsor**: name = "Acme Wealth Management", contact info, save
3. On the new sponsor card, click **Generate code**: max_uses = 1, no expiry
4. Copy the `GIC-XXXX-XXXX` token

**As a new apprentice (private window):**
1. At the login page click **"Have a sponsorship code?"**
2. Paste the code → live preview shows "Sponsored by Acme Wealth Management ✓"
3. Fill in full name, email, password → **Create account & sign in**
4. Dashboard loads showing Module 1
5. Click into Module 1 → header shows **Coach** button
6. Click **Coach** → quick prompt "Give me a real-world example" → AI responds in context
7. Walk through a couple of lessons, mark complete
8. Scroll past quiz to **On-the-Job Demonstration** card → **Record submission**
9. Allow camera/mic → record 10 seconds talking about budgeting → stop → preview → add notes → Submit
10. Upload progress bar → success

**As the mentor (another private window):**
1. Sign in → Mentor tab → submission shows under "Pending review"
2. Click in → video plays from signed URL
3. Add feedback → set OJL hours = 1 → **Approve & credit**
4. Apprentice's view updates in real-time (their submission card flips to "Approved · 1h credited")

**As Cathy:**
1. Open Module 1 → footer still shows "Reviewed and approved by Cathy Jackson-Gent" (Session 1 behavior unchanged)

If all of that works, the pitch is demo-ready.

---

## When something breaks

**Upload fails with "Failed to fetch" / CORS error**
→ Step 4. DO Spaces CORS needs the Netlify origin.

**Functions return 500 "OPENAI_API_KEY not configured" / similar**
→ Env vars need to be set then site re-deployed. Vars don't apply to running functions until next deploy.

**Apprentice gets "That code is invalid, expired, or already used"**
→ Either max_uses is exhausted, expires_at passed, or token typo. Check `sponsorship_tokens` table.

**Mentor's dashboard is empty even though submissions exist**
→ Apprentice isn't linked to mentor. `update profiles set mentor_id = ... where email = ...`

**Coach button doesn't appear**
→ Coach only shows when you're inside a module (view='module'). Open a module first.

**Video plays for apprentice but not mentor (403)**
→ Check the apprentice's `mentor_id` matches the mentor's profile id.

**Browser cache after deploy**
→ Cmd+Shift+R. Always.
