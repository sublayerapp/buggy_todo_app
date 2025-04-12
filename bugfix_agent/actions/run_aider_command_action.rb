class RunAiderCommandAction < Sublayer::Actions::Base
  def initialize(message:, model: "gemini/gemini-2.0-flash")
    @message = message
    @model = model
  end

  def call
    stdout, stderr, status = Open3.capture3(
      "aider",
      "--message", @message,
      "--model", @model,
      "--yes",
      "--auto-test",
      "CLAUDE.md"
    )

    [stdout, stderr, status]
  end
end
