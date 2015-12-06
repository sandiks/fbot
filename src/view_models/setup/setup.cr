class SetupForumsView < Amatista::BaseView
  def initialize(@forums)
  end

  set_ecr "setup/forums"
end
