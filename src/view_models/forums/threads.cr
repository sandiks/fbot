class ForumThreadsView < Amatista::BaseView
  def initialize(@forums, @threads, @sid, @fname)
  end

  set_ecr "forums/threads"
end
