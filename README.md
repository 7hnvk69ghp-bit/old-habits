# Old Habits — real hosted version

This is the same app you tested inside Claude, converted to run as a real, independently
hosted website with its own database. Nothing about how it works has changed — same
points system, same store credit, same admin panel, same password.

## What changed under the hood
Claude's built-in storage has been replaced with **Supabase** (a free, hosted database).
Everything else in the code is identical.

## 1. Create your database (Supabase)
1. Go to https://supabase.com and create a free account and a new project.
2. Once it's created, go to the **SQL Editor** in the left sidebar, click **New query**,
   paste in the contents of `supabase/schema.sql` (in this folder), and click **Run**.
3. Go to **Project Settings → API**. You'll need two values from this page in a minute:
   - **Project URL**
   - **anon public** key

## 2. Add your database keys to this project
1. In this folder, make a copy of `.env.example` and rename the copy to `.env`.
2. Open `.env` and paste in your Project URL and anon key from step 1.
3. Never share this `.env` file publicly or commit it to a public GitHub repo — treat it
   like a password.

## 3. Test it on your own computer (optional, but recommended)
If you have Node.js installed:
```
npm install
npm run dev
```
This opens the app locally so you can confirm everything works before deploying.

## 4. Deploy it for real (Vercel)
1. Go to https://vercel.com and create a free account.
2. Create a new project. The easiest way is to push this folder to a GitHub repository
   and import it into Vercel — Vercel will detect it's a Vite project automatically.
3. Before deploying, add your two Supabase values as **Environment Variables** in
   Vercel's project settings, using the exact same names as in `.env`:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Click Deploy. Vercel gives you a working link immediately (something like
   `old-habits.vercel.app`).

## 5. Connect your own domain
In Vercel, go to your project → **Settings → Domains**, and add the domain you bought
(e.g. `oldhabits.com`). Vercel will show you exactly what DNS records to add at wherever
you bought the domain (Namecheap, GoDaddy, etc.) — usually one or two records, and it's
live within a few minutes to a few hours.

## Notes
- The `ADMIN_PASSWORD_HASH` in `src/App.jsx` is unchanged — it's still `ENUTTAL67`,
  stored as a scrambled hash, same as before.
- Your Square payment link, once you save it in Manage Store → Payments, is now stored
  in your real Supabase database, not Claude's storage — it'll persist properly here.
- If you ever want to look at your raw data (customers, orders, etc.) directly, Supabase's
  dashboard has a **Table Editor** where you can see and even manually edit the
  `app_storage` table.
