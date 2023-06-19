local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-packaging') {
  settings+: {
    default_repository_permission: "none",
    dependabot_alerts_enabled_for_new_repositories: false,
    dependabot_security_updates_enabled_for_new_repositories: false,
    dependency_graph_enabled_for_new_repositories: false,
    members_can_change_repo_visibility: true,
    members_can_create_teams: true,
    members_can_delete_repositories: true,
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    security_managers: [],
    two_factor_requirement: false,
    web_commit_signoff_required: false,
  },
  webhooks+: [
    orgs.newWebhook() {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
      url: "https://ci.eclipse.org/packaging/github-webhook/",
    },
  ],
  _repositories+:: [
    orgs.newRepo('packages') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_alerts_enabled: false,
      has_wiki: false,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
    },
  ],
}
