resource "github_branch_protection" "ironpeak--be_master" {
  branch                 = "master"
  enforce_admins         = false
  etag                   = "W/\"708e3e2b032a558a996be3595d847c9e\""
  id                     = "ironpeak.be:master"
  repository             = "${github_repository.ironpeak--be.name}"
  require_signed_commits = false

  required_status_checks {
    include_admins = false
    strict         = true
  }
}