class ForumsController < ApplicationController
  get "/" do
    forums = Forum.all
    respond_to(:html, ForumsIndexView.new(forums).set_view)
  end

  get "/site/:sid/forums" do |params|
    unless params.empty?
      forums = Forum.site_forums(params["sid"])
      # ff = ["id", "forum title"]
      # forums = [{"forum": " forum title"}]*100
      respond_to(:html, ForumsIndexView.new(forums).set_view)
    else
      forums = Forum.all
      respond_to(:html, ForumsIndexView.new(forums).set_view)
    end
  end

  get "/rsn/forums" do |params|
    forums = Forum.site_forums(2)
    respond_to(:html, ForumsListView.new(forums).set_view)
  end

  get "/lor/forums" do |params|
    forums = Forum.site_forums(3)
    respond_to(:html, ForumsListOneLevelView.new(forums).set_view)
  end

  get "/rsn/forum/:fid" do |params|
    forums = Forum.site_forums(2)
    unless params.empty?
      threads = Forum.site_threads(2, params["fid"])
      fname = Forum.forum_name(2, params["fid"])
      respond_to(:html, ForumThreadsView.new(forums, threads, 2, fname).set_view)
    else
      redirect_to "/"
    end
  end
  get "/lor/forum/:fid" do |params|
    forums = Forum.site_forums(3)
    unless params.empty?
      threads = Forum.site_threads(3, params["fid"])
      fname = Forum.forum_name(3, params["fid"])
      respond_to(:html, ForumThreadsView.new(forums, threads, 3, fname).set_view)
    else
      redirect_to "/"
    end
  end
end
