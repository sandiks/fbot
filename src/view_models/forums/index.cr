class ForumsIndexView < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "forums/index"
end
