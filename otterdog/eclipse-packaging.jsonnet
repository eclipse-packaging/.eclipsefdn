local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.packaging', 'eclipse-packaging') {
  settings+: {
    blog: "https://eclipse.dev/packaging",
    description: "Defines Eclipse IDE products for the main Eclipse download page.",
    email: "epp-dev@eclipse.org",
    name: "Eclipse Packaging Project",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/packaging/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "General content for the eclipse-packaging organization.",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('packages') {
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "Eclipse IDE product definitions.",
      has_discussions: true,
      has_wiki: false,
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: 0,
        },
      ],
    },
  ],
}
