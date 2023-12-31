Postgresql Wiring
-------------------

- adjust 

Admin User Changes
-------------------

Trying to streamline initial setup, so I don't have to manually run queries to give myself admin permissions. This was a scrappy solution for a problem with a lot of possible approaches.

- Add parameter `SLACKERNEWS_ADMIN_USER_EMAILS` to automatically bootstrap
- Update user.ts to check if superadmin bit is overriden by env var, and automatically flip it when fetching a user
- Wire through kots/config.yaml, kots/slackernews-chart.yaml, charts/slackernews/values.yaml, charts/slackernews/templates/slackernews-deployment.yaml
- Test locally with `npm run dev` and with a KOTS deployment in CMX EKS
