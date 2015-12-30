class ForumsNav2View < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "forums/nav2"
end

class ForumsNavView < Amatista::BaseView
  def initialize(@sid, @forums)
  end

  set_ecr "forums/nav"
end

class SiteForumsGroupsView < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "forums/list"
end

class ForumsListView < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "forums/list"
end

class GroupedAllThreadsView < Amatista::BaseView
  def initialize(@mforums, @mforums_threads)
  end

  set_ecr "forums/grouped_all_threads"
end

class GroupedThreadsView < Amatista::BaseView
  def initialize(@site_group, @group_threads)
  end

  set_ecr "forums/grouped_threads"
end

class ForumThreadsView < Amatista::BaseView
  def initialize(@forums, @threads, @sid, @fname)
  end

  set_ecr "forums/threads"
end
