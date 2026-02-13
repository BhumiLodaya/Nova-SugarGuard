# GitHub Pages Deployment Guide

This repository is configured to automatically deploy to GitHub Pages using GitHub Actions.

## 🚀 Automatic Deployment

Every push to the `main` branch triggers an automatic deployment to:

**Live URL**: https://BhumiLodaya.github.io/Nova-SugarGuard/

## 📋 Setup Instructions

### 1. Enable GitHub Pages

1. Go to your repository on GitHub: https://github.com/BhumiLodaya/Nova-SugarGuard
2. Click **Settings** → **Pages**
3. Under "Source", select:
   - Branch: `gh-pages`
   - Folder: `/ (root)`
4. Click **Save**

### 2. Verify GitHub Actions

1. Go to **Settings** → **Actions** → **General**
2. Under "Workflow permissions", select:
   - ☑️ **Read and write permissions**
3. Click **Save**

### 3. Push to Deploy

```bash
git add .
git commit -m "Deploy to GitHub Pages"
git push origin main
```

The GitHub Actions workflow will automatically:
- Build the Flutter web app
- Deploy to the `gh-pages` branch
- Your site will be live in 2-3 minutes!

## 🔍 Check Deployment Status

1. Go to **Actions** tab in your repository
2. You'll see the "Deploy to GitHub Pages" workflow running
3. Once complete (green checkmark ✅), your site is live!

## 🛠️ Manual Deployment (Alternative)

If you prefer to deploy manually:

```bash
# Build the web app
flutter build web --release --base-href="/Nova-SugarGuard/"

# Install gh-pages package (one time only)
npm install -g gh-pages

# Deploy
gh-pages -d build/web
```

## 📱 Branding

The web app already includes proper "Beat the Sugar Spike" branding:
- ✅ Page title: "Beat the Sugar Spike"
- ✅ App name in manifest.json
- ✅ iPhone 16-style frame with Dynamic Island
- ✅ Proper meta tags and PWA configuration

## 🐛 Troubleshooting

### Issue: Assets not loading (404 errors)

**Solution**: Ensure `--base-href` matches your repository name:
```bash
flutter build web --release --base-href="/Nova-SugarGuard/"
```

### Issue: White screen after deployment

**Solution**: Clear browser cache and check:
1. The `gh-pages` branch exists
2. GitHub Pages is enabled in Settings
3. Wait 2-3 minutes for propagation

### Issue: GitHub Actions workflow not running

**Solution**:
1. Check if GitHub Actions is enabled in Settings
2. Verify workflow permissions are set to "Read and write"
3. Check the Actions tab for error logs

## 📂 Repository Structure

```
.github/
  workflows/
    deploy.yml       # GitHub Actions workflow
web/
  index.html         # Entry point with branding
  manifest.json      # PWA configuration
  .nojekyll          # Prevents Jekyll processing
```

## 🔄 Workflow Details

The GitHub Actions workflow (`.github/workflows/deploy.yml`):
1. Triggers on push to `main` branch
2. Sets up Flutter environment
3. Installs dependencies
4. Builds web app with correct base-href
5. Deploys to `gh-pages` branch automatically

## 🌐 Custom Domain (Optional)

To use a custom domain:

1. Add your domain to `web/CNAME` file
2. Update the workflow's `cname` field
3. Configure DNS with your domain provider

## 📊 Viewing Deployment Logs

```bash
# View last deployment status
git log gh-pages -1

# View GitHub Actions logs
# Go to: https://github.com/BhumiLodaya/Nova-SugarGuard/actions
```

---

**Note**: The first deployment may take 5-10 minutes. Subsequent deployments are faster (2-3 minutes).
