class ForumsController < ApplicationController
  get "/" do
    forums = Forum.all
    respond_to(:html, ForumsIndexView.new(forums).set_view)
  end

  get "/site/:sid/forums" do |params|
    unless params.empty?
      # forums = Forum.site_forums(params["sid"])
      # ff = ["id", "forum title"]
      ff = {"forum": " forum title"}
      forums = [ff]*10
      respond_to(:html, ForumsIndexView.new(forums).set_view)
    else
      forums = Forum.all
      respond_to(:html, ForumsIndexView.new(forums).set_view)
    end
  end
end