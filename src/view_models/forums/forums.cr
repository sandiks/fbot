class ForumsListView < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "forums/forums"
end

class ForumsListOneLevelView < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "forums/forums1"
end
