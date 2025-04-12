class GithubCreateCommentAction < GithubBase
  def initialize(repo:, pr_number:, body:)
    super(repo: repo)
    @pr_number = pr_number
    @body = body
  end

  def call
    @client.add_comment(@repo, @pr_number, @body)
  end
end
