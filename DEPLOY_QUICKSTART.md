# 🚀 Quick Start: Deploy to GitHub Pages

## Step 1: Enable GitHub Pages

1. Go to https://github.com/BhumiLodaya/Nova-SugarGuard/settings/pages
2. Under **Source**, select:
   - Branch: `gh-pages`
   - Folder: `/ (root)`
3. Click **Save**

## Step 2: Enable GitHub Actions Permissions

1. Go to https://github.com/BhumiLodaya/Nova-SugarGuard/settings/actions
2. Scroll to **Workflow permissions**
3. Select: ☑️ **Read and write permissions**
4. Click **Save**

## Step 3: Push to Deploy

```bash
# Commit all changes
git add .
git commit -m "Setup GitHub Pages deployment"

# Push to main branch
git push origin main
```

## Step 4: Wait for Deployment

1. Go to https://github.com/BhumiLodaya/Nova-SugarGuard/actions
2. Watch the "Deploy to GitHub Pages" workflow run
3. Once complete (✅ green checkmark), your site is live!

## Your Live Site

**URL**: https://BhumiLodaya.github.io/Nova-SugarGuard/

## What Happens Automatically?

Every time you push to `main`:
1. ✅ GitHub Actions triggers
2. ✅ Flutter web app builds with correct base-href
3. ✅ Deploys to `gh-pages` branch
4. ✅ Your live site updates in 2-3 minutes!

## Files Created

```
.github/workflows/deploy.yml    ← GitHub Actions workflow
web/.nojekyll                   ← Prevents Jekyll processing
DEPLOYMENT.md                   ← Full deployment guide
```

## Verify Everything Works

After deployment, check that:
- [ ] Page loads at https://BhumiLodaya.github.io/Nova-SugarGuard/
- [ ] Title shows "Beat the Sugar Spike"
- [ ] iPhone 16 frame displays correctly
- [ ] No 404 errors in browser console

## Troubleshooting

**Issue**: Page not loading?
- Wait 5 minutes for first deployment
- Clear browser cache (Ctrl+Shift+R)
- Check Actions tab for errors

**Issue**: Assets not loading?
- Verify workflow used `--base-href="/Nova-SugarGuard/"`
- Check browser console for paths

**Issue**: Workflow not running?
- Verify Actions are enabled in Settings
- Check workflow permissions are set to "Read and write"

---

**Need help?** Read the full guide: [DEPLOYMENT.md](DEPLOYMENT.md)
