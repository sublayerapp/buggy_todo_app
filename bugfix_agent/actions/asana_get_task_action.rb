class AsanaGetTaskAction < AsanaBase
  def initialize(task_gid:, **kwargs)
    super(**kwargs)
    @task_gid = task_gid
  end

  def call
    task = @client.tasks.find_by_id(@task_gid)
    task
  end
end
