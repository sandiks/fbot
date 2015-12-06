class SetupController < ApplicationController
  get "/setup" do
    forums = Forum.all
    respond_to(:html, ForumsListView.new(forums).set_view)
  end

  get "/setup/:sid/forums" do |params|
    unless params.empty?
      forums = Forum.site_forums(params["sid"])
      respond_to(:html, ForumsListView.new(forums).set_view)
    else
      redirect_to "/"
    end
  end
end
