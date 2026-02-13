# ✅ GitHub Pages Deployment Checklist

Use this checklist to ensure your GitHub Pages deployment is set up correctly.

## Before First Deployment

### Repository Settings

- [ ] Repository name is correct: `Nova-SugarGuard`
- [ ] Repository visibility is set correctly (Public recommended for GitHub Pages)
- [ ] Repository URL: https://github.com/BhumiLodaya/Nova-SugarGuard

### GitHub Pages Configuration

- [ ] Go to Settings → Pages
- [ ] Source is set to `gh-pages` branch
- [ ] Folder is set to `/ (root)`
- [ ] Save button clicked

### GitHub Actions Configuration

- [ ] Go to Settings → Actions → General
- [ ] Workflow permissions set to "Read and write permissions"
- [ ] "Allow GitHub Actions to create and approve pull requests" is enabled (if needed)
- [ ] Save button clicked

### Files Created

- [ ] `.github/workflows/deploy.yml` exists
- [ ] `web/.nojekyll` exists
- [ ] `DEPLOYMENT.md` exists
- [ ] `DEPLOY_QUICKSTART.md` exists

### Verify File Contents

- [ ] Workflow uses correct base-href: `/Nova-SugarGuard/`
- [ ] Repository name in workflow matches actual repo name
- [ ] Workflow triggers on push to `main` branch

## First Deployment

### Git Commands

- [ ] All files committed:
  ```bash
  git add .
  git commit -m "Setup GitHub Pages deployment"
  ```

- [ ] Pushed to main branch:
  ```bash
  git push origin main
  ```

### Monitor Deployment

- [ ] Go to Actions tab: https://github.com/BhumiLodaya/Nova-SugarGuard/actions
- [ ] "Deploy to GitHub Pages" workflow is running
- [ ] Workflow completes successfully (green checkmark ✅)
- [ ] Check logs for any errors

### Verify gh-pages Branch

- [ ] `gh-pages` branch was created automatically
- [ ] Branch contains `index.html` and other web assets
- [ ] Files are in root directory (not in a subfolder)

## After Deployment

### Test Live Site

- [ ] Open: https://BhumiLodaya.github.io/Nova-SugarGuard/
- [ ] Page loads without errors
- [ ] Title shows "Beat the Sugar Spike"
- [ ] iPhone 16 frame displays correctly
- [ ] Dynamic Island notch visible
- [ ] App is responsive

### Browser Console Check

- [ ] Open browser DevTools (F12)
- [ ] No 404 errors for assets
- [ ] No CORS errors
- [ ] No JavaScript errors
- [ ] All images load correctly

### PWA Features

- [ ] Manifest loads: Check Network tab for `manifest.json`
- [ ] Icons load: Check `icons/Icon-192.png` and `icons/Icon-512.png`
- [ ] Service worker registers (if applicable)
- [ ] App can be installed as PWA (optional)

### Branding Check

- [ ] Page title: "Beat the Sugar Spike" ✓
- [ ] Manifest name: "Beat the Sugar Spike" ✓
- [ ] Manifest short_name: "Sugar Spike" ✓
- [ ] Manifest description: "Track your sugar. Break the cycle." ✓

## Ongoing Maintenance

### Regular Deployments

- [ ] Push to main branch triggers automatic deployment
- [ ] Deployment completes in 2-3 minutes
- [ ] Live site updates correctly

### Troubleshooting

If issues occur:

**White Screen**
- [ ] Check browser console for errors
- [ ] Verify base-href is correct
- [ ] Clear browser cache (Ctrl+Shift+R)
- [ ] Wait 5 minutes and try again

**404 Errors**
- [ ] Verify Assets are in correct paths
- [ ] Check build/web structure in gh-pages branch
- [ ] Ensure base-href matches repository name

**Workflow Fails**
- [ ] Check Actions tab for error logs
- [ ] Verify Flutter version compatibility
- [ ] Check if dependencies are up to date
- [ ] Verify GitHub Actions permissions

**Changes Not Reflecting**
- [ ] Clear browser cache
- [ ] Check if workflow completed successfully
- [ ] Wait a few minutes for CDN propagation
- [ ] Try incognito/private browsing mode

## Optional Enhancements

### Custom Domain (Optional)

- [ ] Domain purchased and configured
- [ ] CNAME file added to `web/CNAME`
- [ ] DNS records configured (A or CNAME)
- [ ] HTTPS enabled in GitHub Pages settings
- [ ] Domain verified and working

### Performance Optimization

- [ ] Enable caching in workflow
- [ ] Minify assets (already done by Flutter)
- [ ] Optimize images in `web/icons/`
- [ ] Test on Lighthouse/PageSpeed

### Monitoring

- [ ] Set up GitHub notifications for failed workflows
- [ ] Monitor GitHub Actions usage
- [ ] Check deployment logs regularly
- [ ] Test on different browsers/devices

## Success Criteria ✨

Your deployment is successful when:

- ✅ Site loads at https://BhumiLodaya.github.io/Nova-SugarGuard/
- ✅ No console errors
- ✅ All assets load correctly
- ✅ Branding is correct ("Beat the Sugar Spike")
- ✅ App is functional and responsive
- ✅ Automatic deployments work on push to main

---

## Need Help?

1. **Quick Start**: [DEPLOY_QUICKSTART.md](DEPLOY_QUICKSTART.md)
2. **Full Guide**: [DEPLOYMENT.md](DEPLOYMENT.md)
3. **Main README**: [README.md](README.md)
4. **GitHub Issues**: https://github.com/BhumiLodaya/Nova-SugarGuard/issues

---

**Last Updated**: February 2026
