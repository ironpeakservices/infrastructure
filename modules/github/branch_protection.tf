/*
resource "github_branch_protection" "ironpeak--be_master" {
  branch                 = "master"
  enforce_admins         = false
  repository             = github_repository.ironpeak--be.name
  require_signed_commits = false

  required_status_checks {
    strict = true
  }
}
*/