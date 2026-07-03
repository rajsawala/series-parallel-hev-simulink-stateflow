# How to upload this project to GitHub

## Option A: Upload through browser (easiest)

1. Go to GitHub and sign in.
2. Click **+** in the top-right corner, then choose **New repository**.
3. Repository name suggestion: `series-parallel-hev-simulink-stateflow`.
4. Add description: `Series-Parallel HEV model using MATLAB Simulink, Stateflow, and Simscape.`
5. Choose **Public** if your faculty needs to open the link without access permission. Choose **Private** only if you will invite them.
6. Create the repository.
7. Open the new repository, click **Add file → Upload files**.
8. Drag and drop all files/folders from this unzipped project folder.
9. Click **Commit changes**.
10. Copy the repository URL and submit that link.

## Option B: Upload through Git commands

Open Git Bash / terminal inside this folder and run:

```bash
git init
git add .
git commit -m "Initial commit: Series-Parallel HEV Simulink project"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/series-parallel-hev-simulink-stateflow.git
git push -u origin main
```

Replace `YOUR_USERNAME` with your GitHub username.

## What link to submit

Submit a link like this:

```text
https://github.com/YOUR_USERNAME/series-parallel-hev-simulink-stateflow
```

## Before submitting

- Open the repo in an incognito window if it is public and confirm it opens.
- Check that `model/HEV_2_7_26_copy.slx` is visible.
- Check that `README.md` shows the project description properly.
- Fill missing MIS/email details if needed.
